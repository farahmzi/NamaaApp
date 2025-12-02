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
    @State private var localLevel: ChildLevel = .beginner

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.appYellow.opacity(0.15))
                        .frame(width: 90, height: 90)

                    Image(systemName: "person.text.rectangle")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(Color.appYellow)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 12)

                VStack(alignment: .center, spacing: 4) {
                    Text("Your Child's Information")
                        .font(.title2.weight(.semibold))

                    Text("Let's get to know your wonderful child")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                InfoCard(
                    title: "Parent Name",
                    systemImage: "person.2.fill",
                    borderColor: .appYellow,
                    iconBackground: .appYellow.opacity(0.15),
                    text: $parentName,
                    placeholder: "Enter your name"
                )

                InfoCard(
                    title: "Child Name",
                    systemImage: "person.fill",
                    borderColor: .appBlue.opacity(0.35),
                    iconBackground: .appBlue.opacity(0.15),
                    text: $childName,
                    placeholder: "Enter your child's name"
                )

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

                    Picker("Child Level", selection: $localLevel) {
                        ForEach(ChildLevel.allCases) { level in
                            Text(level.rawValue).tag(level)
                        }
                    }
                    .pickerStyle(.segmented)
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

                Spacer()

                NavigationLink {
                    SkillsSelectionView()
                        .navigationBarBackButtonHidden(true)
                        .onAppear {
                            appModel.childLevel = localLevel
                            appModel.parentName = parentName
                        }
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack { ChildInfoView().environmentObject(AppModel()) }
}
