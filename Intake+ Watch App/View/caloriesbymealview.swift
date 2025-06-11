
import Foundation
import SwiftUI

struct ViewCaloriesByMealView: View {
    @ObservedObject var viewModel: ConsumptionViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Calories by Meal")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 5)

                //loop through each meal and show calories
                ForEach(viewModel.mealCalories.keys.sorted(), id: \.self) { meal in
                    HStack {
                        Text(meal)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(viewModel.mealCalories[meal] ?? 0) kcal")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}
