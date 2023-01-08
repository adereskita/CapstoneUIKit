//
//  FavoriteViewTests.swift
//  Capstone
//
//  Created by Ade on 1/8/23.
//

import XCTest
@testable import Capstone
import RealmSwift
import RxSwift

final class FavoriteViewTests: XCTestCase {
    
    var controller: FavoriteViewController?
    var mockService: MockFavoriteView!
    var presenter: FavoritePresenter?

    override func setUp() {
        mockService = MockFavoriteView(repository: mockService.provideRepository())
        presenter = FavoritePresenter(favoriteUseCase: mockService)
        controller = FavoriteViewController(with: presenter!)
        controller?.view
    }
    
    override func tearDown() {
        controller = nil
        presenter = nil
        mockService = nil
    }

}
