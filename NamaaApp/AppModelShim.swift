import SwiftUI
import Combine

// Shim placeholder to satisfy compilation without changing any existing model files.
// Replace with your real AppModel later if needed.
final class AppModel: ObservableObject {

    // Navigation/tab
    @Published var selectedTab: Int = 0

    // Profile
    @Published var parentName: String = ""
    @Published var childName: String = ""
    @Published var childLevel: ChildLevel = .beginner

    // Skills
    @Published var selectedSkills: Set<Skill> = []

    // Tasks
    @Published var todayTasks: [TaskItem] = []
    @Published var completedCount: Int = 0

    // History
    @Published var todayHistory: [HistoryEntry] = []
    @Published var pastDays: [DailyLog] = []

    // Status text shown in Progress view header
    var dailyStatusText: String {
        if todayTasks.isEmpty { return "Let’s start with some activities today!" }
        let percent = todayTasks.isEmpty ? 0 : Int((Double(completedCount) / Double(todayTasks.count)) * 100)
        return "Today's progress: \(percent)%"
    }

    // MARK: - Stubs to satisfy calls from Views/ViewModels

    func ensureTasksForToday() {
        if todayTasks.isEmpty {
            generateTodayTasks()
        }
    }

    func generateTodayTasks() {
        // Simple demo generation from selected skills
        let base: [TaskItem] = selectedSkills.prefix(3).map { skill in
            TaskItem(title: demoTitle(for: skill),
                     category: skill.title,
                     icon: skill.systemImage,
                     isCompleted: false,
                     rating: nil)
        }
        todayTasks = base
        completedCount = todayTasks.filter { $0.isCompleted }.count
    }

    func completeTask(_ task: TaskItem, with rating: TaskRating, note: String) {
        // Mark task as completed in todayTasks
        if let idx = todayTasks.firstIndex(where: { $0.id == task.id }) {
            todayTasks[idx].isCompleted = true
            todayTasks[idx].rating = rating
        }
        completedCount = todayTasks.filter { $0.isCompleted }.count

        // Append to today's history
        let entry = HistoryEntry(date: Date(),
                                 taskTitle: task.title,
                                 category: task.category,
                                 rating: rating,
                                 note: note.isEmpty ? nil : note)
        todayHistory.append(entry)
    }

    func averageProgressForSkill(title: String) -> Double {
        // Simple average: completed tasks in that category / total tasks in that category
        let tasksInCategory = todayTasks.filter { $0.category == title }
        guard !tasksInCategory.isEmpty else { return 0 }
        let done = tasksInCategory.filter { $0.isCompleted }.count
        return Double(done) / Double(tasksInCategory.count)
    }

    func shouldShowCelebration() -> Bool {
        guard !todayTasks.isEmpty else { return false }
        return completedCount == todayTasks.count && completedCount > 0
    }

    func markCelebrationShown() {
        // No-op in shim
    }

    func simulateTomorrow() {
        // Move today's history into pastDays bucket and reset
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        if !todayHistory.isEmpty {
            let log = DailyLog(date: startOfToday, entries: todayHistory)
            pastDays.append(log)
        }
        todayHistory.removeAll()
        todayTasks.removeAll()
        completedCount = 0
    }

    // MARK: - Helpers

    private func demoTitle(for skill: Skill) -> String {
        switch skill.systemImage {
        case "brain.head.profile": return "Memory Match"
        case "bubble.left.and.bubble.right.fill": return "Story Time"
        case "person.3.fill": return "Team Builder"
        case "figure.walk": return "Move & Play"
        default: return "Activity"
        }
    }
}
