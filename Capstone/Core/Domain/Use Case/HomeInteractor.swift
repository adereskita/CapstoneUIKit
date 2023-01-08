//
//  HomeInteractor.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import Foundation
import RxSwift

protocol HomeUseCase {
//    func getGenres(completion: @escaping (Result<GenresModel, Error>) -> Void)
    func getGenres() -> Observable<[GenreResult]>
    func getGames(with search: String) -> Observable<[GameResult]>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: CapstoneRepositoryProtocol
    
    required init(repository: CapstoneRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGenres() -> Observable<[GenreResult]> {
        return self.repository.getGenres()
    }
    
    func getGames(with search: String) -> Observable<[GameResult]> {
        return self.repository.getGames(with: search)
    }
}
