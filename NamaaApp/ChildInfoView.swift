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
                    iconBackground: .appYellow.opacity(0.15),
                    text: $parentName,
                    placeholder: "Enter your name"
                )

                // Child name card
                InfoCard(
                    title: "Child Name",
                    systemImage: "person.fill",
                    borderColor: .appBlue.opacity(0.4),
                    iconBackground: .appBlue.opacity(0.15),
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

#Preview {
    NavigationStack { ChildInfoView() }
}
