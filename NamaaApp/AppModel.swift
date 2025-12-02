//
//  AppModel.swift
//  NamaaApp
//

import SwiftUI
import Combine

final class AppModel: ObservableObject {
    // Existing tasks state
    @Published var todayTasks: [TaskItem] = [
        TaskItem(title: "Daily Story Reading",
                 category: "Communication Skills",
                 icon: "bubble.left.and.bubble.right.fill"),
        TaskItem(title: "Shapes & Colors Game",
                 category: "Cognitive Skills",
                 icon: "brain.head.profile"),
        TaskItem(title: "Group Play Time",
                 category: "Social Skills",
                 icon: "person.3.fill"),
        TaskItem(title: "Hand & Finger Exercises",
                 category: "Motor Skills",
                 icon: "figure.walk")
    ]

    // Missing properties referenced by views
    @Published var parentName: String = ""
    @Published var childLevel: ChildLevel = .beginner
    @Published var selectedSkills: Set<Skill> = []

    // Progress-related properties referenced by views
    @Published var completedCount: Int = 0
    @Published var allCompleted: Bool = false

    func completeTask(_ task: TaskItem, with rating: TaskRating) {
        if let idx = todayTasks.firstIndex(where: { $0.id == task.id }) {
            todayTasks[idx].rating = rating
            todayTasks[idx].isCompleted = true
        }
        // Optionally update progress counts
        completedCount = todayTasks.filter { $0.isCompleted }.count
        allCompleted = completedCount == todayTasks.count && !todayTasks.isEmpty
    }

    // If any view calls this, it’s now safe; otherwise it’s a no-op.
    func ensureTasksForToday() {
        if todayTasks.isEmpty {
            todayTasks = [
                TaskItem(title: "Daily Story Reading",
                         category: "Communication Skills",
                         icon: "bubble.left.and.bubble.right.fill")
            ]
        }
        completedCount = todayTasks.filter { $0.isCompleted }.count
        allCompleted = completedCount == todayTasks.count && !todayTasks.isEmpty
    }
}
