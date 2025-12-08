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
                // In-content title placed just above the avatar image
                Text("Profile")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.primary)
                    .padding(.top, 8)

                // Header icon
                ZStack {
                    Circle()
                        .fill(Color.appBlue.opacity(0.12))
                        .frame(width: 90, height: 90)
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 44, weight: .semibold))
                        .foregroundStyle(Color.appBlue)
                }
                .padding(.top, 4)

                // Parent name
                InfoRow(title: "Parent's Name", value: appModel.parentName.isEmpty ? "—" : appModel.parentName)

                // Child name
                InfoRow(title: "Child's Name", value: appModel.childName.isEmpty ? "—" : appModel.childName)

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
        // Keep inline bar title minimal (or you could remove it)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct InfoRow: View {
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
