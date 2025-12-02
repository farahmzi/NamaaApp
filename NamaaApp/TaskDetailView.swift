//
//  TaskDetailView.swift
//  NamaaApp/Users/farahuef/Downloads/NamaaApp copy/NamaaApp/TaskDetailView.swift
//
//  Created by Assistant on 02/12/2025.
//

import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject private var appModel: AppModel
    @Environment(\.dismiss) private var dismiss

    let task: TaskItem

    @State private var selectedRating: TaskRating? = nil

    // Simple example steps
    private var steps: [String] {
        switch task.icon {
        case "brain.head.profile":
            return ["Explain the game", "Match pairs", "Praise effort"]
        case "bubble.left.and.bubble.right.fill":
            return ["Read together", "Ask questions", "Encourage answers"]
        case "person.3.fill":
            return ["Invite participation", "Practice turn-taking", "Celebrate sharing"]
        case "figure.walk":
            return ["Warm-up", "Main movement", "Cool down"]
        default:
            return ["Start activity", "Do the task", "Wrap up"]
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(task.title)
                            .font(.title3.weight(.bold))
                        Text(task.category)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.appBlue.opacity(0.15))
                            .frame(width: 50, height: 50)
                        Image(systemName: task.icon)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(Color.appBlue)
                    }
                }
                .padding(.horizontal)

                // Steps
                VStack(alignment: .leading, spacing: 12) {
                    Text("Steps")
                        .font(.headline)
                    ForEach(steps.indices, id: \.self) { idx in
                        HStack(alignment: .top, spacing: 10) {
                            Text("\(idx + 1).")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Color.appYellow)
                            Text(steps[idx])
                                .font(.subheadline)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8)
                .padding(.horizontal)

                // Rating
                VStack(alignment: .leading, spacing: 12) {
                    Text("Rate today's progress")
                        .font(.headline)

                    HStack(spacing: 12) {
                        ForEach(TaskRating.allCases) { rating in
                            Button {
                                selectedRating = rating
                            } label: {
                                VStack(spacing: 6) {
                                    Text(rating.emoji)
                                        .font(.system(size: 34))
                                    Text(rating.rawValue)
                                        .font(.footnote)
                                        .foregroundStyle(.primary)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selectedRating == rating ? Color.appYellow.opacity(0.2) : Color.white)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedRating == rating ? Color.appYellow : Color.gray.opacity(0.2), lineWidth: selectedRating == rating ? 2 : 1)
                                )
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8)
                .padding(.horizontal)

                // Encouraging message box with clapping icon, in a clear white card
                HStack(alignment: .top, spacing: 12) {
                    Text("👏")
                        .font(.system(size: 28))
                        .accessibilityLabel("Clapping")

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Great effort!")
                            .font(.headline)
                            .foregroundStyle(.primary)
                        Text("Keep going — every small step counts.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()
                }
                .padding(14)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.05), radius: 8)
                )
                .padding(.horizontal)

                Button {
                    guard let rating = selectedRating else { return }
                    appModel.completeTask(task, with: rating)
                    dismiss() // return to main page
                } label: {
                    Text("Save Rating")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            LinearGradient(
                                colors: [Color.appBlue, Color.appYellow],
                                startPoint: .leading, endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                .disabled(selectedRating == nil)
                .opacity(selectedRating == nil ? 0.6 : 1.0)
            }
            .padding(.top, 12)
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let model = AppModel()
    model.todayTasks = [
        TaskItem(title: "Story Time", category: "Communication Skills", icon: "bubble.left.and.bubble.right.fill")
    ]
    return NavigationStack { TaskDetailView(task: model.todayTasks[0]).environmentObject(model) }
}
