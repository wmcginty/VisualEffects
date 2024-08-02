//
//  RippleView.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/1/24.
//

import SwiftUI

struct RippleView: View {

    @State var counter: Int = 0
    @State var origin: CGPoint = .zero

    var body: some View {
        VStack {
            Spacer()

            Image("palm_tree")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .onPressingChanged { point in
                    if let point {
                        origin = point
                        counter += 1
                    }
                }
                .modifier(RippleEffect(at: origin,
                                       trigger: counter,
                                       duration: 3.0))
                .modifier(PushEffect(trigger: counter))
                .shadow(radius: 3, y: 2)

            Spacer()
        }
        .padding()
        .navigationTitle("Ripple")
    }
}

#Preview {
    RippleView()
}

#Preview("Ripple Editor") {
    @Previewable @State var origin: CGPoint = .zero
    @Previewable @State var time: TimeInterval = 0.3
    @Previewable @State var amplitude: TimeInterval = 12
    @Previewable @State var frequency: TimeInterval = 15
    @Previewable @State var decay: TimeInterval = 8

    VStack {
        GroupBox {
            Grid {
                GridRow {
                    VStack(spacing: 4) {
                        Text("Time")
                        Slider(value: $time, in: 0 ... 2)
                    }

                    VStack(spacing: 4) {
                        Text("Amplitude")
                        Slider(value: $amplitude, in: 0 ... 100)
                    }
                }

                GridRow {
                    VStack(spacing: 4) {
                        Text("Frequency")
                        Slider(value: $frequency, in: 0 ... 30)
                    }
                    
                    VStack(spacing: 4) {
                        Text("Decay")
                        Slider(value: $decay, in: 0 ... 20)
                    }
                }
            }
            .font(.subheadline)
        }

        Spacer()

        Image("palm_tree")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .modifier(RippleModifier(origin: origin,
                                     elapsedTime: time,
                                     duration: 2,
                                     amplitude: amplitude,
                                     frequency: frequency,
                                     decay: decay))
            .shadow(radius: 3, y: 2)
            .onTapGesture {
                origin = $0
            }

        Spacer()
    }
    .padding(.horizontal)
}
