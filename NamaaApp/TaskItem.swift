//
//  TaskItem.swift
//  NamaaApp
//

import Foundation

struct TaskItem: Identifiable, Equatable {
    let id: UUID
    var title: String
    var category: String
    var icon: String
    var isCompleted: Bool
    var rating: TaskRating?

    init(id: UUID = UUID(),
         title: String,
         category: String,
         icon: String,
         isCompleted: Bool = false,
         rating: TaskRating? = nil) {
        self.id = id
        self.title = title
        self.category = category
        self.icon = icon
        self.isCompleted = isCompleted
        self.rating = rating
    }
}

