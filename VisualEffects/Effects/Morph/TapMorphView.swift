//
//  TapMorphView.swift
//  Morph
//
//  Created by Will McGinty on 7/30/24.
//

import SwiftUI

struct TapMorphView: View {

    // MARK: - Properties
    @State private var activePage: Page = .page1

    // MARK: - View
    var body: some View {
        VStack {
            MorphingSymbolView(symbol: activePage.symbolName,
                               config: .init(font: .system(size: 150, weight: .bold),
                                             frame: .init(width: 250, height: 200),
                                             radius: 40,
                                             foregroundColor: .white,
                                             keyframeDuration: 0.3,
                                             keyframeAnimation: .bouncy))
            .onTapGesture {
                activePage = activePage.next
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(.black)
        .navigationTitle("Morph")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TapMorphView()
    }
}
