//
//  TaskRating.swift
//  NamaaApp
//

import Foundation

enum TaskRating: String, CaseIterable, Identifiable {
    case needsImprovement = "Needs Improvement"
    case good = "Good"
    case excellent = "Excellent"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .needsImprovement: return "😟"
        case .good: return "😐"
        case .excellent: return "😊"
        }
    }
}

