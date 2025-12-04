//
//  SettingsView.swift
//  NamaaApp
//
//  Created by Assistant on 02/12/2025.
//

import SwiftUI

// This screen is now the Profile page.
// It reflects and edits the same data captured in ChildInfoView.
struct SettingsView: View {
    @EnvironmentObject private var appModel: AppModel
    @State private var isEditing: Bool = false

    // Header gradient (same palette used elsewhere)
    private let topGradientStart = Color(red: 0.95, green: 0.85, blue: 0.50)
    private let topGradientEnd   = Color(red: 0.50, green: 0.70, blue: 0.95)

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header (visual only; removed nav bar title)
                ZStack(alignment: .bottom) {
                    LinearGradient(
                        gradient: Gradient(colors: [topGradientStart, topGradientEnd]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 180)
                    .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                    .overlay(alignment: .topLeading) {
                        // Edit/Done button (left side, moved slightly down)
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isEditing.toggle()
                            }
                        } label: {
                            Text(isEditing ? "Done" : "Edit")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color.black.opacity(0.25))
                                .clipShape(Capsule())
                        }
                        .padding(.leading, 16)
                        .padding(.top, 28) // lowered a bit
                        .accessibilityLabel(isEditing ? "Done editing" : "Edit profile")
                    }

                    // Avatar + Arabic subtitle
                    VStack(spacing: 6) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color.white.opacity(0.25))
                            Image(systemName: "person.fill")
                                .font(.system(size: 26, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 60, height: 60)

                        Text("إدارة الملف الشخصي")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 14)
                }
                .ignoresSafeArea(edges: .top)

                // Editable profile content
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        InfoCard(
                            title: "Parent Name",
                            systemImage: "person.2.fill",
                            borderColor: .appYellow,
                            iconBackground: .appYellow.opacity(0.15),
                            text: $appModel.parentName,
                            placeholder: "Enter your name"
                        )
                        .disabled(!isEditing)
                        .opacity(isEditing ? 1 : 0.55)

                        InfoCard(
                            title: "Child Name",
                            systemImage: "person.fill",
                            borderColor: .appBlue.opacity(0.35),
                            iconBackground: .appBlue.opacity(0.15),
                            text: $appModel.childName,
                            placeholder: "Enter your child's name"
                        )
                        .disabled(!isEditing)
                        .opacity(isEditing ? 1 : 0.55)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(Color.appYellow.opacity(0.15))
                                        .frame(width: 32, height: 32)
                                    Image(systemName: "chart.bar.fill")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.appYellow)
                                }
                                Text("Child Level")
                                    .font(.subheadline.weight(.semibold))
                                Spacer()
                            }

                            Picker("Child Level", selection: $appModel.childLevel) {
                                ForEach(ChildLevel.allCases) { level in
                                    Text(level.rawValue).tag(level)
                                }
                            }
                            .pickerStyle(.segmented)
                            .disabled(!isEditing)
                            .opacity(isEditing ? 1 : 0.55)
                        }
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.appYellow.opacity(0.35), lineWidth: 1.5)
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color.white)
                                )
                        )

                        // Selected Skills section intentionally removed per request.

                        Text("Changes are saved automatically.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 6)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
            }
        }
        // Removed navigationTitle("Profile") to hide the title
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                EmptyView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(AppModel())
    }
}
