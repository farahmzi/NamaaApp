import Foundation

struct DailyLog: Identifiable, Equatable {
    var id: Date { date }
    let date: Date
    var entries: [HistoryEntry]

    init(date: Date, entries: [HistoryEntry]) {
        self.date = date
        self.entries = entries
    }
}
