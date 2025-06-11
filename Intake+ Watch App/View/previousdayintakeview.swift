import SwiftUI

struct PreviousDayIntakeView: View {
    @ObservedObject var viewModel: ConsumptionViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text("Previous Day's")
            Text("Intake Data")
                .foregroundColor(.primary)
            
//show previous day water intake
            VStack(spacing: 8) {
                VStack {
                    Text("Water Intake:")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Spacer()
                    Text("\(viewModel.previousDayWaterIntake, specifier: "%.2f") Liters")
                        .font(.body)
                        .foregroundColor(.blue)
                }
                
                Divider()

//show previous day calorie intake
                VStack {
                    Text("Calorie Intake:")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                    Spacer()
                    Text("\(viewModel.previousDayCalorieIntake, specifier: "%.0f") Calories")
                        .font(.body)
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.all, 16)
    }
}

