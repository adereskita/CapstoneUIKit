//
//  CapstoneRepository.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import Foundation
import RxSwift

protocol CapstoneRepositoryProtocol {
//    func getGenres(result: @escaping (Result<GenresModel, Error>) -> Void)
    func getGenres() -> Observable<[GenreResult]>
    func getGameDetail(id: String) -> Observable<GameDetail>
    func getGames(with search: String) -> Observable<[GameResult]>
    func addFavorites(from favorites: FavoriteEntity) -> Observable<Bool>
    func getFavorites() -> Observable<[FavoriteModel]>
    func removeFavorites(id: String) -> Observable<Bool>
}

final class CapstoneRepository: NSObject {
    
    typealias CapstoneInstance = (RemoteDataSource, LocalDataSource) -> CapstoneRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: CapstoneInstance = { remoteRepo, localRepo in
        return CapstoneRepository(remote: remoteRepo, local: localRepo)
    }
    
}

extension CapstoneRepository: CapstoneRepositoryProtocol {
    
    func getGames(with search: String) -> Observable<[GameResult]> {
        return self.remote.getGames(with: search)
            .map({ GameMapper.mapGameSearchResponsesToDomains(input: $0) })
    }
    
    func getGameDetail(id: String) -> Observable<GameDetail> {
        return self.remote.getGameDetail(id: id)
            .map({ GameDetailMapper.mapGameDetailResponsesToDomains(input: $0) })
    }
    
    func getGenres() -> Observable<[GenreResult]> {
        return self.remote.getGenres()
            .map({ GenresMapper.mapGenresResponsesToDomains(input: $0) })
    }
    
    func addFavorites(from favorites: FavoriteEntity) -> Observable<Bool> {
        return self.local.addFavorites(from: favorites)
    }
    
    func getFavorites() -> Observable<[FavoriteModel]> {
        return self.local.getFavorites()
            .map({ FavoritesMapper.mapGamesEntitiesToDomains(input: $0) })
    }
    
    func removeFavorites(id: String) -> Observable<Bool> {
        return self.local.removeFavorites(id: id)
    }
}
