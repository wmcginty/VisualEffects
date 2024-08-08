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
                ForEach(list.indices, id: \.self) { idx in
                    let char = list[idx]
                    let isMe = idx % 3 == 0 || idx % 5 == 0
                    
                    GeometryReader { geometry in
                        Text(char)
                            .foregroundStyle(.white)
                            .frame(width: geometry.size.width * 0.75, height: 40)
                            .background((isMe ? Color.purple : .gray).gradient, in: .capsule)
                            .frame(width: geometry.size.width, alignment: isMe ? .leading : .trailing)
                            .visualEffect { content, proxy in
                                let degrees = isMe ? -proxy.frame(in: .global).origin.y / 10 : 0
                                return content
                                    .hueRotation(.degrees(degrees))
                            }
                    }
                    .frame(height: 40)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Hue Rotate")
    }
}

#Preview {
    NavigationStack {
        HueRotationView()
    }
}


