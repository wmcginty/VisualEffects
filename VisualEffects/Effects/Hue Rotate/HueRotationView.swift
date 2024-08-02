//
//  HueRotationView.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/1/24.
//

import SwiftUI

struct HueRotationView: View {

    // MARK: - Properties
    private let list = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(separator: "")

    // MARK: - View
    var body: some View {
        ScrollView {
            VStack {
                ForEach(list, id: \.self) { char in
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.blue.gradient)
                        .frame(height: 100)
                        .overlay {
                            Text(char)
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                        .visualEffect { content, proxy in
                            content
                                .hueRotation(.degrees(proxy.frame(in: .global).origin.y) / 10)
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Hue Rotate")
    }
}

#Preview {
    HueRotationView()
}
