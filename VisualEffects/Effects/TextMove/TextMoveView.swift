//
//  TextMoveView.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/2/24.
//

import SwiftUI

struct TextMoveView: View {

    // MARK: - Properties
    var words: [Word]
    @State private var currentWord: Word

    // MARK: - Initializer
    init(words: [Word] = Word.preset) {
        self.words = words
        self._currentWord = .init(initialValue: words[0])
    }

    // MARK: - View
    var body: some View {
        Color.clear
            .contentShape(.rect)
            .overlay(alignment: .center) {
                Text("SwiftUI is ")
                    .alignmentGuide(HorizontalAlignment.center) { d in d[.trailing] }
            }
            .overlay(alignment: .center) {
                Text(currentWord.title)
                    .foregroundStyle(currentWord.color)
                    .fontWeight(.bold)
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                    .id(currentWord)
                    .alignmentGuide(HorizontalAlignment.center) { d in d[.leading] }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipped()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                if let index = words.firstIndex(of: currentWord),
                   let nextIndex = words.index(index, offsetBy: 1, limitedBy: words.endIndex - 1) {
                    withAnimation {
                        self.currentWord = self.words[nextIndex]
                    }
                } else {
                    withAnimation {
                        self.currentWord = self.words[0]
                    }
                }
            }
            .navigationTitle("Text")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TextMoveView()
}
