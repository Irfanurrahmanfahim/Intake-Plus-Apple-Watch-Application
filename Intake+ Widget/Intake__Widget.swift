import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), calories: fetchMealCalories(), waterIntake: fetchWaterIntake())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        
        let calories = fetchMealCalories()
        let waterIntake = fetchWaterIntake()
        
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, calories: calories, waterIntake: waterIntake)
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), calories: 0, waterIntake: 0)
    }

    //function to fetch total calories from shared UserDefaults
    func fetchMealCalories() -> Int {
        let sharedDefaults = UserDefaults(suiteName: "group.com.southwales.intake+")
        
        if let savedData = sharedDefaults?.data(forKey: "MealCaloriesData"),
           let decoded = try? JSONDecoder().decode([String: Int].self, from: savedData) {
            return decoded.values.reduce(0, +) // Sum all meal calories
        }
        
        return 0
    }

    //function to fetch total water intake from shared UserDefaults
    func fetchWaterIntake() -> Double {
        let sharedDefaults = UserDefaults(suiteName: "group.com.southwales.intake+")
        
        if let savedData = sharedDefaults?.data(forKey: "ConsumptionData"),
           let decoded = try? JSONDecoder().decode([ConsumptionEntry].self, from: savedData) {
            return decoded.filter { $0.type == "Water" }.reduce(0) { $0 + $1.amount } // Sum only water entries
        }
        
        return 0.0
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let calories: Int
    let waterIntake: Double
}

struct IntakeWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            
            Color.black.opacity(0.2)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 3)

            VStack(spacing: 10) {
                //calories Section
                HStack(spacing: 6) {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                        .font(.system(size: 20, weight: .bold))

                    Text("\(entry.calories) kcal")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }

                Divider().background(Color.white.opacity(0.5))

                //water Intake Section
                HStack(spacing: 6) {
                    Image(systemName: "drop.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 20, weight: .bold))

                    Text("\(entry.waterIntake, specifier: "%.2f") L")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

@main
struct Intake_Widget: Widget {
    let kind: String = "Intake_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            IntakeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Intake Tracker")
        .description("Monitor your daily calories & water intake.")
        .supportedFamilies([.accessoryCircular, .accessoryRectangular, .accessoryInline])
    }
}




