//
//  GenresMapper.swift
//  Capstone
//
//  Created by Ade on 12/31/22.
//

import Foundation

final class GenresMapper {

  static func mapGenresResponsesToDomains(
    input genreResponses: [GenreResponse]
  ) -> [GenreResult] {

    return genreResponses.map { result in
      return GenreResult(
        id: result.id,
        name: result.name,
        slug: result.slug,
        gamesCount: result.gamesCount,
        imageBackground: result.imageBackground,
        games: result.games
      )
    }
  }
  
}
