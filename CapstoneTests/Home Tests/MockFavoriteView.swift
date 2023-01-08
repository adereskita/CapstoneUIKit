//
//  MockFavoriteView.swift
//  CapstoneTests
//
//  Created by Ade on 1/8/23.
//

import Foundation
import RxSwift
@testable import Capstone

class MockFavoriteView: MainMockHelper, FavoriteUseCase {
    
    private let repository: CapstoneRepositoryProtocol
    var isHomeUseCaseTested = false
    
    required init(repository: CapstoneRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavorites() -> Observable<[FavoriteModel]> {
        isHomeUseCaseTested = true
        return self.repository.getFavorites()
    }
    
    func removeFavorites(id: String) -> Observable<Bool> {
        isHomeUseCaseTested = true
        return self.repository.removeFavorites(id: id)
    }
}
