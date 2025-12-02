//
//  Progressview.swift
//  NamaaApp
//
//  Created by hg on 10/06/1447 AH.
//

import SwiftUI

struct Progressview: View {
    // Configurable values (to match the mock)
    private let weeklyPercentText: String = "50%"
    private let weeklyFillWidth: CGFloat = 130
    private let dayTrackWidth: CGFloat = 180
    private let dayFillWidth: CGFloat = 90

    // Same header gradient used in ProfileView
    private let topGradientStart = Color(red: 0.95, green: 0.85, blue: 0.50)
    private let topGradientEnd   = Color(red: 0.50, green: 0.70, blue: 0.95)

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // ---------------------------------------------------
                //   Header identical to Profile header
                // ---------------------------------------------------
                ZStack(alignment: .bottom) {
                    LinearGradient(
                        gradient: Gradient(colors: [topGradientStart, topGradientEnd]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 220)
                    .clipShape(RoundedCornerShape(radius: 28, corners: [.bottomLeft, .bottomRight]))

                    VStack(spacing: 16) {
                        // Icon container (same style/size)
                        ZStack {
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color.white.opacity(0.25))
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        }
                        .frame(width: 64, height: 64)
                        .padding(.top, 12)

                        // Title + subtitle in English
                        VStack(spacing: 2) {
                            Text("Weekly Progress")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Track this week’s achievements")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    .padding(.bottom, 20)
                }
                .ignoresSafeArea(edges: .top)
                .padding(.top, -40)

                // ---------------------------------------------------
                //   Content
                // ---------------------------------------------------
                ScrollView {
                    VStack(spacing: 25) {

                        // Weekly Completion card (gradient like mock)
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                LinearGradient(
                                    colors: [Color.appBlue.opacity(0.6), Color.appYellow.opacity(0.5)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 150)
                            .overlay(
                                VStack(spacing: 16) {
                                    HStack(spacing: 20) {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.25))
                                            .frame(width: 80, height: 80)
                                            .overlay(
                                                Image(systemName: "chart.bar.fill")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 35))
                                            )

                                        Spacer()

                                        VStack(alignment: .trailing, spacing: 6) {
                                            Text("Weekly Completion")
                                                .foregroundColor(.white)
                                                .font(.headline)

                                            Text(weeklyPercentText)
                                                .foregroundColor(.white)
                                                .font(.system(size: 34, weight: .bold))
                                        }
                                    }

                                    // Progress bar (light track + white fill)
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white.opacity(0.35))
                                            .frame(height: 8)

                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .frame(width: weeklyFillWidth, height: 8)
                                    }
                                }
                                .padding(.horizontal, 25)
                            )
                            .padding(.horizontal)

                        // Day Details card
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white)
                            .shadow(color: .gray.opacity(0.25), radius: 10, y: 5)
                            .frame(maxWidth: .infinity)
                            .frame(height: 330)
                            .padding(.horizontal)
                            .overlay(
                                VStack(alignment: .leading, spacing: 20) {
                                    HStack {
                                        Spacer()
                                        Text("Day Details")
                                            .font(.title3)
                                            .bold()
                                            .padding(.top, 20)
                                    }

                                    dayRow(day: "Sunday", trackWidth: dayTrackWidth, fillWidth: dayFillWidth)
                                    dayRow(day: "Monday", trackWidth: dayTrackWidth, fillWidth: dayFillWidth)
                                    dayRow(day: "Tuesday", trackWidth: dayTrackWidth, fillWidth: dayFillWidth)
                                    dayRow(day: "Wednesday", trackWidth: dayTrackWidth, fillWidth: dayFillWidth)
                                    dayRow(day: "Thursday", trackWidth: dayTrackWidth, fillWidth: dayFillWidth)
                                    dayRow(day: "Friday", trackWidth: dayTrackWidth, fillWidth: dayFillWidth)
                                    dayRow(day: "Saturday", trackWidth: dayTrackWidth, fillWidth: dayFillWidth)

                                    Spacer()
                                }
                                .padding(.horizontal, 25)
                            )
                    }
                    .padding(.vertical, 25)
                }
            }
        }
    }
}

// -------------------------------------------------------------
//   Day row component (same look and spacing as the mock)
// -------------------------------------------------------------
private func dayRow(day: String, trackWidth: CGFloat, fillWidth: CGFloat) -> some View {
    HStack {
        Text("50%")
            .font(.system(size: 14))
            .foregroundColor(.black.opacity(0.75))

        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.18))
                .frame(width: trackWidth, height: 7)

            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [Color.appYellow, Color.appBlue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: fillWidth, height: 7)
        }

        Spacer()

        Text(day)
            .font(.system(size: 16))
            .foregroundColor(.black)
            .frame(width: 90, alignment: .trailing)
    }
}

#Preview {
    Progressview()
}
