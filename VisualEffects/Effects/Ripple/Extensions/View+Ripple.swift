//
//  View+Ripple.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/1/24.
//

import SwiftUI

/// A modifer that performs a ripple effect to its content whenever its trigger value changes.
struct RippleEffect<T: Equatable>: ViewModifier {

    // MARK: - Properties
    var origin: CGPoint
    var trigger: T
    var duration: TimeInterval

    // MARK: - Initializer
    init(at origin: CGPoint, trigger: T, duration: TimeInterval = 3) {
        self.origin = origin
        self.trigger = trigger
        self.duration = duration
    }

    // MARK: - ViewModifier
    func body(content: Content) -> some View {
        let origin = origin
        let duration = duration

        content.keyframeAnimator(initialValue: 0, trigger: trigger) { view, elapsedTime in
            view.modifier(RippleModifier(origin: origin, elapsedTime: elapsedTime, duration: duration))
            
        } keyframes: { _ in
            MoveKeyframe(0)
            LinearKeyframe(duration, duration: duration)
        }
    }
}

/// A modifier that applies a ripple effect to its content.
struct RippleModifier: ViewModifier {

    // MARK: - Properties
    var origin: CGPoint
    var elapsedTime: TimeInterval
    var duration: TimeInterval

    var amplitude: Double = 12
    var frequency: Double = 15
    var decay: Double = 8
    var speed: Double = 1200

    // MARK: - Interface
    private var maxSampleOffset: CGSize { return CGSize(width: amplitude, height: amplitude) }

    // MARK: - ViewModifier
    func body(content: Content) -> some View {
        let shader = ShaderLibrary.Ripple(
            .float2(origin),
            .float(elapsedTime),

            // Parameters
            .float(amplitude),
            .float(frequency),
            .float(decay),
            .float(speed)
        )

        let maxSampleOffset = maxSampleOffset
        let elapsedTime = elapsedTime
        let duration = duration

        content.visualEffect { view, _ in
            view.layerEffect(
                shader,
                maxSampleOffset: maxSampleOffset,
                isEnabled: 0 < elapsedTime && elapsedTime < duration
            )
        }
    }


}
