import Foundation

struct HistoryEntry: Identifiable, Equatable {
    let id: UUID
    let date: Date
    let taskTitle: String
    let category: String
    let rating: TaskRating
    let note: String?

    init(id: UUID = UUID(),
         date: Date,
         taskTitle: String,
         category: String,
         rating: TaskRating,
         note: String? = nil) {
        self.id = id
        self.date = date
        self.taskTitle = taskTitle
        self.category = category
        self.rating = rating
        self.note = note
    }
}
