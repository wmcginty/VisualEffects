//
//  City.swift
//  VisualEffects
//
//  Created by Will McGinty on 8/2/24.
//

import Foundation

struct City: Hashable, Identifiable {
    
    // MARK: - Properties
    let name: String
    let image: String

    var id: String { name }

    // MARK: - Preset
    static let newYork = City(name: "New York", image: "nyc")
    static let shanghai = City(name: "Shanghai", image: "shanghai")
    static let dubai = City(name: "Dubai", image: "dubai")
    static let milan = City(name: "Milan", image: "milan")
    static let chicago = City(name: "Chicago", image: "chicago")
}
