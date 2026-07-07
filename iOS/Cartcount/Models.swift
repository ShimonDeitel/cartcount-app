import Foundation

struct Trip: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var store: String
    var total: Double
    var tripDate: Date
    var itemCount: Int
    var notes: String

    init(id: UUID = UUID(), store: String = "", total: Double = 0.0, tripDate: Date = Date(), itemCount: Int = 0, notes: String = "") {
        self.id = id
        self.store = store
        self.total = total
        self.tripDate = tripDate
        self.itemCount = itemCount
        self.notes = notes
    }
}
