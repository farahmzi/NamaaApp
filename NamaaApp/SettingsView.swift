//
//  SettingsView.swift
//  NamaaApp
//
//  Created by Assistant on 02/12/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appModel: AppModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header icon
                ZStack {
                    Circle()
                        .fill(Color.appBlue.opacity(0.12))
                        .frame(width: 90, height: 90)
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 44, weight: .semibold))
                        .foregroundStyle(Color.appBlue)
                }
                .padding(.top, 20)

                // Parent name
                SettingsInfoRow(title: "Parent's Name", value: appModel.parentName.isEmpty ? "—" : appModel.parentName)

                // Child name
                SettingsInfoRow(title: "Child's Name", value: appModel.childName.isEmpty ? "—" : appModel.childName)

                // Skills to focus on
                VStack(alignment: .leading, spacing: 8) {
                    Text("Skills to Focus On")
                        .font(.headline)
                    if appModel.selectedSkills.isEmpty {
                        Text("No skills selected")
                            .foregroundStyle(.gray)
                    } else {
                        let skills = Array(appModel.selectedSkills).sorted { $0.title < $1.title }
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(skills, id: \.id) { skill in
                                HStack(spacing: 8) {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(skill.color)
                                        .frame(width: 18, height: 18)
                                        .overlay(
                                            Image(systemName: skill.systemImage)
                                                .font(.system(size: 9))
                                                .foregroundStyle(.white)
                                        )
                                    Text(skill.title)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8)

                // Simulate Tomorrow Button
                Button {
                    appModel.simulateTomorrow()
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "calendar.badge.plus")
                        Text("Simulate Tomorrow")
                            .font(.system(size: 17, weight: .semibold))
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color.appBlue, Color.appYellow],
                            startPoint: .leading, endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
                }
                .padding(.top, 4)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SettingsInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .foregroundStyle(.primary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8)
    }
}

#Preview {
    let model = AppModel()
    model.parentName = "Sarah"
    model.childName = "Adam"
    model.selectedSkills = Set(Skill.all)
    return NavigationStack { SettingsView().environmentObject(model) }
}
