//
//  GameDetailMapper.swift
//  Capstone
//
//  Created by Ade on 12/31/22.
//

import Foundation

final class GameDetailMapper {
    
    static func mapGameDetailResponsesToDomains(
        input gameDetailResponses: GameDetailResponse
    ) -> GameDetail {
        
        return GameDetail(id: gameDetailResponses.id,
                          slug: gameDetailResponses.slug,
                          name: gameDetailResponses.name,
                          nameOriginal: gameDetailResponses.nameOriginal,
                          gameDetailDescription: gameDetailResponses.gameDetailDescription,
                          metacritic: gameDetailResponses.metacritic,
                          released: gameDetailResponses.released,
                          tba: gameDetailResponses.tba,
                          updated: gameDetailResponses.updated,
                          backgroundImage: gameDetailResponses.backgroundImage,
                          backgroundImageAdditional: gameDetailResponses.backgroundImageAdditional,
                          website: gameDetailResponses.website,
                          rating: gameDetailResponses.rating,
                          ratingTop: gameDetailResponses.ratingTop,
                          ratings: gameDetailResponses.ratings,
                          added: gameDetailResponses.added,
                          addedByStatus: gameDetailResponses.addedByStatus,
                          playtime: gameDetailResponses.playtime,
                          screenshotsCount: gameDetailResponses.screenshotsCount,
                          moviesCount: gameDetailResponses.moviesCount,
                          creatorsCount: gameDetailResponses.creatorsCount,
                          achievementsCount: gameDetailResponses.achievementsCount,
                          parentAchievementsCount: gameDetailResponses.parentAchievementsCount,
                          redditURL: gameDetailResponses.redditURL,
                          redditName: gameDetailResponses.redditName,
                          redditDescription: gameDetailResponses.redditDescription,
                          redditLogo: gameDetailResponses.redditLogo,
                          redditCount: gameDetailResponses.redditCount,
                          twitchCount: gameDetailResponses.twitchCount,
                          youtubeCount: gameDetailResponses.youtubeCount,
                          reviewsTextCount: gameDetailResponses.reviewsTextCount,
                          ratingsCount: gameDetailResponses.ratingsCount,
                          suggestionsCount: gameDetailResponses.suggestionsCount,
                          metacriticURL: gameDetailResponses.metacriticURL,
                          parentsCount: gameDetailResponses.parentsCount,
                          additionsCount: gameDetailResponses.additionsCount,
                          gameSeriesCount: gameDetailResponses.gameSeriesCount,
                          reviewsCount: gameDetailResponses.reviewsCount,
                          communityRating: gameDetailResponses.communityRating,
                          saturatedColor: gameDetailResponses.saturatedColor,
                          dominantColor: gameDetailResponses.dominantColor,
                          parentPlatforms: gameDetailResponses.parentPlatforms,
                          platforms: gameDetailResponses.platforms,
                          stores: gameDetailResponses.stores,
                          developers: gameDetailResponses.developers,
                          genres: gameDetailResponses.genres,
                          tags: gameDetailResponses.tags,
                          publishers: gameDetailResponses.publishers,
                          esrbRating: gameDetailResponses.esrbRating,
                          descriptionRaw: gameDetailResponses.descriptionRaw)
    }
}
