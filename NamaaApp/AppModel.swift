//
//  AppModel.swift
//  NamaaApp
//
//  Created by Assistant on 02/12/2025.
//

import SwiftUI
import Combine

enum ChildLevel: String, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"

    var id: String { rawValue }
}

enum TaskRating: String, CaseIterable, Identifiable {
    case done = "Done"
    case doneWithHelp = "Done with help"
    case didntDo = "Didn't do"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .done: return "🙂"
        case .doneWithHelp: return "😐"
        case .didntDo: return "☹️"
        }
    }

    // Numeric score for averaging
    var score: Double {
        switch self {
        case .done: return 1.0
        case .doneWithHelp: return 0.5
        case .didntDo: return 0.0
        }
    }
}

struct TaskItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let category: String
    let icon: String
    var isCompleted: Bool = false
    var rating: TaskRating? = nil
    var note: String? = nil
    var completedAt: Date? = nil
}

struct HistoryEntry: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let taskTitle: String
    let category: String
    let rating: TaskRating
    let note: String?
}

// Archive of a day’s completed entries
struct DailyLog: Identifiable, Hashable {
    let id = UUID()
    let date: Date // start-of-day
    let entries: [HistoryEntry]
}

final class AppModel: ObservableObject {
    // Tab selection: 0 = Home, 1 = Progress, 2 = Settings
    @Published var selectedTab: Int = 0

    @Published var parentName: String = ""
    @Published var childName: String = ""
    @Published var selectedSkills: Set<Skill> = []
    @Published var childLevel: ChildLevel = .beginner
    @Published var todayTasks: [TaskItem] = []
    @Published var lastGeneratedDate: Date? = nil

    // Track last time celebration was shown to avoid repeating the same day
    @Published var lastCelebrationDate: Date? = nil

    // In-memory history for today
    @Published var todayHistory: [HistoryEntry] = []

    // Archive of previous days
    @Published var pastDays: [DailyLog] = []

    func ensureTasksForToday() {
        let calendar = Calendar.current
        if let last = lastGeneratedDate, calendar.isDateInToday(last) {
            return
        }
        // New day: reset history and tasks
        todayHistory = []
        generateTodayTasks()
        lastGeneratedDate = Date()
        lastCelebrationDate = nil
    }

    func generateTodayTasks() {
        let skillsArray = orderedSelectedSkills()

        // Always produce exactly 4 tasks
        let desiredCount = 4

        // If no selected skills, fallback to defaults
        guard !skillsArray.isEmpty else {
            todayTasks = defaultTasks(count: desiredCount)
            return
        }

        var tasks: [TaskItem] = []
        var skillIndex = 0
        while tasks.count < desiredCount {
            let skill = skillsArray[skillIndex % skillsArray.count]
            let titles = catalog(for: skill)
            // to avoid repeating the same first title, pick a title offset by tasks.count
            let title = titles[(tasks.count) % titles.count]
            let icon: String = skill.systemImage
            tasks.append(TaskItem(title: title, category: skill.title, icon: icon))
            skillIndex += 1
        }

        todayTasks = tasks
    }

    private func orderedSelectedSkills() -> [Skill] {
        // Stable order by title to avoid randomness and duplicates
        Array(selectedSkills).sorted { $0.title < $1.title }
    }

    private func catalog(for skill: Skill) -> [String] {
        switch skill.systemImage {
        case "brain.head.profile":
            return ["Memory Match", "Shape Sorting", "Pattern Finder", "Number Hunt", "Color Logic"]
        case "bubble.left.and.bubble.right.fill":
            return ["Story Time", "Picture Talk", "Word Builder", "Name That Object", "Rhyme Time"]
        case "person.3.fill":
            return ["Sharing Game", "Turn Taking", "Role Play", "Emotion Match", "Team Builder"]
        case "figure.walk":
            return ["Balance Walk", "Ball Toss", "Finger Trace", "Clap Patterns", "Stretch & Reach"]
        default:
            return ["Daily Activity"]
        }
    }

