//
//  InfoCard.swift
//  NamaaApp
//

import SwiftUI

struct InfoCard: View {
    let title: String
    let systemImage: String
    let borderColor: Color
    var iconBackground: Color = .appYellow.opacity(0.15)

    @Binding var text: String
    let placeholder: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                ZStack {
                    Circle()
                        .fill(iconBackground)
                        .frame(width: 32, height: 32)
                    Image(systemName: systemImage)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.appYellow)
                }
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Spacer()
            }

            TextField(placeholder, text: $text)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.fieldBackground)
                .cornerRadius(22)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(borderColor, lineWidth: 1.5)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                )
        )
    }
}
