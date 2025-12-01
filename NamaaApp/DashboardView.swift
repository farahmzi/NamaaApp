//
//  DashboardView.swift
//  NamaaApp
//
//  Created by Team on 10/06/1447 AH.
//

import SwiftUI

struct DashboardView: View {
    @State private var progress: Double = 0.5
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
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

                ScrollView {
                    VStack(spacing: 0) {
                        // Top Header
                        HStack {
                            Button(action: { dismiss() }) {
                                Label("Back", systemImage: "chevron.left")
                                    .labelStyle(.iconOnly)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 36, height: 36)
                                    .background(Color.white.opacity(0.3))
                                    .clipShape(Circle())
                            }

                            Spacer()

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Welcome 👋")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Let's make today special")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white.opacity(0.9))
                            }

                            Button(action: {}) {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 50)
                        .padding(.bottom, 20)

                        // Progress Card
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Daily Progress")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                    Text("2 of 4")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.black)
                                }
                                Spacer()
                            }

                            Text("50%")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            // Progress bar
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(height: 8)

                                    LinearGradient(
                                        colors: [
                                            Color(red: 100/255, green: 150/255, blue: 255/255),
                                            Color(red: 255/255, green: 200/255, blue: 100/255)
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                    .frame(width: geometry.size.width * progress, height: 8)
                                    .cornerRadius(10)
                                }
                            }
                            .frame(height: 8)
                        }
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 15)

                        // Date with icon
                        HStack(spacing: 8) {
                            Image(systemName: "calendar")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                            Text("Wednesday, Nov 18, 2025")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)

                        // Section Header
                        HStack {
                            NavigationLink(destination: Text("Weekly progress view")) {
                                Text("View weekly progress")
                                    .font(.system(size: 12))
                                    .foregroundColor(.blue)
                            }

                            Spacer()

                            Text("Today’s Tasks")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 15)

                        // Today’s Tasks list (embedded here)
                        VStack(spacing: 12) {
                            // First opens details
                            NavigationLink(destination: DailyStoryView()) {
                                TaskCard(
                                    title: "Daily Story Reading",
                                    category: "Communication",
                                    duration: "10:00 AM",
                                    minutes: "15 min",
                                    icon: "book.fill",
                                    iconColor: Color(red: 255/255, green: 200/255, blue: 100/255),
                                    isCompleted: true
                                )
                            }

                            TaskCard(
                                title: "Shapes & Colors Game",
                                category: "Cognition",
                                duration: "11:30 AM",
                                minutes: "20 min",
                                icon: "square.grid.2x2.fill",
                                iconColor: Color(red: 100/255, green: 150/255, blue: 255/255),
                                isCompleted: true
                            )

                            TaskCard(
                                title: "Group Play Time",
                                category: "Social",
                                duration: "02:00 PM",
                                minutes: "30 min",
                                icon: "person.3.fill",
                                iconColor: Color(red: 100/255, green: 150/255, blue: 255/255),
                                isCompleted: false
                            )

                            TaskCard(
                                title: "Hand & Finger Exercises",
                                category: "Motor",
                                duration: "04:00 PM",
                                minutes: "15 min",
                                icon: "hand.raised.fill",
                                iconColor: Color(red: 255/255, green: 180/255, blue: 100/255),
                                isCompleted: false
                            )
                        }
                        .padding(.horizontal, 20)

                        // Optional: Summary button (kept)
                        Button(action: {}) {
                            HStack {
                                Text("Today Summary")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color(red: 100/255, green: 150/255, blue: 255/255),
                                        Color(red: 255/255, green: 200/255, blue: 100/255)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            // Keep toolbar visible; we already placed a custom back in content.
        }
    }
}
