//
//  CelebrationView.swift
//  NamaaApp
//
//  Created by Assistant on 02/12/2025.
//

import SwiftUI

struct CelebrationView: View {
    let parentName: String
    let onDismiss: () -> Void

    @State private var animate = false

    var body: some View {
        ZStack {
            // Match app gradient
            LinearGradient(
                colors: [
                    Color(red: 130/255, green: 180/255, blue: 240/255),
                    Color(red: 200/255, green: 230/255, blue: 250/255),
                    Color(red: 255/255, green: 250/255, blue: 200/255),
                    Color(red: 255/255, green: 220/255, blue: 100/255)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Image(systemName: "hands.clap.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.white)
                    .shadow(radius: 8)

                Text("You're done for the day, \(parentName.isEmpty ? "Great job" : parentName)!")
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)

                Text("Amazing effort supporting your child today. See you tomorrow for new fun tasks!")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.95))
                    .padding(.horizontal, 32)

                Spacer()

                Button {
                    onDismiss()
                } label: {
                    Text("Back to Home")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appYellow)
                        .cornerRadius(16)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                }
            }
        }
        .onAppear {
            animate = true
        }
    }
}


private struct Particle: View {
    let emoji: String
    @State private var x: CGFloat = .zero
    @State private var y: CGFloat = -100
    @State private var rotation: Double = 0
    @State private var size: CGFloat = 20

    var body: some View {
        Text(emoji)
            .font(.system(size: size))
            .rotationEffect(.degrees(rotation))
            .position(x: x, y: y)
            .onAppear {
                let screen = UIScreen.main.bounds
                x = CGFloat.random(in: 0...screen.width)
                size = CGFloat.random(in: 18...30)
                withAnimation(.easeOut(duration: 1.0)) {
                    rotation = Double.random(in: -90...90)
                }
                withAnimation(.interpolatingSpring(stiffness: 30, damping: 12).delay(Double.random(in: 0...0.4))) {
                    y = CGFloat.random(in: screen.height * 0.4...screen.height * 0.9)
                }
            }
    }
}

#Preview {
    CelebrationView(parentName: "Sarah") { }
}
