//
//  DetailPresenter.swift
//  Capstone
//
//  Created by Ade on 12/24/22.
//

import Foundation
import RxSwift

class DetailPresenter {

    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCase
    
    var gameDetails = PublishSubject<GameDetail>()
    var buttonTap = PublishSubject<FavoriteButtonState>()
    var reloadData = PublishSubject<Void>()
    
    var buttonStates = PublishSubject<Bool>()
    var errorMessage: String = ""
    var loadingState: Bool = true
        
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetails(id: String) {
        detailUseCase.getDetails(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gameDetails.onNext(result)
                self.configFavoriteButtonState(details: result)
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.reloadData.onNext(())
                    self.loadingState = false
                })
            }.disposed(by: disposeBag)
    }
    
    func addFavorite(favEntity: FavoriteEntity) {
        detailUseCase.addFavorites(from: favEntity)
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    private func configFavoriteButtonState(details: GameDetail) {
        let id = String(details.id ?? 0)
        detailUseCase.getFavorites()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                let matchId = result.filter { $0.id == id }
//                self.buttonStates.onNext(matchId.isEmpty ? .Unlike : .Liked)
                self.buttonStates.onNext(!matchId.isEmpty)
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.reloadData.onNext(())
                    self.loadingState = false
                })
            }.disposed(by: disposeBag)
    }
}
