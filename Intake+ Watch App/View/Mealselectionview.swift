import Foundation
import SwiftUI

struct MealSelectionView: View {
    @ObservedObject var viewModel: ConsumptionViewModel
    @State private var selectedMeal = "Breakfast" //default meal
    
    //meal types
    let meals = ["Breakfast", "Lunch", "Dinner", "Snack"]

    
    var body: some View {
        VStack {
            Text("Select Meal")
                .font(.headline)
                .padding(.bottom, 10)

            //picker to select meal type
            Picker("Meal Type", selection: $selectedMeal) {
                ForEach(meals, id: \.self) { meal in
                    Text(meal)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 80)
            .padding()

            NavigationLink("Next", destination: AddCaloriesView(viewModel: viewModel, meal: selectedMeal))
                .buttonStyle(.borderedProminent)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
