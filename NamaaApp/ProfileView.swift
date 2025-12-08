//
//  ProfileView.swift
//  NamaaApp
//
//  Created by Elham Alhemidi on 10/06/1447 AH.
//

import SwiftUI
import UIKit

// MARK: - Constants
// Design colors
private let topGradientStart = Color(red: 0.95, green: 0.85, blue: 0.50)
private let topGradientEnd   = Color(red: 0.50, green: 0.70, blue: 0.95)

// MARK: - Entry
struct ProfileView: View {
    var body: some View {
        VStack(spacing: 0) {
            TopHeaderView()
                // رفع الهيدر قليلًا للأعلى
                .padding(.top, -8)
            
            // Profile content only
            ProfileContent()
                .padding(.top, 4) // كانت 12، قلّلناها لرفع البطاقات للأعلى
        }
        .environment(\.layoutDirection, .leftToRight) // LTR
        .background(Color.white)
        // Bottom safe inset
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 12)
        }
    }
}

// MARK: - Main Views
struct TopHeaderView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                gradient: Gradient(colors: [topGradientStart, topGradientEnd]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 220)
            .clipShape(RoundedCornerShape(radius: 28, corners: [.bottomLeft, .bottomRight]))
            
            VStack(spacing: 10) {
                // Simple avatar
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.white.opacity(0.25))
                    Image(systemName: "person")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
                .frame(width: 64, height: 64)
                // Top spacing to avoid status bar overlap (قلّلناها لرفع المحتوى)
                .padding(.top, 12)
                
                // Name and subtitle
                VStack(spacing: 2) {
                    Text("Ahmed Mohammed")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Father of a special child")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            .padding(.bottom, 20)
        }
        // تمديد الهيدر خلف شريط الحالة لرفعه بصريًا
        .ignoresSafeArea(edges: .top)
    }
}

struct ProfileContent: View {
    let statData: [(number: String, label: String, color: Color, icon: String)] = [
        ("12", "Badges Earned", .orange, "trophy.fill"),
        ("45", "Active Days", .blue, "calendar")
    ]
    
    let badges = ["💪", "🥇", "⭐️", "✨", "📚", "🎨", "👑", "🎯"]
    
    private let statColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Child info card
                ChildInfoCard()
                    .padding(.horizontal, 16)
                    // .padding(.top, 12) أزلناها لرفع البطاقة للأعلى
                
                // Stats cards (equal squares using aspectRatio)
                LazyVGrid(columns: statColumns, spacing: 12) {
                    ForEach(statData, id: \.label) { item in
                        StatCard(number: item.number,
                                 label: item.label,
                                 color: item.color,
                                 iconName: item.icon)
                        .aspectRatio(1, contentMode: .fit) // مربعات متساوية تمامًا
                    }
                }
                .padding(.horizontal, 16)
                
                // Badges
                BadgesSection(title: "Badges & Achievements ⭐️", badges: badges)
                    .padding(.horizontal, 16)
                    
            }
            .padding(.top, 4) // كانت 8، قلّلناها لرفع المحتوى للأعلى
        }
        // إزالة الخلفية الرمادية واستبدالها بالأبيض
        .background(Color.white)
    }
}

// MARK: - Components
// Child info card
struct ChildInfoCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title: text then emoji (left aligned)
            HStack(spacing: 6) {
                Text("Child Information")
                    .font(.headline)
                Text("👶")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 4)
            
            // Rows
            InfoRow(label: "Name", value: "Layan")
            Divider()
            InfoRow(label: "Age", value: "5 years")
            Divider()
            InfoRow(label: "Therapy Plan", value: "Comprehensive Development")
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// Simple LTR info row: Label : Value
struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 8) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.black)
                .frame(width: 110, alignment: .leading)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
            
            Text(":")
                .foregroundColor(.black.opacity(0.6))
            
            Text(value)
                .font(.body)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 6)
    }
}

// Stat card
struct StatCard: View {
    let number: String
    let label: String
    let color: Color
    let iconName: String
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(color.opacity(0.18))
                    .frame(width: 44, height: 44)
                Image(systemName: iconName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(color)
            }
            Text(number)
                .font(.headline)
                .foregroundColor(.black)
            Text(label)
                .font(.footnote)
                .foregroundColor(.black.opacity(0.7))
                .lineLimit(1)
                .minimumScaleFactor(0.8) // لتفادي اللف وكسر التساوي
        }
        .padding(12)
        .frame(maxWidth: .infinity) // يضمن تمدد البطاقة داخل العمود
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
        )
    }
}

// Badges section
struct BadgesSection: View {
    let title: String
    let badges: [String]
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                ForEach(badges, id: \.self) { emoji in
                    BadgeItem(emoji: emoji)
                        .frame(height: 48)
                }
            }
        }
        .padding(12)
        .background(
            // جعل الحاوية نفسها بيضاء
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

// Badge item
struct BadgeItem: View {
    let emoji: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.orange.opacity(0.5), lineWidth: 1)
                )
            Text(emoji)
                .font(.system(size: 22))
        }
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Helpers
// Rounded corners for specific edges (used by header bottom)
struct RoundedCornerShape: Shape {
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

// MARK: - Preview
#Preview {
    ProfileView()
}
