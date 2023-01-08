//
//  FavoriteRouter.swift
//  Capstone
//
//  Created by Ade on 12/26/22.
//

import Foundation

class FavoriteRouter {
    var viewController: FavoriteViewController
    
    init(viewController: FavoriteViewController) {
        self.viewController = viewController
    }
    
    func routeToDetail(id: String) {
        let detailUseCase = Injection.init().provideDetail()
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        let detailVC = GameDetailViewController(with: presenter)
        detailVC.id = id
        self.viewController.navigationController?.setNavigationBarHidden(false, animated: true)
        self.viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
