//
//  HomePresenter.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import Foundation
import RxSwift

class HomePresenter {
    
    private let disposeBag = DisposeBag()
    private let homeUseCase: HomeUseCase
    
    var genres = PublishSubject<[GenreResult]>()
    var searchGames = PublishSubject<[GameResult]>()
    var errorMessage: String = ""
    var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGenres() {
        homeUseCase.getGenres()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.genres.onNext(result)
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func fetchGames(with search: String) {
        homeUseCase.getGames(with: search)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.searchGames.onNext(result)
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
}
