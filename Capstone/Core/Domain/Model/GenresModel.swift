//
//  GenresModel.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import Foundation

// MARK: - Genres
struct GenresModel {
    let count: Int
    let results: [GenreResult]
}

// MARK: - Result
struct GenreResult {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case games
    }
}

// MARK: - Game
struct Game: Codable {
    let id: Int
    let slug, name: String
    let added: Int
}
