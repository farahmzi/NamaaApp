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
            AppGradient.primary.ignoresSafeArea()

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
                    .foregroundStyle(AppGradient.brandYellow)

                Spacer()

                NavigationLink {
                    ChildInfoView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Get Started")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .fill(AppGradient.brandYellow) // exact yellow
                                .shadow(color: .black.opacity(0.18), radius: 12, x: 0, y: 6)
                        )
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
}
