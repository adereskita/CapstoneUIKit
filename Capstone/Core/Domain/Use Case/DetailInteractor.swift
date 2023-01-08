//
//  DetailInteractor.swift
//  Capstone
//
//  Created by Ade on 12/24/22.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getDetails(id: String) -> Observable<GameDetail>
    func addFavorites(from favorites: FavoriteEntity) -> Observable<Bool>
    func getFavorites() -> Observable<[FavoriteModel]>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: CapstoneRepositoryProtocol
    
    required init(repository: CapstoneRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetails(id: String) -> Observable<GameDetail> {
        return self.repository.getGameDetail(id: id)
    }
    
    func addFavorites(from favorites: FavoriteEntity) -> Observable<Bool> {
        return self.repository.addFavorites(from: favorites)
    }
    
    func getFavorites() -> Observable<[FavoriteModel]> {
        return self.repository.getFavorites()
    }
}
