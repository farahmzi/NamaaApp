//
//  WelcomeView.swift
//  NamaaApp
//
//  Created by Farah Almozaini on 24/11/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                Spacer()

                // App icon circle
                ZStack {
                    Circle()
                        .stroke(Color.appYellow, lineWidth: 5)
                        .frame(width: 90, height: 90)

                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.appYellow)
                }

                Text("(a character or app icon)")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)

                Text("Welcome!")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Color.appYellow)

                Spacer()

                NavigationLink {
                    ChildInfoView()
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
