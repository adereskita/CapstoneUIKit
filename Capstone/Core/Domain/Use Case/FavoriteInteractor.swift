//
//  FavoriteInteractor.swift
//  Capstone
//
//  Created by Ade on 12/25/22.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavorites() -> Observable<[FavoriteModel]>
    func removeFavorites(id: String) -> Observable<Bool>
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: CapstoneRepositoryProtocol
    
    required init(repository: CapstoneRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavorites() -> Observable<[FavoriteModel]> {
        return self.repository.getFavorites()
    }
    
    func removeFavorites(id: String) -> Observable<Bool> {
        return self.repository.removeFavorites(id: id)
    }
}
