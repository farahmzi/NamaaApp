//
//  Progressview.swift
//  NamaaApp
//
//  Created by hg on 10/06/1447 AH.
//

import SwiftUI

struct Progressview: View {
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    
                    // ---------------------------------------------------
                    //   الكرت العلوي — التقدم الأسبوعي (ممتد لأعلى)
                    // ---------------------------------------------------
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(
                                colors: [Color.blue.opacity(0.6), Color.yellow.opacity(0.5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 190)
                        .overlay(
                            VStack(spacing: 12) {
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .font(.system(size: 35))
                                    .foregroundColor(.white)
                                    .padding(15)
                                    .background(Color.white.opacity(0.25))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                                Text("التقدم الأسبوعي")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                
                                Text("تتبع إنجازات الأسبوع")
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        )
                        .padding(.horizontal)
                        .padding(.top, -35)     // ← هذا اللي يخليه ممتد لفوق
    
    
                    // ---------------------------------------------------
                    //   كرت نسبة الإنجاز الأسبوعية
                    // ---------------------------------------------------
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(
                                colors: [Color.blue.opacity(0.6), Color.yellow.opacity(0.5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 150)
                        .overlay(
                            HStack(spacing: 20) {
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.25))
                                    .frame(width: 80, height: 80)
                                    .overlay(
                                        Image(systemName: "chart.bar.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 35))
                                    )
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("نسبة الإنجاز الأسبوعية")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    
                                    Text("50%")
                                        .foregroundColor(.white)
                                        .font(.system(size: 34, weight: .bold))
                                    
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white.opacity(0.4))
                                            .frame(height: 7)
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .frame(width: 210, height: 7)
                                    }
                                }
                            }
                            .padding(.horizontal, 25)
                        )
                        .padding(.horizontal)
                    
                    // ---------------------------------------------------
                    //   كرت تفاصيل الأيام
                    // ---------------------------------------------------
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.25), radius: 10, y: 5)
                        .frame(maxWidth: .infinity)
                        .frame(height: 330)
                        .padding(.horizontal)
                        .overlay(
                            VStack(alignment: .leading, spacing: 20) {
                                Text("تفاصيل الأيام")
                                    .font(.title3)
                                    .bold()
                                    .padding(.top, 20)
                                
                                dayRow(day: "الأحد")
                                dayRow(day: "الاثنين")
                                dayRow(day: "الثلاثاء")
                                dayRow(day: "الأربعاء")
                                dayRow(day: "الخميس")
                                dayRow(day: "الجمعة")
                                dayRow(day: "السبت")
                                
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
//   مكوّن صف اليوم (نفس الشكل 100% كما في الصورة)
// -------------------------------------------------------------
func dayRow(day: String) -> some View {
    HStack {
        Text("50%")
            .font(.system(size: 14))
            .foregroundColor(.gray)
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.15))
                .frame(width: 180, height: 7)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [Color.yellow, Color.blue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 90, height: 7)
        }
        
        Spacer()
        
        Text(day)
            .font(.system(size: 16))
    }
}

#Preview {
    Progressview()
}
