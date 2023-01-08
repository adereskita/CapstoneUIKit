//
//  GamesResponse.swift
//  Capstone
//
//  Created by Ade on 12/31/22.
//

import Foundation

// MARK: - Games
struct GamesResponse: Codable {
    let count: Int?
    let next, previous: String?
    let results: [GameResultResponse]?
    let seoTitle, seoDescription, seoKeywords, seoH1: String?
    let noindex, nofollow: Bool?
    let gamesDescription: String?
    let filters: FiltersResponse?
    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case gamesDescription = "description"
        case filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct FiltersResponse: Codable {
    let years: [FiltersYearResponse]?
}

// MARK: - FiltersYear
struct FiltersYearResponse: Codable {
    let from, to: Int?
    let filter: String?
    let decade: Int?
    let years: [YearYearResponse]?
    let nofollow: Bool?
    let count: Int?
}

// MARK: - YearYear
struct YearYearResponse: Codable {
    let year, count: Int?
    let nofollow: Bool?
}

// MARK: - Result
struct GameResultResponse: Codable {
    let id: Int?
    let slug, name, released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount, reviewsTextCount, added: Int?
    let addedByStatus: AddedByStatus?
    let metacritic: Int?
    let playtime, suggestionsCount: Int?
    let updated: String?
    let reviewsCount: Int?
    let saturatedColor, dominantColor: Color?
    let platforms: [PlatformElement]?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]?
    let stores: [Store]?
    let esrbRating: EsrbRating?
    let shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
}
