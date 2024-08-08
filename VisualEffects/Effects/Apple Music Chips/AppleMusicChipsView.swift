//
//  AppleMusicChipsView.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/8/24.
//

import SwiftUI

struct AppleMusicChipsView: View {

    let categories: [String] = ["Top Results", "Artists", "Albums", "Songs", "Playlists", "Music Videos", "Profiles"]
    @State private var selected: String = "Top Results"
    @Namespace var namespace

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(categories, id: \.self) { category in
                        ZStack {
                            Text(category)
                                .font(.caption.bold())
                                .padding(8)
                                .background {
                                    if category == selected {
                                        matchedCapsule
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.bouncy(duration: 0.2)) { selected = category }
                                }

                            Text(category)
                                .font(.caption.bold())
                                .transition(.identity)
                                .mask {
                                    matchedCapsule
                                }
                                .allowsHitTesting(false)
                        }
                    }
                }
            }
            .contentMargins(.horizontal, 16)
            .scrollIndicators(.hidden)

            Color.gray.opacity(0.2)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()

        }
    }

    var matchedCapsule: some View {
        Capsule()
            .fill(.red)
            .matchedGeometryEffect(id: "selected", in: namespace)
    }
}

#Preview {
    AppleMusicChipsView()
}
