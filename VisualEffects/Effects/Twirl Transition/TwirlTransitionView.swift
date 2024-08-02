//
//  TwirlTransitionView.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/1/24.
//

import SwiftUI

struct TwirlTransitionView: View {

    // MARK: - Properties
    @State private var showStack: Bool = true

    // MARK: - View
    var body: some View {
        Group {
            Toggle("Show Stack", isOn: $showStack.animation())
                .padding()

            if showStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
                .padding()
                .transition(Twirl())
            }
        }
        .navigationTitle("Twirl Transition")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct Twirl: Transition {

    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .scaleEffect(phase.isIdentity ? 1 : 0.5)
            .opacity(phase.isIdentity ? 1 : 0)
            .blur(radius: phase.isIdentity ? 0 : 10)
            .rotationEffect(
                .degrees(
                    phase == .willAppear ? 360 :
                        phase == .didDisappear ? -360 : .zero
                )
            )
            .brightness(phase == .willAppear ? 1 : 0)
    }
}

#Preview {
    TwirlTransitionView()
}
