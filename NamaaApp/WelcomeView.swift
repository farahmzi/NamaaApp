//
//  WelcomeView.swift
//  NamaaApp
//
//  Created by Farah Almozaini on 24/11/2025.
//

import SwiftUI

struct WelcomeView: View {
    // If WelcomeView itself accesses appModel.* add this line.
    // If it does not, you can keep it; it won’t hurt, and it ensures child views can read it after navigation.
    @EnvironmentObject private var appModel: AppModel

    var body: some View {
        ZStack {
            // Static gradient matching the rest of the app
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

            VStack(spacing: 24) {
                Spacer()

                Image("mom")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 260)
                    .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
                    .accessibilityLabel("Welcome illustration")

                Text("Welcome!")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Color.appYellow)

                Spacer()

                NavigationLink {
                    ChildInfoView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appYellow)
                        .cornerRadius(16)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 40)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    NavigationStack { WelcomeView() }
        .environmentObject(AppModel())
}
