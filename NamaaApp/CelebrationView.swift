//
//  CelebrationView.swift
//  NamaaApp
//
//  Created by hg on 10/06/1447 AH.
//

import SwiftUI

struct CelebrationView: View {
    @EnvironmentObject private var appModel: AppModel

    let parentName: String
    let onDismiss: () -> Void

    @State private var progress: CGFloat = 0.0

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.85, green: 0.93, blue: 1.0),
                    Color(red: 0.95, green: 0.97, blue: 0.85)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.4), lineWidth: 18)
                        .frame(width: 230, height: 230)

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            Color.white,
                            style: StrokeStyle(lineWidth: 18, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 230, height: 230)
                        .animation(.easeOut(duration: 1.5), value: progress)

                    // Centered percentage only (no emoji)
                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                }
                .padding(.top, 40)
                .onAppear {
                    progress = 1.0
                }

                VStack(spacing: 8) {
                    Text("Great job, \(parentName)!")
                        .font(.headline)
                    Text("All tasks completed for today. Keep it up! 🌟")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.85))
                .cornerRadius(25)
                .padding(.horizontal)

                Button {
                    // Switch to Progress tab and dismiss
                    appModel.selectedTab = 1
                    onDismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text("View Progress")
                            .font(.system(size: 17, weight: .semibold))
                        Image(systemName: "chart.bar.fill")
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            colors: [Color.appBlue, Color.appYellow],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 3)
                    .padding(.horizontal)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    CelebrationView(parentName: "Parent") { }
        .environmentObject(AppModel())
}
