//
//  View+Push.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/1/24.
//

import SwiftUI

struct PushEffect<T: Equatable>: ViewModifier {

    // MARK: - Properties
    var trigger: T

    // MARK: - ViewModifier
    func body(content: Content) -> some View {
        content.keyframeAnimator(initialValue: 1.0, trigger: trigger) { view, value in
            view.visualEffect { view, _ in
                view.scaleEffect(value)
            }
            
        } keyframes: { _ in
            SpringKeyframe(0.95, duration: 0.2, spring: .snappy)
            SpringKeyframe(1.0, duration: 0.2, spring: .bouncy)
        }
    }
}
