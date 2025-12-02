//
//  ChildInfoView.swift
//  NamaaApp
//
//  Created by Farah Almozaini on 24/11/2025.
//

import SwiftUI

struct ChildInfoView: View {
    @State private var parentName: String = ""
    @State private var childName: String = ""
    @State private var childLevel: String = ""

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                // App icon centered
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.appYellow)
                    .frame(width: 90, height: 90)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 24)

                // Title + subtitle centered
                VStack(alignment: .center, spacing: 4) {
                    Text("Your Child's Information")
                        .font(.title2.weight(.semibold))

                    Text("Let's get to know your wonderful child")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // Parent name card
                InfoCard(
                    title: "Parent Name",
                    systemImage: "person.2.fill",
                    borderColor: .appYellow,
                    text: $parentName,
                    placeholder: "Enter your name"
                )

                // Child name card
                InfoCard(
                    title: "Child Name",
                    systemImage: "person.fill",
                    borderColor: .appBlue.opacity(0.4),
                    iconBackground: .appBlue,
                    text: $childName,
                    placeholder: "Enter your child's name"
                )

                // Child level card
                InfoCard(
                    title: "Child Level",
                    systemImage: "chart.bar.fill",
                    borderColor: Color(.systemGray4),
                    iconBackground: Color(.systemGray5),
                    text: $childLevel,
                    placeholder: "State your child's level (e.g., Intermediate)"
                )

                Spacer()

                NavigationLink {
                    SkillsSelectionView()
                } label: {
                    Text("Continue")
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
        .navigationBarBackButtonHidden(false)
    }
}

// Reusable card
struct InfoCard: View {
    let title: String
    let systemImage: String
    let borderColor: Color
    var iconBackground: Color = .appYellow.opacity(0.15)

    @Binding var text: String
    let placeholder: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                ZStack {
                    Circle()
                        .fill(iconBackground)
                        .frame(width: 32, height: 32)
                    Image(systemName: systemImage)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.appYellow)
                }
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Spacer()
            }

            TextField(placeholder, text: $text)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.fieldBackground)
                .cornerRadius(22)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(borderColor, lineWidth: 1.5)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                )
        )
    }
}

#Preview {
    NavigationStack { ChildInfoView() }
}
