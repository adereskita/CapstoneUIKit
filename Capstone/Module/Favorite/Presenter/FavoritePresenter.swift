//
//  FavoritePresenter.swift
//  Capstone
//
//  Created by Ade on 12/25/22.
//

import Foundation
import RxSwift

class FavoritePresenter {
    
    private let disposeBag = DisposeBag()
    private let favoriteUseCase: FavoriteUseCase
    var favorites: [FavoriteModel]?
    var errorMessage: String = ""
    var loadingState: Bool = false
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavorites() {
        favoriteUseCase.getFavorites()
            .observe(on: MainScheduler.instance)
            .subscribe { res in
                self.favorites = res
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func removeFavorite(id: String) {
        favoriteUseCase.removeFavorites(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
}
