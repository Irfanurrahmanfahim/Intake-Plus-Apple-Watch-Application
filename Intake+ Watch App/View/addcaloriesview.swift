import Foundation
import SwiftUI

struct AddCaloriesView: View {
    
    @ObservedObject var viewModel: ConsumptionViewModel
    var meal: String  //meal type passed from MealSelectionView
    @State private var selectedCalories: Int = 50
    @Environment(\.presentationMode) var presentationMode

    //initializing this page & default value
    init(viewModel: ConsumptionViewModel, meal: String) {
           self.viewModel = viewModel
           self.meal = meal
           // Set the initial value of selectedCalories to the current calories for the meal
           _selectedCalories = State(initialValue: viewModel.mealCalories[meal, default: 50])
       }
    
    
    
    var body: some View {
        VStack {
            
            Text("Add Calories for")
                 Text("\(meal)")


            //calories intake amount selection picker
            Picker("Select Calories", selection: $selectedCalories) {
                ForEach(Array(stride(from: 50, through: 2000, by: 50)), id: \.self) { value in
                    Text("\(value) kcal").tag(value)                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 80)

            
            //Add Button to add calories to the total calories and meal calories
            Button(action: {
                viewModel.addCalories(meal: meal, calories: selectedCalories)
                viewModel.addEntry(type: "Food", name: "Food", amount: Double(selectedCalories))
                presentationMode.wrappedValue.dismiss()  // Close sheet
            }) {
                Text("Add Calories")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.all, 10)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddCaloriesView(viewModel: ConsumptionViewModel(), meal: "Breakfast")
}



