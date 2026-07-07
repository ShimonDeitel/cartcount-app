import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [Trip] = []
    @Published var isPro: Bool = false

    /// Free tier allows this many entries. Seed data below is always fewer than this
    /// so a fresh install never opens straight into the paywall.
    static let freeLimit = 20

    private let fileName = "cartcount_items.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([Trip].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    @discardableResult
    func add(_ item: Trip) -> Bool {
        guard canAddMore else { return false }
        items.append(item)
        save()
        return true
    }

    func update(_ item: Trip) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Trip) {
        items.removeAll { $0.id == item.id }
        save()
    }

    static func seedData() -> [Trip] {
        [
        Trip(store: "Trader Joe's", total: 3.5, tripDate: Date().addingTimeInterval(-259200), itemCount: 1, notes: ""),
        Trip(store: "Whole Foods", total: 5.75, tripDate: Date().addingTimeInterval(-518400), itemCount: 2, notes: "Weekly run"),
        Trip(store: "Safeway", total: 8.0, tripDate: Date().addingTimeInterval(-777600), itemCount: 3, notes: ""),
        Trip(store: "Trader Joe's", total: 10.25, tripDate: Date().addingTimeInterval(-1036800), itemCount: 4, notes: "Weekly run")
        ]
    }
}
