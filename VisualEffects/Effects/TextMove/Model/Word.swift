//
//  Word.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/2/24.
//

import SwiftUI

struct Word: Hashable {

    // MARK: - Properties
    let title: String
    let color: Color

    // MARK: - Preset
    static let preset: [Word] = [
        .init(title: "fun", color: .red),
        .init(title: "powerful", color: .blue),
        .init(title: "frustrating", color: .green),
        .init(title: "flexible", color: .orange),
        .init(title: "inflexible", color: .purple),
        .init(title: "soul-destroying", color: .cyan),
        .init(title: "concise", color: .yellow),
    ]
}
