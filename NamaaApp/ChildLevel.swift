//
//  ChildLevel.swift
//  NamaaApp
//

import Foundation

enum ChildLevel: String, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"

    var id: String { rawValue }
}

