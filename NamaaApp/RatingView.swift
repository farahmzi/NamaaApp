//
//  RatingView.swift
//  NamaaApp
//
//  Created by Team on 10/06/1447 AH.
//

import SwiftUI

struct RatingView: View {
    @State private var selectedRating: Int? = nil
    @State private var notes: String = ""
    @Environment(\.dismiss) private var dismiss

    let emojis = ["😟", "😐", "😊"]
    let emojiLabels = ["Needs Improvement", "Good", "Excellent"]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)

                VStack(spacing: 6) {
                    Text("Rate Activity")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                    Text("How did your child perform?")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }

                HStack(spacing: 15) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 255/255, green: 200/255, blue: 100/255))
                            .frame(width: 50, height: 50)

                        Image(systemName: "book.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Daily Story Reading")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)

                        Text("Communication")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8)
                .padding(.horizontal, 20)

                VStack(alignment: .trailing, spacing: 15) {
                    Text("Choose a rating")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    HStack(spacing: 15) {
                        ForEach(0..<3) { index in
                            VStack(spacing: 8) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(selectedRating == index ? getEmojiColor(index) : Color.white)
                                        .frame(width: 90, height: 90)
                                        .shadow(color: .black.opacity(0.05), radius: 8)

                                    Text(emojis[index])
                                        .font(.system(size: 40))
                                }
                                .onTapGesture {
                                    selectedRating = index
                                }

                                Text(emojiLabels[index])
                                    .font(.system(size: 11))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8)
                .padding(.horizontal, 20)

                VStack(alignment: .trailing, spacing: 12) {
                    HStack {
                        Image(systemName: "doc.text")
                            .font(.system(size: 16))
                            .foregroundColor(.black)

                        Spacer()

                        Text("Notes (optional)")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.black)
                    }

                    Text("Add your notes about your child’s performance...")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    ZStack(alignment: .topTrailing) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.gray.opacity(0.06))
                            .frame(height: 120)

                        TextEditor(text: $notes)
                            .frame(height: 120)
                            .padding(12)
                            .background(Color.clear)
                            .scrollContentBackground(.hidden)
                    }
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8)
                .padding(.horizontal, 20)

                Button(action: { dismiss() }) {
                    Text("Save Rating")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 100/255, green: 180/255, blue: 255/255),
                                    Color(red: 150/255, green: 200/255, blue: 255/255)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .background(Color.clear)
        }
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(UIColor.systemBackground))
                .ignoresSafeArea(edges: .bottom)
        )
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
            }
        }
    }

    private func getEmojiColor(_ index: Int) -> Color {
        switch index {
        case 0: return Color(red: 70/255, green: 70/255, blue: 80/255)
        case 1: return Color(red: 100/255, green: 180/255, blue: 255/255)
        case 2: return Color(red: 255/255, green: 200/255, blue: 100/255)
        default: return Color.white
        }
    }
}
