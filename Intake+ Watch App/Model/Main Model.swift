import Foundation


//main ConsumptionEntry model
struct ConsumptionEntry: Identifiable, Codable {
    let id: UUID
    let type: String // "Food" or "Water"
    let name: String
    let amount: Double // Calories for food, Liters for water
    let timestamp: Date

    init(type: String, name: String, amount: Double) {
        self.id = UUID()
        self.type = type
        self.name = name
        self.amount = amount
        self.timestamp = Date()
    }
}
