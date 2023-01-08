//
//  GenreResponse.swift
//  Capstone
//
//  Created by Ade on 12/31/22.
//

import Foundation

// MARK: - Genres Response
struct GenresResponse: Codable {
    let count: Int
    let results: [GenreResponse]
}

// MARK: - Genre Object Response
struct GenreResponse: Codable {
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
struct GameResponse: Codable {
    let id: Int
    let slug, name: String
    let added: Int
}