    func toggleTask(_ task: TaskItem) {
        guard let idx = todayTasks.firstIndex(of: task) else { return }
        todayTasks[idx].isCompleted.toggle()
    }

    func completeTask(_ task: TaskItem, with rating: TaskRating, note: String?) {
        guard let idx = todayTasks.firstIndex(of: task) else { return }
        todayTasks[idx].rating = rating
        todayTasks[idx].isCompleted = true
        todayTasks[idx].note = (note?.isEmpty == true) ? nil : note
        todayTasks[idx].completedAt = Date()

        let entry = HistoryEntry(
            date: Date(),
            taskTitle: todayTasks[idx].title,
            category: todayTasks[idx].category,
            rating: rating,
            note: todayTasks[idx].note
        )
        todayHistory.insert(entry, at: 0)
    }

    var completedCount: Int {
        todayTasks.filter { $0.isCompleted }.count
    }

    var allCompleted: Bool {
        !todayTasks.isEmpty && completedCount == todayTasks.count
    }

    private func defaultTasks(count: Int) -> [TaskItem] {
        let fallback = [
            TaskItem(title: "Story Time", category: "Communication Skills", icon: "bubble.left.and.bubble.right.fill"),
            TaskItem(title: "Memory Match", category: "Cognitive Skills", icon: "brain.head.profile"),
            TaskItem(title: "Team Builder", category: "Social Skills", icon: "person.3.fill"),
            TaskItem(title: "Ball Toss", category: "Motor Skills", icon: "figure.walk")
        ]
        if count <= fallback.count { return Array(fallback.prefix(count)) }
        var arr = fallback
        while arr.count < count { arr.append(contentsOf: fallback) }
        return Array(arr.prefix(count))
    }

    // Average progress for a skill based on ratings of today's tasks in that skill
    func averageProgressForSkill(title: String) -> Double {
        let tasksForSkill = todayTasks.filter { $0.category == title }
        let rated = tasksForSkill.compactMap { $0.rating?.score }
        guard !rated.isEmpty else { return 0.0 }
        let sum = rated.reduce(0.0, +)
        return max(0.0, min(1.0, sum / Double(rated.count)))
    }

    // Friendly daily status derived from ratings
    var dailyStatusText: String {
        let ratings = todayTasks.compactMap { $0.rating }
        guard !ratings.isEmpty else { return "No ratings yet. Start today’s activities!" }

        let ratio = ratings.map { $0.score }.reduce(0, +) / Double(ratings.count)

        switch ratio {
        case 0.75...1.0: return "Great progress today! 🌟"
        case 0.4..<0.75: return "Good effort! Keep going! 💪"
        default: return "Let’s try a bit more. You’ve got this! 👏"
        }
    }

    // Celebration should show only once per day when all tasks are completed
    func shouldShowCelebration() -> Bool {
        guard allCompleted else { return false }
        let cal = Calendar.current
        if let last = lastCelebrationDate, cal.isDateInToday(last) {
            return false
        }
        return true
    }

    func markCelebrationShown() {
        lastCelebrationDate = Date()
    }

    // MARK: - Simulate tomorrow (advance to next calendar day)
    func simulateTomorrow() {
        let cal = Calendar.current
        let todayStart = cal.startOfDay(for: Date())

        // Archive today's history if not empty and not already archived for this date
        if !todayHistory.isEmpty {
            // Prevent duplicate archive if the last archived day already equals today
            if pastDays.last?.date != todayStart {
                let log = DailyLog(date: todayStart, entries: todayHistory)
                pastDays.append(log)
            }
        }

        // Clear today's history and celebration
        todayHistory = []
        lastCelebrationDate = nil

        // Advance the "current" generated day to tomorrow so ensureTasksForToday treats it as a new day
        if let tomorrow = cal.date(byAdding: .day, value: 1, to: Date()) {
            lastGeneratedDate = tomorrow
        } else {
            lastGeneratedDate = Date().addingTimeInterval(24 * 60 * 60)
        }

        // Generate new tasks for the simulated new day
        generateTodayTasks()
    }
}

