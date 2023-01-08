//
//  GameMapper.swift
//  Capstone
//
//  Created by Ade on 12/31/22.
//

import Foundation

final class GameMapper {

  static func mapGameSearchResponsesToDomains(
    input gameResponses: [GameResultResponse]
  ) -> [GameResult] {

    return gameResponses.map { result in
        return GameResult(id: result.id,
                          slug: result.slug,
                          name: result.name,
                          released: result.released,
                          tba: result.tba,
                          backgroundImage: result.backgroundImage,
                          rating: result.rating,
                          ratingTop: result.ratingTop,
                          ratings: result.ratings,
                          ratingsCount: result.ratingsCount,
                          reviewsTextCount: result.reviewsTextCount,
                          added: result.added,
                          addedByStatus: result.addedByStatus,
                          metacritic: result.metacritic,
                          playtime: result.playtime,
                          suggestionsCount: result.suggestionsCount,
                          updated: result.updated,
                          reviewsCount: result.reviewsCount,
                          saturatedColor: result.saturatedColor,
                          dominantColor: result.dominantColor,
                          platforms: result.platforms,
                          parentPlatforms: result.parentPlatforms,
                          genres: result.genres,
                          stores: result.stores,
                          esrbRating: result.esrbRating,
                          shortScreenshots: result.shortScreenshots
        )
    }
  }
  
}
