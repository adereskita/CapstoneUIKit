//
//  ModelMapper.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import Foundation

final class FavoritesMapper {
    
    static func mapGamesResponseToEntities(
        input categoryResponses: GameDetail?
    ) -> FavoriteEntity {
        let newCategory = FavoriteEntity()
        newCategory.id = "\(categoryResponses?.id ?? 0)"
        newCategory.title = categoryResponses?.nameOriginal ?? "Unknown"
        newCategory.imageUrl = categoryResponses?.backgroundImage ?? "Unknown"
        newCategory.desc = categoryResponses?.gameDetailDescription ?? "Unknown"
        return newCategory
    }
    
    static func mapGamesEntitiesToDomains(
        input favoriteEntities: [FavoriteEntity]
    ) -> [FavoriteModel] {
        return favoriteEntities.map { result in
            return FavoriteModel(
                id: result.id,
                title: result.title,
                imageUrl: result.imageUrl,
                desc: result.desc
            )
        }
    }
}
