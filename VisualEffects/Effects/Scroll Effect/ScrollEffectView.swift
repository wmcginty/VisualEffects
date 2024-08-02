//
//  ScrollEffect.swift
//  VisualEffects
//
//  Created by Will McGinty on 6/8/23.
//

import SwiftUI

struct ScrollEffectView: View {

    // MARK: - Properties
    @State private var boxes: [Box] = Box.repeated
    @State private var topID: Box.ID?

    // MARK: - View
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(boxes) { box in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(box.color.gradient)
                            .aspectRatio(16 / 9, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .visualEffect { effect, proxy in
                                effect
                                    .offset(y: offset(for: effect, in: proxy))
                                    .scaleEffect(x: scale(for: effect, in: proxy), anchor: .top)
                                    .opacity(1 - opacity(for: effect, in: proxy))
                            }
                            .shadow(radius: 2)
                    }
                }
                .scrollTargetLayout()

                Button("Scroll To Top") {
                    withAnimation {
                        topID = boxes.first?.id
                    }
                }
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $topID)
            .contentMargins(12)
            .scrollIndicators(.hidden)
        }
        .navigationTitle(boxes.first { $0.id == topID }?.name ?? "--")
    }

    // MARK: - Helper
    nonisolated func offset(for effect: EmptyVisualEffect, in proxy: GeometryProxy) -> CGFloat {
        return -min(0, proxy.frame(in: .scrollView).minY)
    }

    nonisolated func opacity(for effect: EmptyVisualEffect, in proxy: GeometryProxy) -> CGFloat {
        return min(0.2, offset(for: effect, in: proxy) / proxy.frame(in: .scrollView).height * 0.5)
    }

    nonisolated func scale(for effect: EmptyVisualEffect, in proxy: GeometryProxy) -> CGFloat {
        let offsetFraction = offset(for: effect, in: proxy) * 0.05 / proxy.frame(in: .scrollView).height
        return (max(0.94, 1 - offsetFraction))
    }
}

#Preview {
    ScrollEffectView()
}
