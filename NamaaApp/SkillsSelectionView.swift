//
//  SkillsSelectionView.swift
//  NamaaApp
//
//  Created by Farah Almozaini on 24/11/2025.
//

import SwiftUI

// MARK: - Model
struct Skill: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let color: Color
    let systemImage: String
}

// MARK: - SkillsSelectionView
struct SkillsSelectionView: View {
    @EnvironmentObject private var appModel: AppModel

    @State private var selectedSkills: Set<Skill> = []
    @State private var navigate: Bool = false

    private let skills: [Skill] = [
        Skill(title: "Cognitive Skills",
              subtitle: "Thinking, memory, and attention",
              color: .appBlue,
              systemImage: "brain.head.profile"),
        Skill(title: "Communication Skills",
              subtitle: "Language, speech, and expression",
              color: .appYellow,
              systemImage: "bubble.left.and.bubble.right.fill"),
        Skill(title: "Social Skills",
              subtitle: "Interaction with others",
              color: .appBlue,
              systemImage: "person.3.fill"),
        Skill(title: "Motor Skills",
              subtitle: "Movement and interaction",
              color: .appYellow,
              systemImage: "figure.walk")
    ]

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Choose Skills")
                        .font(.title2.weight(.semibold))
                    Text("Select the skills you want to focus on")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)

                ForEach(skills) { skill in
                    SkillCard(
                        skill: skill,
                        isSelected: selectedSkills.contains(skill)
                    )
                    .onTapGesture { toggle(skill) }
                }

                Spacer()

                NavigationLink(isActive: $navigate) {
                    RootTabView()
                        .navigationBarBackButtonHidden(true)
                        .onAppear {
                            appModel.ensureTasksForToday()
                        }
                } label: {
                    EmptyView()
                }
                .hidden()

                Button {
                    appModel.selectedSkills = selectedSkills
                    appModel.ensureTasksForToday()
                    navigate = true
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedSkills.isEmpty ? Color.gray.opacity(0.4) : Color.appYellow)
                        .cornerRadius(16)
                }
                .disabled(selectedSkills.isEmpty)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
    }

    private func toggle(_ skill: Skill) {
        if selectedSkills.contains(skill) {
            selectedSkills.remove(skill)
        } else {
            selectedSkills.insert(skill)
        }
    }
}

// MARK: - SkillCard
struct SkillCard: View {
    let skill: Skill
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 12) {
            // Selection circle with checkmark when selected
            ZStack {
                Circle()
                    .strokeBorder(isSelected ? Color.appYellow : Color.gray.opacity(0.4),
                                  lineWidth: isSelected ? 6 : 2)
                    .frame(width: 26, height: 26)

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(Circle().fill(Color.appYellow))
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(skill.title)
                    .font(.subheadline.weight(.semibold))
                Text(skill.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            RoundedRectangle(cornerRadius: 14)
                .fill(skill.color)
                .frame(width: 48, height: 48)
                .overlay(
                    Image(systemName: skill.systemImage)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                )
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.appBlue.opacity(0.18), lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                )
        )
    }
}

#Preview {
    NavigationStack { SkillsSelectionView().environmentObject(AppModel()) }
}
