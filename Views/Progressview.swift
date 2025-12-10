//
//  Progressview.swift
//  NamaaApp
//
//  Created by hg on 10/06/1447 AH.
//

import SwiftUI

struct Progressview: View {
    @EnvironmentObject private var appModel: AppModel

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {

                    // Header with greeting and status
                    VStack(spacing: 14) {
                        ZStack {
                            // Base gradient (matches Dashboard)
                            RoundedRectangle(cornerRadius: 30)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 130/255, green: 180/255, blue: 240/255),
                                            Color(red: 200/255, green: 230/255, blue: 250/255),
                                            Color(red: 255/255, green: 250/255, blue: 200/255),
                                            Color(red: 255/255, green: 220/255, blue: 100/255)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )

                            // Contrast overlay
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.black.opacity(0.22))

                            // Content
                            VStack(spacing: 10) {
                                // Greeting
                                Text("Hi \(appModel.parentName.isEmpty ? "there" : appModel.parentName)!")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundStyle(.white.opacity(0.98))
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)

                                // Context line about progress
                                Text("You can check \(appModel.childName.isEmpty ? "your child's" : appModel.childName + "'s") progress here.")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.92))
                                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)

                                // Daily status / motivation
                                Text(appModel.dailyStatusText)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.95))
                                    .shadow(color: .black.opacity(0.22), radius: 1.5, x: 0, y: 1)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 4)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                        }
                        .frame(height: 190)
                    }
                    .padding(.horizontal)
                    .padding(.top, 6)

                    // Progress bars per selected skill
                    VStack(spacing: 12) {
                        ForEach(Array(appModel.selectedSkills), id: \.self) { skill in
                            SkillProgressRow(
                                title: skill.title,
                                progress: appModel.averageProgressForSkill(title: skill.title),
                                barColor: skill.color
                            )
                        }

                        if appModel.selectedSkills.isEmpty {
                            Text("No skills selected yet. Visit Home > Edit Skills to choose.")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                                .padding(.top, 6)
                        }
                    }
                    .padding(.horizontal)

                    // History (multi-day)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("History")
                            .font(.headline)
                            .padding(.horizontal)

                        let grouped = groupedHistory()
                        if grouped.isEmpty {
                            Text("No history yet. Once you rate tasks, they will appear here grouped by day.")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                                .padding(.horizontal)
                                .padding(.bottom, 12)
                        } else {
                            VStack(spacing: 16) {
                                ForEach(grouped, id: \.date) { day in
                                    VStack(alignment: .leading, spacing: 8) {
                                        // Section header: date
                                        Text(Self.dateFormatter.string(from: day.date))
                                            .font(.subheadline.weight(.semibold))
                                            .foregroundStyle(.secondary)
                                            .padding(.horizontal)

                                        VStack(spacing: 8) {
                                            ForEach(day.entries) { entry in
                                                HistoryRow(entry: entry)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)

                    Spacer(minLength: 20)
                }
                .padding(.bottom, 20)
                .onAppear {
                    appModel.ensureTasksForToday()
                }
            }
        }
        .navigationTitle("Progress")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Build grouped history: past days (archived) + today (if any)
    private func groupedHistory() -> [DayHistory] {
        let calendar = Calendar.current

        // Past archived days are already day-bucketed
        var result: [DayHistory] = appModel.pastDays
            .map { DayHistory(date: $0.date, entries: $0.entries.sorted(by: { $0.date > $1.date })) }

        // Include today's entries if present
        if !appModel.todayHistory.isEmpty {
            let todayStart = calendar.startOfDay(for: Date())
            let today = DayHistory(date: todayStart, entries: appModel.todayHistory.sorted(by: { $0.date > $1.date }))
            result.append(today)
        }

        // Sort days newest first
        result.sort(by: { $0.date > $1.date })
        return result
    }

    private struct DayHistory: Identifiable {
        var id: Date { date }
        let date: Date // start-of-day
        let entries: [HistoryEntry]
    }

    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df
    }()
}

struct SkillProgressRow: View {
    let title: String
    let progress: Double // 0...1
    let barColor: Color

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.black)
                Spacer()
                Text("\(Int(progress * 100))%")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.18))
                    .frame(height: 10)

                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(barColor)
                        .frame(width: max(0, geo.size.width * progress), height: 10)
                }
            }
            .frame(height: 10)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        )
    }
}

private struct HistoryRow: View {
    let entry: HistoryEntry

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(entry.rating.emoji)
                .font(.system(size: 26))

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.taskTitle)
                    .font(.subheadline.weight(.semibold))
                Text(entry.category)
                    .font(.caption)
                    .foregroundStyle(.gray)
                if let note = entry.note, !note.isEmpty {
                    Text(note)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)
                }
            }

            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 1)
        )
    }
}

#Preview {
    let model = AppModel()
    model.parentName = "Sarah"
    model.childName = "Adam"

    if let comm = Skill.all.first(where: { $0.title == "Communication Skills" }),
       let cog = Skill.all.first(where: { $0.title == "Cognitive Skills" }) {
        model.selectedSkills = Set([comm, cog])
    }

    // Simulate two days of history
    let cal = Calendar.current
    let todayStart = cal.startOfDay(for: Date())
    let yesterdayStart = cal.date(byAdding: .day, value: -1, to: todayStart)!

    model.pastDays = [
        DailyLog(date: yesterdayStart, entries: [
            HistoryEntry(date: cal.date(byAdding: .hour, value: 10, to: yesterdayStart)!, taskTitle: "Story Time", category: "Communication Skills", rating: .done, note: "Great reading"),
            HistoryEntry(date: cal.date(byAdding: .hour, value: 12, to: yesterdayStart)!, taskTitle: "Memory Match", category: "Cognitive Skills", rating: .doneWithHelp, note: nil)
        ])
    ]

    model.todayHistory = [
        HistoryEntry(date: cal.date(byAdding: .hour, value: 9, to: todayStart)!, taskTitle: "Team Builder", category: "Social Skills", rating: .done, note: "Played well")
    ]

    return NavigationStack { Progressview().environmentObject(model) }
}

