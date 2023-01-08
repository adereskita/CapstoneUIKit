//
//  FavoriteViewController.swift
//  Capstone
//
//  Created by Ade Reskita on 16/12/22.
//

import UIKit
import RxSwift

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: SelfSizedTableView!
    var presenter: FavoritePresenter!
    var router: FavoriteRouter!
    
    private let disposeBag = DisposeBag()
    
    init(with presenter: FavoritePresenter) {
        self.presenter = presenter
        super.init(nibName: "FavoriteViewController", bundle: nil)
        self.initRouter(router: FavoriteRouter(viewController: self))
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.presenter = nil
    }
    
    func initRouter(router: FavoriteRouter) {
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupTableview()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    func bind() {
        presenter.getFavorites()
    }
    
    func setupTableview() {
        tableView.register(FavoriteTableViewCell.nib(), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favObj = presenter.favorites?[indexPath.row]
        self.router.routeToDetail(id: favObj?.id ?? "")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let favObj = presenter.favorites?[indexPath.row]
        if editingStyle == .delete {
            presenter.removeFavorite(id: favObj?.id ?? "")
            presenter.favorites?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.favorites?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteObj = presenter.favorites?[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        cell.setData(data: favoriteObj)
        
        return cell
    }
}
