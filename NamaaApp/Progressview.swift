//
//  Progressview.swift
//  NamaaApp
//
//  Created by hg on 10/06/1447 AH.
//

import SwiftUI

struct Progressview: View {
    // يمكنك تعديل الاسم والصورة هنا
    let userName: String = "Sarah Johnson"
    let userImage: Image = Image(systemName: "person.crop.circle.fill")

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 25) {

                    // ---------------------------------------------------
                    //   Header gradient with avatar + name
                    // ---------------------------------------------------
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                LinearGradient(
                                    colors: [Color.appBlue.opacity(0.6), Color.appYellow.opacity(0.5)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 220)

                        VStack(spacing: 16) {
                            // Avatar + Name
                            HStack(spacing: 12) {
                                // صورة دائرية
                                ZStack {
                                    Circle()
                                        .fill(Color.white.opacity(0.25))
                                        .frame(width: 52, height: 52)

                                    userImage
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .foregroundStyle(.white)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Welcome back,")
                                        .font(.footnote)
                                        .foregroundStyle(.white.opacity(0.9))
                                    Text(userName)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.white)
                                }

                                Spacer()
                            }
                            .padding(.horizontal, 22)

                            // أيقونة + عنوان ووصف كما في التصميم
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                                .padding(15)
                                .background(Color.white.opacity(0.25))
                                .clipShape(RoundedRectangle(cornerRadius: 20))

                            Text("Weekly Progress")
                                .font(.title3)
                                .foregroundColor(.white)

                            Text("Track this week’s achievements")
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.top, 6)
                    }
                    .padding(.horizontal)
                    .padding(.top, -35) // نفس الامتداد للأعلى

                    // ---------------------------------------------------
                    //   Weekly Completion card
                    // ---------------------------------------------------
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

                                        Text("50%")
                                            .foregroundColor(.white)
                                            .font(.system(size: 34, weight: .bold))
                                    }
                                }

                                // progress bar like the mock
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.4))
                                        .frame(height: 8)

                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: 130, height: 8)
                                }
                            }
                            .padding(.horizontal, 25)
                        )
                        .padding(.horizontal)

                    // ---------------------------------------------------
                    //   Day Details card
                    // ---------------------------------------------------
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

                                dayRow(day: "Sunday")
                                dayRow(day: "Monday")
                                dayRow(day: "Tuesday")
                                dayRow(day: "Wednesday")
                                dayRow(day: "Thursday")
                                dayRow(day: "Friday")
                                dayRow(day: "Saturday")

                                Spacer()
                            }
                            .padding(.horizontal, 25)
                        )
                }
                .padding(.bottom, 40)
            }
        }
    }
}


// -------------------------------------------------------------
//   Day row component (same look as the mock)
// -------------------------------------------------------------
func dayRow(day: String) -> some View {
    HStack {
        Text("50%")
            .font(.system(size: 14))
            .foregroundColor(.black.opacity(0.75))

        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.18))
                .frame(width: 180, height: 7)

            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [Color.appYellow, Color.appBlue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 90, height: 7)
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
