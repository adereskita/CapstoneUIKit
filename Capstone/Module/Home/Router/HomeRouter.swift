//
//  HomeRouter.swift
//  Capstone
//
//  Created by Ade Reskita on 19/12/22.
//

import UIKit

class HomeRouter {
    var viewController: HomeViewController
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func routeToDetail(header: String, id: String) {
        let detailUseCase = Injection.init().provideDetail()
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        let detailVC = GameDetailViewController(with: presenter)
        detailVC.navigationItem.title = header
        detailVC.id = id
        self.viewController.navigationController?.setNavigationBarHidden(false, animated: true)
        self.viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func routeToAbout() {
        let aboutVc = AboutViewController()
        aboutVc.navigationItem.title = "About"
        self.viewController.navigationController?.setNavigationBarHidden(false, animated: true)
        self.viewController.navigationController?.pushViewController(aboutVc, animated: true)
    }
    
    func routeToFavorite() {
        let favoriteUseCase = Injection.init().provideFavorites()
        let presenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        let favVC = FavoriteViewController(with: presenter)
        favVC.navigationItem.title = "Favorites"
        self.viewController.navigationController?.setNavigationBarHidden(false, animated: true)
        self.viewController.navigationController?.pushViewController(favVC, animated: true)
    }
}
