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
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Welcome 👋")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Let's make today special")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.95))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 20)

                    VStack(alignment: .leading, spacing: 15) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Daily Progress")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                                Text("\(appModel.completedCount) of 4")
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

                        Text("\(Int((Double(appModel.completedCount) / 4.0) * 100))%")
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
                                .frame(width: geometry.size.width * CGFloat(appModel.completedCount) / 4.0, height: 8)
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
        .onChange(of: appModel.completedCount) { _, _ in
            updateCelebration()
        }
        .fullScreenCover(isPresented: $showCelebration) {
            CelebrationView(parentName: appModel.parentName) {
                showCelebration = false
            }
        }
    }

    private func updateCelebration() {
        showCelebration = appModel.allCompleted
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
                    Image(systemName: "lock.fill")
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

#Preview {
    NavigationStack { DashboardView().environmentObject(AppModel()) }
}
