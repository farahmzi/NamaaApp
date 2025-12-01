//
//  TasksView.swift
//  NamaaApp
//
//  Created by Team on 10/06/1447 AH.
//

import SwiftUI

struct TasksView: View {
    var body: some View {
        ZStack {
            // Background gradient matching the design
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
                    // Header
                    HStack {
                        Spacer()
                        Text("مهام اليوم")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 20)

                    // Task Cards
                    VStack(spacing: 12) {
                        NavigationLink(destination: DailyStoryView()) {
                            TaskCard(
                                title: "قراءة القصة اليومية",
                                category: "التواصل",
                                duration: "10:00 صباحاً",
                                minutes: "15 دقيقة",
                                icon: "book.fill",
                                iconColor: Color(red: 255/255, green: 200/255, blue: 100/255),
                                isCompleted: true
                            )
                        }

                        TaskCard(
                            title: "لعبة الأشكال والألوان",
                            category: "الإدراك",
                            duration: "11:30 صباحاً",
                            minutes: "20 دقيقة",
                            icon: "square.grid.2x2.fill",
                            iconColor: Color(red: 100/255, green: 150/255, blue: 255/255),
                            isCompleted: true
                        )

                        TaskCard(
                            title: "وقت اللعب الجماعي",
                            category: "الاجتماعية",
                            duration: "02:00 مساءً",
                            minutes: "30 دقيقة",
                            icon: "person.3.fill",
                            iconColor: Color(red: 100/255, green: 150/255, blue: 255/255),
                            isCompleted: false
                        )

                        TaskCard(
                            title: "تمارين اليد والأصابع",
                            category: "الحركية",
                            duration: "04:00 مساءً",
                            minutes: "15 دقيقة",
                            icon: "hand.raised.fill",
                            iconColor: Color(red: 255/255, green: 180/255, blue: 100/255),
                            isCompleted: false
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Task Card Component
struct TaskCard: View {
    let title: String
    let category: String
    let duration: String
    let minutes: String
    let icon: String
    let iconColor: Color
    let isCompleted: Bool

    var body: some View {
        HStack(spacing: 12) {
            // Icon on the right
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(iconColor)
                    .frame(width: 50, height: 50)

                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }

            Spacer()

            // Text content
            VStack(alignment: .trailing, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)

                HStack(spacing: 15) {
                    HStack(spacing: 4) {
                        Text(duration)
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                        Image(systemName: "clock")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }

                    HStack(spacing: 4) {
                        Text(minutes)
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                        Image(systemName: "timer")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }

                    Text(category)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
            }

            // Checkbox on the left
            ZStack {
                Circle()
                    .strokeBorder(isCompleted ? Color.clear : Color.gray.opacity(0.3), lineWidth: 2)
                    .background(
                        Circle()
                            .fill(isCompleted ? Color(red: 255/255, green: 200/255, blue: 100/255) : Color.white)
                    )
                    .frame(width: 24, height: 24)

                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Daily Story View (nested under Tasks)
struct DailyStoryView: View {
    @Environment(\.dismiss) private var dismiss

    let activities = [
        "ابدأ بجلسة هادئة ومريحة مع طفلك",
        "اختر قصة مناسبة لعمره واهتماماته",
        "اقرأ بصوت واضح وهادئ",
        "توقف واسأل أسئلة بسيطة عن القصة",
        "شجع طفلك على المشاركة والتعبير"
    ]

    var body: some View {
        ZStack(alignment: .top) {
            // Yellow background for top section
            Color(red: 255/255, green: 184/255, blue: 0/255)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Top Yellow Section with Icon and Title
                    VStack(spacing: 15) {
                        Image(systemName: "book.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .padding(.top, 60)

                        Text("قراءة القصة اليومية")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)

                        Text("التواصل")
                            .font(.system(size: 15))
                            .foregroundColor(.white.opacity(0.95))
                    }
                    .padding(.bottom, 40)

                    // Main White Card
                    VStack(spacing: 25) {
                        // Icons Section
                        HStack(spacing: 50) {
                            VStack(spacing: 10) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color(red: 232/255, green: 244/255, blue: 255/255))
                                        .frame(width: 70, height: 70)

                                    Image(systemName: "clock")
                                        .font(.system(size: 32))
                                        .foregroundColor(Color(red: 100/255, green: 180/255, blue: 255/255))
                                }

                                Text("المدة")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)

                                Text("15 دقيقة")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }

                            VStack(spacing: 10) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color(red: 255/255, green: 244/255, blue: 204/255))
                                        .frame(width: 70, height: 70)

                                    Image(systemName: "list.bullet")
                                        .font(.system(size: 32))
                                        .foregroundColor(Color(red: 255/255, green: 200/255, blue: 80/255))
                                }

                                Text("الخطوات")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)

                                Text("5 خطوات")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 30)

                        // Description Section
                        VStack(spacing: 10) {
                            Text("الوصف")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)

                            Text("قراءة القصص تساعد في تطوير مهارات اللغة والتواصل وتعزز الخيال والإبداع. هذا النشاط ممتع ومفيد لطفلك.")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .padding(.horizontal, 30)
                        }

                        // Steps Section Header
                        HStack {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 255/255, green: 184/255, blue: 0/255))

                            Spacer()

                            Text("خطوات النشاط")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 10)

                        // Steps List
                        VStack(spacing: 18) {
                            ForEach(Array(activities.enumerated()), id: \.offset) { index, activity in
                                HStack(spacing: 15) {
                                    ZStack {
                                        Circle()
                                            .fill(Color(red: 255/255, green: 235/255, blue: 180/255))
                                            .frame(width: 38, height: 38)

                                        Text("\(index + 1)")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(Color(red: 200/255, green: 140/255, blue: 50/255))
                                    }

                                    Spacer()

                                    Text(activity)
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.trailing)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .padding(.horizontal, 30)
                            }
                        }
                        .padding(.bottom, 10)

                        // Tip Box
                        HStack(spacing: 12) {
                            Image(systemName: "lightbulb.fill")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 255/255, green: 200/255, blue: 80/255))

                            Spacer()

                            VStack(alignment: .trailing, spacing: 4) {
                                Text("نصيحة")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)

                                Text("اختر وقت يكون فيه طفلك مرتاح ومستعد للاستماع و تسمع وتستمتع بالوقت معاً!")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .lineSpacing(3)
                            }
                        }
                        .padding(18)
                        .background(Color(red: 255/255, green: 248/255, blue: 220/255))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 25)
                    }
                    .background(Color.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])

                    // Button at bottom - on white background
                    NavigationLink(destination: RatingView()) {
                        HStack(spacing: 10) {
                            Image(systemName: "play.fill")
                                .font(.system(size: 18))
                            Text("ابدأ النشاط")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 100/255, green: 180/255, blue: 255/255),
                                    Color(red: 255/255, green: 200/255, blue: 100/255)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 25)
                    .padding(.bottom, 50)
                    .background(Color.white)
                }
            }

            // Back Button
            HStack {
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(Color.white.opacity(0.3))
                        .clipShape(Circle())
                }
                .padding(.trailing, 20)
                .padding(.top, 50)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
    }
}

// Custom corner radius extension used here
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
