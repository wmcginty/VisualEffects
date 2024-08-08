//
//  ScrollMorphView.swift
//  Morph
//
//  Created by Will McGinty on 7/31/24.
//

import SwiftUI

@available(iOS 18.0, *)
struct ScrollMorphView: View {

    // MARK: - Configuration
    struct Configuration {
        var maxBlurRadius: CGFloat = 40
        var alphaThreshold: CGFloat = 0.4
        var foregroundColor: Color = .white
    }

    // MARK: - Properties
    var pages: [Page] = [.page1, .page2, .page3, .page4]
    var configuration: Configuration = .init()
    @State private var currentPage: Page?
    @State private var nextPage: Page?
    @State private var currentBlurRadius: CGFloat

    @Environment(\.dismiss) private var dismiss

    // MARK: - Initializer
    init(pages: [Page] = [.page1, .page2, .page3, .page4], configuration: Configuration = .init()) {
        self.pages = pages
        self.configuration = configuration
        self._currentPage = .init(initialValue: pages[0])
        self._nextPage = .init(initialValue: pages[1])
        self._currentBlurRadius = .init(initialValue: 0)
    }

    // MARK: - View
    var body: some View {
        ZStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(pages, id: \.self) { page in
                            VStack {
                                Text(page.title)
                                    .font(.largeTitle.bold())
                                    .padding(.bottom)

                                Text(page.subtitle)
                                    .font(.subheadline.smallCaps())
                            }
                            .multilineTextAlignment(.center)
                            .padding()
                            .containerRelativeFrame([.horizontal, .vertical])
                            .foregroundStyle(.white)
                            .id(page)
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
                .onScrollGeometryChange(for: BlurPageStatus.self,
                                        of: { onScrollGeometryChange(scrollGeometry: $0) },
                                        action: { oldValue, newValue in
                    self.currentPage = newValue.page
                    self.nextPage = newValue.nextPage
                    self.currentBlurRadius = newValue.blurRadius
                })
                .overlay {
                    morphView
                        .allowsHitTesting(false)
                        .alignmentGuide(VerticalAlignment.center) { d in
                            d[.bottom] - (d.height * 0.25)
                        }
                }
                .toolbar {
                    Button(currentPage == pages.last ? "Done" : "Next") {
                        if let currentPage, let currentPageIndex = pages.firstIndex(of: currentPage), let nextIndex = pages.index(currentPageIndex, offsetBy: 1, limitedBy: pages.endIndex - 1) {
                            withAnimation {
                                proxy.scrollTo(pages[nextIndex])
                            }
                        } else {
                            dismiss()
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(.vertical, 100)
                    .padding(.trailing, 30)
                    .animation(.default, value: currentPage)
                }
            }
        }
        .navigationTitle("Morph")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Helper
    struct BlurPageStatus: Equatable {
        let page: Page
        let nextPage: Page?
        let blurRadius: CGFloat
    }

    func onScrollGeometryChange(scrollGeometry: ScrollGeometry) -> BlurPageStatus {
        let offsetPage = (scrollGeometry.contentOffset.x / scrollGeometry.bounds.width).rounded()
        let singlePageOffset = abs(scrollGeometry.contentOffset.x).truncatingRemainder(dividingBy: scrollGeometry.bounds.width)
        let adjusted = (singlePageOffset / scrollGeometry.bounds.width) - 0.5
        let blurPercentage = 1 - (abs(adjusted) / 0.5)

        let currentPage = offsetPage.isNaN ? pages[0] : pages[Int(offsetPage)]
        let nextPage = adjusted.sign == .plus ? pages.element(before: currentPage) : scrollGeometry.contentOffset.x > 0 ? pages.element(after: currentPage) : nil

        return .init(page: currentPage, nextPage: nextPage, blurRadius: blurPercentage * configuration.maxBlurRadius)
    }

    // MARK: - Subviews
    var morphView: some View {
        Canvas { ctx, size in
            ctx.addFilter(.alphaThreshold(min: configuration.alphaThreshold, color: configuration.foregroundColor))

            if let renderedImage = ctx.resolveSymbol(id: 0) {
                ctx.draw(renderedImage, at: .init(x: size.width * 0.5, y: size.height * 0.5))
            }

            if let renderedCircle = ctx.resolveSymbol(id: 1) {
                ctx.draw(renderedCircle, at: .init(x: size.width * 0.5, y: size.height * 0.5))
            }

        } symbols: {
            morphingView(for: currentPage)
                .tag(0)

            let blurScale = currentBlurRadius / configuration.maxBlurRadius
            morphingView(for: nextPage)
                .opacity(blurScale < 0.3 ? 0 : 1)
                .scaleEffect(blurScale)
                .tag(1)
        }
    }

    func morphingView(for page: Page?) -> some View {
        Image(systemName: page?.symbolName ?? "")
            .font(.system(size: 100, weight: .bold))
            .foregroundStyle(.white.gradient)
            .blur(radius: currentBlurRadius)
            .frame(width: 250, height: 200)
    }
}

// MARK: - Array Convenience
private extension Array where Element: Equatable {

    func element(before element: Element) -> Element? {
        if let index = firstIndex(of: element), let previousIndex = self.index(index, offsetBy: -1, limitedBy: startIndex) {
            return self[previousIndex]
        }

        return nil
    }

    func element(after element: Element) -> Element? {
        if let index = firstIndex(of: element), let nextIndex = self.index(index, offsetBy: 1, limitedBy: endIndex - 1) {
            return self[nextIndex]
        }

        return nil
    }

}

@available(iOS 18.0, *)
#Preview {
    ScrollMorphView()
}
