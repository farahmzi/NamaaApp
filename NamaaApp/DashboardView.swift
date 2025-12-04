//
//  DashboardView.swift
//  NamaaApp
//
//  Created by Team on 10/06/1447 AH.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var appModel: AppModel
    @State private var showCelebration = false
    @State private var showEditSkillsSheet = false

    // Use canonical list
    private let allSkills: [Skill] = Skill.all

    var body: some View {
        ZStack {
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
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Welcome 👋")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.white)
                            Text("Let's make today special")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.95))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 12)

                    // Focus Skills Card
                    FocusSkillsCard(
                        selectedSkills: Array(appModel.selectedSkills).sorted { $0.title < $1.title },
                        onEditTapped: { showEditSkillsSheet = true }
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)

                    // Daily Progress mini-summary
                    VStack(alignment: .leading, spacing: 15) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Daily Progress")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                                Text("\(appModel.completedCount) of \(max(1, appModel.todayTasks.count))")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.appBlue.opacity(0.15))
                                    .frame(width: 60, height: 60)
                                Image(systemName: "rosette")
                                    .font(.system(size: 26, weight: .semibold))
                                    .foregroundStyle(Color.appBlue)
                            }
                        }

                        Text("\(Int(progressRatio * 100))%")
                            .font(.system(size: 38, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 8)

                                LinearGradient(
                                    colors: [
                                        Color(red: 100/255, green: 150/255, blue: 255/255),
                                        Color(red: 255/255, green: 200/255, blue: 100/255)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .frame(width: geometry.size.width * CGFloat(progressRatio), height: 8)
                                .cornerRadius(10)
                            }
                        }
                        .frame(height: 8)
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)

                    HStack {
                        Text("Today’s Tasks")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)

                    Color.clear.frame(height: 0).onAppear {
                        appModel.ensureTasksForToday()
                        updateCelebration()
                    }

                    VStack(spacing: 12) {
                        ForEach(appModel.todayTasks) { task in
                            NavigationLink {
                                TaskDetailView(task: task)
                            } label: {
                                TaskRow(task: task)
                            }
                            .disabled(task.isCompleted)
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: appModel.selectedSkills) { _, _ in
            appModel.generateTodayTasks()
        }
        .onChange(of: appModel.completedCount) { _, _ in
            updateCelebration()
        }
        .fullScreenCover(isPresented: $showCelebration) {
            CelebrationView(parentName: appModel.parentName) {
                appModel.markCelebrationShown()
                showCelebration = false
            }
        }
        .sheet(isPresented: $showEditSkillsSheet) {
            EditSkillsSheet(
                allSkills: allSkills,
                selected: appModel.selectedSkills,
                onDone: { newSelection in
                    appModel.selectedSkills = newSelection
                    appModel.generateTodayTasks()
                    showEditSkillsSheet = false
                },
                onCancel: {
                    showEditSkillsSheet = false
                }
            )
            .presentationDetents([.large])
        }
    }

    private var progressRatio: Double {
        guard !appModel.todayTasks.isEmpty else { return 0 }
        return Double(appModel.completedCount) / Double(appModel.todayTasks.count)
    }

    private func updateCelebration() {
        showCelebration = appModel.shouldShowCelebration()
    }
}

private struct TaskRow: View {
    let task: TaskItem

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.appBlue.opacity(0.2))
                    .frame(width: 50, height: 50)
                Image(systemName: task.icon)
                    .font(.system(size: 24))
                    .foregroundColor(Color.appBlue)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(task.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(task.isCompleted ? .gray : .black)

                Text(task.category)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }

            ZStack {
                Circle()
                    .strokeBorder(task.isCompleted ? Color.clear : Color.gray.opacity(0.3), lineWidth: 2)
                    .background(
                        Circle()
                            .fill(task.isCompleted ? Color.gray.opacity(0.5) : Color.white)
                    )
                    .frame(width: 24, height: 24)

                if task.isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(15)
        .background(Color.white.opacity(task.isCompleted ? 0.6 : 1.0))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

// Big, obvious Focus Skills card with stable LazyVGrid chips and Edit button
private struct FocusSkillsCard: View {
    let selectedSkills: [Skill]
    let onEditTapped: () -> Void

    private let columns = [GridItem(.adaptive(minimum: 140), spacing: 8)]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Focus Skills", systemImage: "slider.horizontal.3")
                    .font(.headline)
                Spacer()
                Button(action: onEditTapped) {
                    HStack(spacing: 6) {
                        Image(systemName: "pencil")
                        Text("Edit")
                            .font(.subheadline.weight(.semibold))
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.appYellow.opacity(0.18))
                    .foregroundStyle(Color.appYellow)
                    .cornerRadius(12)
                }
            }

            if selectedSkills.isEmpty {
                Text("No skills selected yet. Tap Edit to choose.")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            } else {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                    ForEach(selectedSkills, id: \.id) { skill in
                        HStack(spacing: 8) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(skill.color)
                                .frame(width: 20, height: 20)
                                .overlay(
                                    Image(systemName: skill.systemImage)
                                        .font(.system(size: 11))
                                        .foregroundStyle(.white)
                                )
                            Text(skill.title)
                                .font(.footnote)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 3)
        )
    }
}

// Full-screen sheet for editing skills
private struct EditSkillsSheet: View {
    let allSkills: [Skill]
    @State var selected: Set<Skill>
    let onDone: (Set<Skill>) -> Void
    let onCancel: () -> Void

    var body: some View {
        NavigationStack {
            List {
                ForEach(allSkills) { skill in
                    HStack {
                        Image(systemName: selected.contains(skill) ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(selected.contains(skill) ? Color.appYellow : Color.gray.opacity(0.6))
                        Text(skill.title)
                        Spacer()
                        RoundedRectangle(cornerRadius: 8)
                            .fill(skill.color)
                            .frame(width: 26, height: 26)
                            .overlay(
                                Image(systemName: skill.systemImage)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.white)
                            )
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if selected.contains(skill) {
                            selected.remove(skill)
                        } else {
                            selected.insert(skill)
                        }
                    }
                }
            }
            .navigationTitle("Edit Skills")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { onCancel() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { onDone(selected) }
                        .disabled(selected.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NavigationStack { DashboardView().environmentObject(AppModel()) }
}
