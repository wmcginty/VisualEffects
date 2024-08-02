//
//  SpatialPressGesture.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/1/24.
//

import SwiftUI

struct SpatialPressGesture: UIGestureRecognizerRepresentable {

    // MARK: - Coordinator
    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        @objc
        func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWith other: UIGestureRecognizer
        ) -> Bool {
            true
        }
    }

    // MARK - Properties
    @Binding var location: CGPoint?

    // MARK: - UIGestureRecognizerRepresentable
    func makeCoordinator(converter: CoordinateSpaceConverter) -> Coordinator {
        Coordinator()
    }

    func makeUIGestureRecognizer(context: Context) -> UILongPressGestureRecognizer {
        let recognizer = UILongPressGestureRecognizer()
        recognizer.minimumPressDuration = 0
        recognizer.delegate = context.coordinator

        return recognizer
    }

    func handleUIGestureRecognizerAction(_ recognizer: UIGestureRecognizerType, context: Context) {
        switch recognizer.state {
        case .began: location = context.converter.localLocation
        case .ended, .cancelled, .failed: location = nil
        default: break
        }
    }
}

// MARK: - View + SpatialPressGesture
extension View {

    func onPressingChanged(_ action: @escaping (CGPoint?) -> Void) -> some View {
        modifier(_SpatialPressGestureModifier(action: action))
    }
}

private struct _SpatialPressGestureModifier: ViewModifier {

    // MARK: - Properties
    var onPressingChanged: (CGPoint?) -> Void
    @State var currentLocation: CGPoint?

    // MARK: - Initializer
    init(action: @escaping (CGPoint?) -> Void) {
        self.onPressingChanged = action
    }

    // MARK: - ViewModifier
    func body(content: Content) -> some View {
        let gesture = SpatialPressGesture(location: $currentLocation)

        content
            .gesture(gesture)
            .onChange(of: currentLocation, initial: false) { _, location in
                onPressingChanged(location)
            }
    }
}
