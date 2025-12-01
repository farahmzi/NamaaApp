//
//  SkillsSelectionView.swift
//  NamaaApp
//
//  Created by Farah Almozaini on 24/11/2025.
//

import SwiftUI

struct Skill: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let color: Color
    let systemImage: String
}

struct SkillsSelectionView: View {
    @State private var selectedSkills: Set<Skill> = []

    private let skills: [Skill] = [
        Skill(title: "المهارات الإدراكية",
              subtitle: "التفكير والذاكرة والانتباه",
              color: .appBlue,
              systemImage: "brain.head.profile"),
        Skill(title: "مهارات التواصل",
              subtitle: "اللغة والكلام والتعبير",
              color: .appYellow,
              systemImage: "bubble.left.and.bubble.right.fill"),
        Skill(title: "مهارات اجتماعية",
              subtitle: "التفاعل مع الآخرين",
              color: .appBlue,
              systemImage: "person.3.fill"),
        Skill(title: "مهارات حركية",
              subtitle: "الحركة والتفاعل",
              color: .appYellow,
              systemImage: "figure.walk")
    ]

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(alignment: .trailing, spacing: 24) {
                VStack(alignment: .trailing, spacing: 4) {
                    Text("اختر المهارات")
                        .font(.title2.weight(.semibold))
                    Text("حدد المهارات التي تود التركيز عليها")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 16)

                ForEach(skills) { skill in
                    SkillCard(
                        skill: skill,
                        isSelected: selectedSkills.contains(skill)
                    )
                    .onTapGesture {
                        toggle(skill)
                    }
                }

                Spacer()

                NavigationLink {
                    DashboardView()
                } label: {
                    Text("متابعة")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appYellow)
                        .cornerRadius(16)
                }
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
    }

    private func toggle(_ skill: Skill) {
        if selectedSkills.contains(skill) {
            selectedSkills.remove(skill)
        } else {
            selectedSkills.insert(skill)
        }
    }
}

struct SkillCard: View {
    let skill: Skill
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 12) {
            // دائرة اختيار
            Circle()
                .strokeBorder(isSelected ? Color.appYellow : Color.gray.opacity(0.4),
                              lineWidth: isSelected ? 6 : 2)
                .frame(width: 26, height: 26)
                .overlay(
                    Circle()
                        .fill(isSelected ? Color.appYellow : Color.clear)
                        .padding(6)
                )

            VStack(alignment: .trailing, spacing: 4) {
                Text(skill.title)
                    .font(.subheadline.weight(.semibold))
                Text(skill.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

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
