//
//  ContentView.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Hue Rotate") { HueRotationView() }
                NavigationLink("Morph (Scroll)") { ScrollMorphView() }
                NavigationLink("Morph (Tap)") { TapMorphView() }
                NavigationLink("Parallax") { ParallaxView() }
                NavigationLink("Ripple") { RippleView() }
                NavigationLink("Scroll Effect") { ScrollEffectView() }
                NavigationLink("Text Move Transition") { TextMoveView() }
                NavigationLink("Twirl Transition") { TwirlTransitionView() }
            }
            .navigationTitle("Effects")
        }
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
