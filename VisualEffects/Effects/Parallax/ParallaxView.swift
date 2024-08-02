//
//  ParallaxView.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/1/24.
//

import SwiftUI

struct ParallaxView: View {

    // MARK: - Properties
    let cities: [City] = [.newYork, .shanghai, .dubai, .milan, .chicago]
    @State private var parallax: Bool = true

    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack {
                Toggle("Parallax?", isOn: $parallax)
                    .padding()

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(cities) { city in
                            CityView(city: city, parallax: parallax)
                                .aspectRatio(1, contentMode: .fit)
                                .containerRelativeFrame(.horizontal)
                        }
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(20)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                .navigationTitle("Cities")
            }
        }
    }
}

// MARK: - CityView
private struct CityView: View {

    // MARK: - Properties
    let city: City
    let parallax: Bool

    // MARK: - View
    var body: some View {
        ZStack {
            Color.cyan
            Image(city.image)
                .resizable()
                .scrollTransition(axis: .horizontal) { content, phase in
                    content
                        .offset(x: parallax ? phase.value * -200: 0)
                }

            Text(city.name)
                .font(.subheadline.bold().smallCaps())
                .foregroundStyle(.white)
                .shadow(radius: 1)
                .padding(8)
                .background(.ultraThinMaterial)
                .clipShape(.capsule)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        }
        .clipShape(.rect(cornerRadius: 24))
        .shadow(radius: 3)
    }
}

#Preview {
    ParallaxView()
}
