//
//  MorphingSymbolView.swift
//  Morph
//
//  Created by Will McGinty on 7/30/24.
//

import SwiftUI

struct MorphingSymbolView: View {
    
    struct Config {
        var font: Font
        var frame: CGSize
        var radius: CGFloat
        var foregroundColor: Color
        var keyframeDuration: CGFloat = 0.4
        var keyframeAnimation: Animation = .smooth(duration: 0.4, extraBounce: 0)
    }

    struct AnimationValues: Equatable {
        var blur: CGFloat = 0
        var scale: CGFloat = 1
    }

    var symbol: String
    var config: Config

    @State private var trigger: Bool = false
    @State private var displayingSymbol: String = ""
    @State private var nextSymbol: String = ""

    var body: some View {
        Canvas { ctx, size in
            ctx.addFilter(.alphaThreshold(min: 0.4, color: config.foregroundColor))

            if let renderedImage = ctx.resolveSymbol(id: 0) {
                ctx.draw(renderedImage, at: .init(x: size.width * 0.5, y: size.height * 0.5))
            }
        } symbols: {
            imageView
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { oldValue, newValue in
            trigger.toggle()
            nextSymbol = newValue
        }
        .task {
            guard displayingSymbol == "" else { return }
            displayingSymbol = symbol
        }
    }

    var imageView: some View {
        KeyframeAnimator(initialValue: AnimationValues(), trigger: trigger) { values in
            Image(systemName: displayingSymbol == "" ? symbol: displayingSymbol)
                .font(config.font)
                .blur(radius: values.blur)
                .scaleEffect(values.scale)
                .frame(width: config.frame.width, height: config.frame.height)
                .onChange(of: values) { oldValue, newValue in
                    if newValue.blur.rounded() == config.radius {
                        withAnimation(config.keyframeAnimation) {
                            displayingSymbol = nextSymbol
                        }
                    }
                }
        } keyframes: { _ in
            KeyframeTrack(\.blur) {
                CubicKeyframe(config.radius, duration: config.keyframeDuration * 0.5)
                CubicKeyframe(0, duration: config.keyframeDuration)
            }

            KeyframeTrack(\.scale) {
                SpringKeyframe(1.05, duration: config.keyframeDuration)
                SpringKeyframe(1, duration: config.keyframeDuration)
            }
        }
    }
}

#Preview {
    MorphingSymbolView(symbol: "gearshape.fill", config: .init(font: .system(size: 100, weight: .bold),
                                                               frame: .init(width: 250, height: 200),
                                                               radius: 15,
                                                               foregroundColor: .black))
}
