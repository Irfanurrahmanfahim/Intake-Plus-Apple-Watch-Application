import SwiftUI

struct AddWaterView: View {
    
    @ObservedObject var viewModel: ConsumptionViewModel
    @State private var selectedWaterAmount: Int = 50 // Default selection at 50ml
    
    //array for water intake values from 50ml to 2000ml, increasing by 50ml
    let waterAmounts = Array(stride(from: 50, through: 2000, by: 50))

    var body: some View {
        VStack(spacing: 8) {
           Text("Add Water Intake")
                .font(.headline)
                .foregroundColor(.white)
               .padding(.top, 5)

            //Water intake amount selection picker
            Picker("Select Water Amount", selection: $selectedWaterAmount) {
                ForEach(waterAmounts, id: \.self) { amount in
                    Text("\(amount) ml")
                        .font(.system(size: 16, weight: .heavy))
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 80)
            
            
            //add Water Button
            Button(action: {
                viewModel.addEntry(type: "Water", name: "Water", amount: Double(selectedWaterAmount) / 1000)
            }) {
                Text("Add Water")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 5)
        }
        .padding(.horizontal, 10)
    }
}


#Preview {
    AddWaterView(viewModel: ConsumptionViewModel())
}
