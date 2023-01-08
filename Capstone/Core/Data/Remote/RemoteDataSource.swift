//
//  RemoteDataSource.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol {
    
    func getGenres() -> Observable<[GenreResponse]>
    func getGameDetail(id: String) -> Observable<GameDetailResponse>
    func getGames(with search: String) -> Observable<[GameResultResponse]>
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getGames(with search: String) -> Observable<[GameResultResponse]> {
        return Observable<[GameResultResponse]>.create({ observer in
            if let url = URL(string: Endpoints.Gets.games.url) {
                AF.request(url, parameters: API.keyParams(with: search))
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value.results ?? [])
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        })
    }
    
    func getGameDetail(id: String) -> Observable<GameDetailResponse> {
        return Observable<GameDetailResponse>.create({ observer in
            if let url = URL(string: Endpoints.Gets.gameDetails(id: id).url) {
                AF.request(url, parameters: API.keyParams())
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        })
    }
    
    func getGenres() -> Observable<[GenreResponse]> {
        return Observable<[GenreResponse]>.create { observer in
            if let url = URL(string: Endpoints.Gets.genres.url) {
                AF.request(url, parameters: API.keyParams())
                    .validate()
                    .responseDecodable(of: GenresResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
