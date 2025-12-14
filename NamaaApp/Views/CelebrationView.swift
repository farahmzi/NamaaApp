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

    @State private var animateRays = false
    @State private var fadeHint = false

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
            .contentShape(Rectangle())
            .onTapGesture {
                appModel.selectedTab = 1
                onDismiss()
            }

            VStack(spacing: 26) {
                Spacer().frame(height: 80)

                ZStack {
                    // Animated “rays” behind the clap
                    ForEach(0..<8) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.black.opacity(0.12))
                            .frame(width: 6, height: animateRays ? 22 : 8)
                            .offset(y: -42)
                            .rotationEffect(.degrees(Double(i) * 45))
                            .opacity(animateRays ? 1 : 0)
                    }
                    Text("👏")
                        .font(.system(size: 72))
                        .scaleEffect(animateRays ? 1.05 : 0.95)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: animateRays)
                }
                .onAppear { animateRays = true }

                // Message card
                VStack(spacing: 8) {
                    Text("Great job, \(parentName)!")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.primary)
                    Text("You did a wonderful job today\nsupporting your child!")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 22)
                .padding(.horizontal, 26)
                .background(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.15), radius: 18, x: 0, y: 8)
                )
                .padding(.horizontal, 32)

                Spacer()

                Text("Tap anywhere to dismiss")
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.9))
                    .opacity(fadeHint ? 0.3 : 1)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: fadeHint)
                    .onAppear { fadeHint = true }
                    .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    CelebrationView(parentName: "Parent") { }
        .environmentObject(AppModel())
}
