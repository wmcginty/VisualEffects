//
//  Page.swift
//  Morph
//
//  Created by Will McGinty on 7/30/24.
//

import Foundation

struct Page: Hashable {
    let symbolName: String
    let title: String
    let subtitle: String

    var next: Page {
        switch self {
        case .page1: return .page2
        case .page2: return .page3
        case .page3: return .page4
        case .page4: return .page1
        default: return .page1
        }
    }

    static let page1 = Page(
        symbolName: "skateboard.fill",
        title: "Welcome to the App!",
        subtitle: "Welcome to our app, your gateway to a world of possibilities. Whether you're here to learn, play, or explore, we have something for everyone. Discover new features, customize your experience, and make the app truly yours. We're excited to have you on board and can't wait to see how you'll make the most of what we offer. Let's get started and embark on this exciting journey together!"
    )

    static let page2 = Page(
        symbolName: "gamecontroller.fill",
        title: "Games and Fun",
        subtitle: "Dive into a universe filled with exciting games and endless fun. Our app offers a wide variety of games that cater to all interests, from action-packed adventures to brain-teasing puzzles. Whether you're a casual gamer or a hardcore enthusiast, you'll find games that challenge your skills and provide hours of entertainment. Join our vibrant community of gamers, participate in tournaments, and earn rewards as you progress. Get ready to immerse yourself in a gaming experience like no other!"
    )

    static let page3 = Page(
        symbolName: "storefront.fill",
        title: "Shop with Ease",
        subtitle: "Experience the convenience of shopping at your fingertips. Our app connects you with the best deals and a wide range of products that cater to your every need. Browse through categories, discover trending items, and enjoy exclusive discounts. With our secure payment system and seamless checkout process, shopping has never been easier or more enjoyable. Stay updated with notifications about new arrivals and special offers, ensuring you never miss out on a great deal. Happy shopping!"
    )

    static let page4 = Page(
        symbolName: "flask.fill",
        title: "Innovate and Create",
        subtitle: "Unleash your creativity and experiment with innovative tools that empower you to create something amazing. Whether you're an artist, a developer, or just curious, our app provides a platform to explore new ideas and bring them to life. Collaborate with like-minded individuals, access a library of resources, and share your creations with the world. Innovation is at the heart of what we do, and we can't wait to see what you'll achieve with our tools. Let your imagination run wild!"
    )
}
