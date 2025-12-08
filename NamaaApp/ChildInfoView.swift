//
//  ChildInfoView.swift
//  NamaaApp
//
//  Created by Farah Almozaini on 24/11/2025.
//

import SwiftUI

struct ChildInfoView: View {
    @EnvironmentObject private var appModel: AppModel

    @State private var parentName: String = ""
    @State private var childName: String = ""
    @State private var childLevel: ChildLevel = .beginner

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                // Top yellow rounded square WITH icon inside (to match screenshot)
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(AppGradient.brandYellow.opacity(0.9))
                    Image(systemName: "person.text.rectangle")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                }
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
                    borderColor: AppGradient.brandYellow.opacity(0.8),
                    iconBackground: AppGradient.brandYellow.opacity(0.15),
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

                NavigationLink {
                    SkillsSelectionView()
                        .onAppear {
                            appModel.parentName = parentName
                            appModel.childName = childName
                            appModel.childLevel = childLevel
                        }
                } label: {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(AppGradient.brandYellow)
                        )
                }
                .padding(.bottom, 24)
                .disabled(parentName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                          childName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(
                    (parentName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                     childName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) ? 0.6 : 1
                )
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(false)
    }
}

// Card hosting the segmented/pill control with tuned spacing to fit nicely
private struct LevelCard: View {
    let title: String
    let systemImage: String
    let borderColor: Color
    let iconBackground: Color
    @Binding var selection: ChildLevel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(iconBackground)
                        .frame(width: 32, height: 32)
                    Image(systemName: systemImage)
                        .font(.system(size: 14))
                        .foregroundStyle(borderColor.opacity(0.95))
                }

                Text(title)
                    .font(.subheadline.weight(.semibold))
                Spacer()
            }

            PillSegmented(selection: $selection)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(borderColor.opacity(0.35), lineWidth: 1.5)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                )
        )
    }
}

private struct PillSegmented: View {
    @Binding var selection: ChildLevel
    private let options = ChildLevel.allCases

    var body: some View {
        ZStack {
            Capsule()
                .fill(Color(.systemGray6))
                .overlay(
                    Capsule().stroke(Color(.systemGray4), lineWidth: 1)
                )

            HStack(spacing: 6) {
                ForEach(options) { option in
                    Button {
                        selection = option
                    } label: {
                        Text(option.rawValue)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(selection == option ? .black : .secondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(
                                Capsule()
                                    .fill(selection == option ? Color.white : Color.clear)
                                    .shadow(color: selection == option ? .black.opacity(0.06) : .clear, radius: 3, x: 0, y: 1)
                            )
                    }
                }
            }
            .padding(6)
        }
        .frame(height: 52) // consistent, roomy height like the screenshot
    }
}

#Preview {
    NavigationStack { ChildInfoView().environmentObject(AppModel()) }
}
