//
//  InfoCard.swift
//  NamaaApp
//
//  Created by Assistant on 03/12/2025.
//

import SwiftUI

struct InfoCard: View {
    let title: LocalizedStringKey
    let systemImage: String
    let borderColor: Color
    let iconBackground: Color
    @Binding var text: String
    let placeholder: LocalizedStringKey

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(iconBackground)
                        .frame(width: 32, height: 32)
                    Image(systemName: systemImage)
                        .font(.system(size: 14))
                        .foregroundStyle(borderColor.opacity(0.9))
                }

                Text(title)
                    .font(.subheadline.weight(.semibold))
                Spacer()
            }

            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled(false)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor.opacity(0.35), lineWidth: 1)
                )
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
