import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ConsumptionViewModel()
    
    //fetch targets from UserDefaults
    @AppStorage("waterTarget") private var waterTarget: Double = 2.0
    @AppStorage("caloriesTarget") private var caloriesTarget: Int = 2000
    
    @State private var showingMenu = false
    @State private var showingTargetView = false
    
    var body: some View {
        VStack {
            ZStack {
                
                //blue colour water ring
                CircularProgressView(progress: viewModel.totalWaterIntake() / waterTarget, color: .blue, lineWidth: 15)
                    .frame(width: 180, height: 200)
                
                //yellow colour calories ring
                CircularProgressView(progress: viewModel.totalCalories() / Double(caloriesTarget), color: .yellow, lineWidth: 10)
                    .frame(width: 140, height: 180)
                
                //display values inside rings
                VStack {
                    Text("\(viewModel.totalWaterIntake(), specifier: "%.2f")L ")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.blue)
                    Text("\(viewModel.totalCalories(), specifier: "%.0f") kcal")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            .padding()
            .onTapGesture {
                showingMenu = true
            }
            
        }
        .sheet(isPresented: $showingMenu) {
            MenuView(viewModel: viewModel)
        }
        
    }
}

#Preview {
    ContentView()
}

