import Foundation
import SwiftUI


//main menu
struct MenuView: View {
    @ObservedObject var viewModel: ConsumptionViewModel

    var body: some View {
        
        //using a list based navigation in the main menu
        NavigationView {
            List {
                NavigationLink("Add Water", destination: AddWaterView(viewModel: viewModel))
                NavigationLink("Add Calories", destination: MealSelectionView(viewModel: viewModel))
                NavigationLink("View Previous Day Intake", destination: PreviousDayIntakeView(viewModel: viewModel))
                NavigationLink("View Calories by Meal", destination: ViewCaloriesByMealView(viewModel: viewModel))
                NavigationLink("Set Daily Target", destination: SetTargetView())
            }
            .navigationTitle("Menu")
        }
    }
}
