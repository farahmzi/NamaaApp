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

    // Localized display name
    var localizedTitle: LocalizedStringKey {
        switch self {
        case .beginner:
            return "child_level.beginner"
        case .intermediate:
            return "child_level.intermediate"
        case .advanced:
            return "child_level.advanced"
        }
    }
}

enum TaskRating: String, CaseIterable, Identifiable {
    case done = "Done"
    case doneWithHelp = "Done with help"
    case didntDo = "Didn't do"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .done:
            return "🙂"
        case .doneWithHelp:
            return "😐"
        case .didntDo:
            return "☹️"
        }
    }

    // Localized display name
    var localizedTitle: LocalizedStringKey {
        switch self {
        case .done:
            return "task_rating.done"
        case .doneWithHelp:
            return "task_rating.done_with_help"
        case .didntDo:
            return "task_rating.didnt_do"
        }
    }

    // Numeric score for averaging
    var score: Double {
        switch self {
        case .done:
            return 1.0
        case .doneWithHelp:
            return 0.5
        case .didntDo:
            return 0.0
        }
    }
}

struct TaskItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let category: String
    let icon: String
    var steps: [String] = [] // NEW: real steps from TaskBank
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

            // Pull bank for this skill’s category
            let bank = TaskBank.tasks(for: skill)
            guard !bank.isEmpty else {
                // If bank is empty for some reason, push a generic
                let fallback = TaskItem(
                    title: "Daily Activity",
                    category: skill.title,
                    icon: skill.systemImage,
                    steps: ["Start activity", "Do the task", "Wrap up"]
                )
                tasks.append(fallback)
                skillIndex += 1
                continue
            }

            // Stable pseudo-random selection: offset by current tasks.count
            let def = bank[(tasks.count) % bank.count]
            let item = TaskItem(
                title: def.title,
                category: def.category,
                icon: def.icon,
                steps: def.steps
            )
            tasks.append(item)
            skillIndex += 1
        }

        todayTasks = tasks
    }

    private func orderedSelectedSkills() -> [Skill] {
        // Stable order by title to avoid randomness and duplicates
        Array(selectedSkills).sorted { $0.title < $1.title }
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
        // Use one task from each skill with simple steps so app still works without selection
        let fallback = [
            TaskItem(
                title: "Story Time",
                category: "Communication Skills",
                icon: "bubble.left.and.bubble.right.fill",
                steps: ["Read together", "Ask questions", "Encourage answers"]
            ),
            TaskItem(
                title: "Memory Match",
                category: "Cognitive Skills",
                icon: "brain.head.profile",
                steps: ["Explain the game", "Match pairs", "Praise effort"]
            ),
            TaskItem(
                title: "Team Builder",
                category: "Social Skills",
                icon: "person.3.fill",
                steps: ["Invite participation", "Practice turn-taking", "Celebrate sharing"]
            ),
            TaskItem(
                title: "Ball Toss",
                category: "Motor Skills",
                icon: "figure.walk",
                steps: ["Warm-up", "Main movement", "Cool down"]
            )
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

    // Friendly daily status derived from ratings (returns localization key)
    var dailyStatusTextKey: LocalizedStringKey {
        let ratings = todayTasks.compactMap { $0.rating }
        guard !ratings.isEmpty else { return "daily_status.no_ratings" }

        let ratio = ratings.map { $0.score }.reduce(0, +) / Double(ratings.count)

        switch ratio {
        case 0.75...1.0:
            return "daily_status.great_progress"
        case 0.4..<0.75:
            return "daily_status.good_effort"
        default:
            return "daily_status.try_more"
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
