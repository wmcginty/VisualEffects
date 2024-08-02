//
//  Box.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/2/24.
//

import SwiftUI

struct Box: CaseIterable, Identifiable {

    // MARK: - Properties
    let id = UUID()
    let name: String
    let color: Color

    // MARK: - Preset
    static var allCases: [Box] {
        return [
            .init(name: "Red", color: .red),
            .init(name: "Orange", color: .orange),
            .init(name: "Yellow", color: .yellow),
            .init(name: "Green", color: .green),
            .init(name: "Blue", color: .blue),
            .init(name: "Indigo", color: .indigo),
            .init(name: "Violet", color: .purple)
        ]
    }

    static let repeated: [Box] = [allCases, allCases, allCases, allCases].flatMap { $0 }
}

//extension SwiftUI.Color {
//    static var random: SwiftUI.Color {
//        return SwiftUI.Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
//    }
//}
