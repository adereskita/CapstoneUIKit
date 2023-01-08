//
//  MainMockHelper.swift
//  CapstoneTests
//
//  Created by Ade on 1/8/23.
//

import Foundation
import RealmSwift
@testable import Capstone

class MainMockHelper {
    func provideRepository() -> CapstoneRepositoryProtocol {
        
        let realm = try? Realm()

        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return CapstoneRepository.sharedInstance(remote, local)
    }
}
