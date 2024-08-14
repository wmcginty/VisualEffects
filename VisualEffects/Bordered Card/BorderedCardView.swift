//
//  BorderedCard.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/9/24.
//

import SwiftUI

struct BorderedCardView: View {

    @State private var rotation: Angle = .degrees(0)

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.background.secondary)
                .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 24)
                .fill(.black)
                .aspectRatio(2/3, contentMode: .fit)
                .containerRelativeFrame(.horizontal) { l,_  in l * 0.75 }
                .shadow(color: .black.opacity(0.5), radius: 10, y: 10)

            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(colors: [.blue.opacity(0.01), .blue, .blue, .blue.opacity(0.01)], startPoint: .top, endPoint: .bottom))
                .aspectRatio(4, contentMode: .fit)
                .containerRelativeFrame(.horizontal) { l, _ in l * 1.5 }
                .shadow(color: .black.opacity(0.5), radius: 10, y: 10)
                .rotationEffect(rotation)
                .mask {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(lineWidth: 4)
                        .aspectRatio(2/3, contentMode: .fill)
                        .containerRelativeFrame(.horizontal) { l,_  in l * 0.75 }
                }
                .onAppear {
                    withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                        rotation = .degrees(360)
                    }
                }
        }
        .navigationTitle("Border")
    }
}

#Preview {
    NavigationStack {
        BorderedCardView()
    }
}
