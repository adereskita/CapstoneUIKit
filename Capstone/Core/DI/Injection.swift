//
//  Injection.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> CapstoneRepositoryProtocol {
        
        let realm = try? Realm()

        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return CapstoneRepository.sharedInstance(remote, local)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
    
    func provideFavorites() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
}
