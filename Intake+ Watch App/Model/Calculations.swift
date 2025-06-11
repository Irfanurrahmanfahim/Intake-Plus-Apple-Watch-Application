import WidgetKit
import Foundation

class ConsumptionViewModel: ObservableObject {
    
    //declaring all the variables and the storage keys
    @Published var mealCalories: [String: Int] = [:]
    @Published var entries: [ConsumptionEntry] = []
    @Published var waterTarget: Double = 2.0 // Default 2 liters
    @Published var previousDayWaterIntake: Double = 0.0
    @Published var previousDayCalorieIntake: Double = 0.0
    @Published var showingMenu = false
    private let storageKey = "ConsumptionData"
    private let mealCaloriesKey = "MealCaloriesData"
    private let previousDayIntakeKey = "PreviousDayIntake"

    
    //using shared UserDefaults for App Group
        private let sharedDefaults = UserDefaults(suiteName: "group.com.southwales.intake+")
    
    //initializing the application by loading all data
    init() {
        loadEntries()
        loadMealCalories()
        loadPreviousDayIntake()
        resetAtMidnight()
    }
    
    //function to add food and water intake as newEntry
    func addEntry(type: String, name: String, amount: Double) {
        let newEntry = ConsumptionEntry(type: type, name: name, amount: amount)
        entries.append(newEntry)
        saveEntries()
    }
    
    //function to add water intake to daily total water intake
    func totalWaterIntake() -> Double {
        return entries.filter { $0.type == "Water" }.reduce(0) { $0 + $1.amount }
    }
    
    //function to add calories intake to daily total calories intake
    func totalCalories() -> Double {
        return entries.filter { $0.type == "Food" }.reduce(0) { $0 + $1.amount }
    }
    
    //function to add calories to a meal
      func addCalories(meal: String, calories: Int) {
          mealCalories[meal, default: 0] += calories
          saveMealCalories()
      }
    
    //function to save water and calorie intake data
    private func saveEntries() {
           if let encoded = try? JSONEncoder().encode(entries) {
               sharedDefaults?.set(encoded, forKey: storageKey)
               WidgetCenter.shared.reloadAllTimelines() // Notify widget to update
           }
       }

    //function to load water and calorie intake data
    private func loadEntries() {
           if let savedData = sharedDefaults?.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([ConsumptionEntry].self, from: savedData) {
               entries = decoded
           }
       }

       //function to save calories by meal type
       private func saveMealCalories() {
           if let encoded = try? JSONEncoder().encode(mealCalories) {
               sharedDefaults?.set(encoded, forKey: mealCaloriesKey)
               WidgetCenter.shared.reloadAllTimelines() // Notify widget to update
           }
       }

       //function to load Calories by meal type
       private func loadMealCalories() {
           if let savedData = sharedDefaults?.data(forKey: mealCaloriesKey),
              let decoded = try? JSONDecoder().decode([String: Int].self, from: savedData) {
               mealCalories = decoded
           }
       }
    
    //function to save previous day intake
    private func savePreviousDayIntake() {
        let previousDayIntake: [String: Double] = [
            "Water": totalWaterIntake(),
            "Calories": totalCalories()
        ]
        
        sharedDefaults?.set(previousDayIntake, forKey: previousDayIntakeKey)
    }
    
    //function to load previous day intake
    private func loadPreviousDayIntake() {
        if let savedData = sharedDefaults?.dictionary(forKey: previousDayIntakeKey) as? [String: Double] {
            previousDayWaterIntake = savedData["Water"] ?? 0.0
            previousDayCalorieIntake = savedData["Calories"] ?? 0.0
        }
    }
    
        
    //function to reset the application at midnight
    private func resetAtMidnight() {
        let timer = Timer(fire: Calendar.current.nextDate(after: Date(), matching: DateComponents(hour: 0, minute: 0), matchingPolicy: .nextTime)!, interval: 86400, repeats: true) { _ in
            self.previousDayWaterIntake = self.totalWaterIntake()
            self.previousDayCalorieIntake = self.totalCalories()
            self.savePreviousDayIntake()
            self.entries.removeAll()
            self.saveEntries()
            self.mealCalories.removeAll()
            self.saveMealCalories()
            WidgetCenter.shared.reloadAllTimelines()
        }
        RunLoop.main.add(timer, forMode: .common)
    }
}
