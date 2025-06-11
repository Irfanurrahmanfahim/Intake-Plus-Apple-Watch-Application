import SwiftUI

struct SetTargetView: View {
    
    //set the default values
    @AppStorage("waterTarget") private var waterTarget: Double = 2.0  // Default: 2L
    @AppStorage("caloriesTarget") private var caloriesTarget: Int = 2000  // Default: 2000 kcal
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Set Daily Targets")
                .font(.headline)

            
            //slider to change daily water intake target
            VStack(spacing: 4) {
                Text("Water (L)").font(.caption2)
                Slider(value: $waterTarget, in: 0.5...5.0, step: 0.1)
                    .frame(height: 10)
                    .accentColor(.blue)
                Text("\(waterTarget, specifier: "%.1f") L")
                    .font(.footnote)
                    .bold()
                    .padding(5)
            }
            
            Divider()
            
            //drop-down picker to change daily calories intake target
            VStack(spacing: 4) {
                Text("Calories").font(.caption2)
                Picker("", selection: $caloriesTarget) {
                    //array for calories intake values from 1000 to 4000 kcal, increasing by 100 kcal
                    ForEach(Array(stride(from: 1000, through: 4000, by: 100)), id: \.self) { value in
                        Text("\(value) kcal")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 60)
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    SetTargetView()
}
