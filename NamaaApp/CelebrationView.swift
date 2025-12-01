//
//  CelebrationView.swift
//  NamaaApp
//
//  Created by hg on 10/06/1447 AH.
//

import SwiftUI

struct CelebrationView: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            // الخلفية
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.85, green: 0.93, blue: 1.0),
                    Color(red: 0.95, green: 0.97, blue: 0.85)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // دائرة النسبة
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.4), lineWidth: 18)
                        .frame(width: 230, height: 230)
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            Color.white,
                            style: StrokeStyle(lineWidth: 18, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 230, height: 230)
                        .animation(.easeOut(duration: 1.5), value: progress)
                    
                    VStack {
                        Text("🎉")
                            .font(.system(size: 40))
                        Text("\(Int(progress * 100))%")
                            .font(.system(size: 38, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 40)
                .onAppear {
                    progress = 0.75
                }
                
                // البوكسين
                HStack(spacing: 20) {
                    statBox(color: .blue, number: "45", title: "دقيقة نشاط")
                    statBox(color: .yellow, number: "3", title: "مهام مكتملة")
                }
                
                // رسالة تحفيزية
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("رسالة تحفيزية 💪")
                            .font(.headline)
                        Spacer()
                    }
                    Text("الرسالة")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.85))
                .cornerRadius(25)
                .padding(.horizontal)
                
                // شارة جديدة
                HStack {
                    Image(systemName: "trophy.fill")
                    Spacer()
                    VStack(alignment: .center) {
                        Text("شارة جديدة")
                            .font(.headline)
                        Text("بطل الأسبوع")
                            .font(.subheadline)
                    }
                    Spacer()
                    Image(systemName: "star.circle.fill")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow.opacity(0.8))
                .cornerRadius(25)
                .padding(.horizontal)
                
                // زر العودة
                HStack {
                    Spacer()
                    Text("العودة للرئيسية")
                        .font(.headline)
                    Image(systemName: "house")
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow.opacity(0.7))
                .cornerRadius(25)
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
    
    // دالة البوكسات الصغيرة
    func statBox(color: Color, number: String, title: String) -> some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 15)
                .fill(color.opacity(0.8))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundColor(.white)
                )
            
            Text(number)
                .font(.title2)
            
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 150, height: 130)
        .background(Color.white.opacity(0.85))
        .cornerRadius(20)
    }
}

#Preview {
    CelebrationView()
}
