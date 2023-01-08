//
//  HomeViewController.swift
//  Capstone
//
//  Created by Ade Reskita on 16/12/22.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: SelfSizedTableView!
    var router: HomeRouter!
    var presenter: HomePresenter!
    var genres: [GenreResult]?
    private var searchGames: [GameResult]?
    private let disposeBag = DisposeBag()
    
//    convenience init(presenter: HomePresenter, router: HomeRouter) {
//        self.init()
//        self.presenter = presenter
//        self.router = router
//    }
    
    init(with presenter: HomePresenter, router: HomeRouter) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.presenter = nil
        self.router = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bind()
        setupTableview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupTableview() {
        tableView.register(HomeHeaderTableViewCell.nib(), forCellReuseIdentifier: HomeHeaderTableViewCell.identifier)
        tableView.register(SearchBarTableViewCell.nib(), forCellReuseIdentifier: SearchBarTableViewCell.identifier)
        tableView.register(HeroBannerTableViewCell.nib(), forCellReuseIdentifier: HeroBannerTableViewCell.identifier)
        tableView.register(GameListTableViewCell.nib(), forCellReuseIdentifier: GameListTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func bind() {
        presenter.getGenres()
        presenter.genres.subscribe(onNext: { [weak self] result in
            self?.genres = result
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        presenter.searchGames.subscribe(onNext: { [weak self] result in
            self?.searchGames = result
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSection.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeSection.getSection(section) {
        case .header:
            return 1
        case .searchBar:
            return 1
        case .heroBanner:
            return 1
        case .gameList:
            return searchGames?.isEmpty ?? true ? 0 : 1
        case .genreList:
            return searchGames?.isEmpty ?? true ? genres?.count ?? 0 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genreObj = genres?[indexPath.row]
        switch HomeSection.getSection(indexPath.section) {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeHeaderTableViewCell", for: indexPath) as? HomeHeaderTableViewCell else { return UITableViewCell() }
            
            cell.callBack = { [weak self] isGotoAbout in
                if isGotoAbout {
                    self?.router.routeToAbout()
                } else {
                    self?.router.routeToFavorite()
                }
            }
            
            return cell
        case .searchBar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarTableViewCell", for: indexPath) as? SearchBarTableViewCell else { return UITableViewCell() }
            
            cell.getTextSearchBar = { [unowned self] text in
                if text.isEmpty {
                    self.searchGames = nil
                    self.tableView.reloadData()
                } else {
                    self.presenter.fetchGames(with: text)
                }
            }
                        
            return cell
        case .heroBanner:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroBannerTableViewCell", for: indexPath) as? HeroBannerTableViewCell else { return UITableViewCell() }
            
            return cell
            
        case .genreList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameListTableViewCell", for: indexPath) as? GameListTableViewCell else { return UITableViewCell() }
            
            cell.callBack = { [weak self] model in
                if !model.name.isEmpty {
                    self?.router.routeToDetail(header: model.name, id: String(model.id))
                }
            }
            
            if presenter.loadingState {
                cell.showAnimatedGradientSkeleton()
            } else {
                cell.hideSkeleton()
            }
            
            cell.gameList = genreObj?.games
            cell.setData(data: genreObj)
            
            return cell
        case .gameList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameListTableViewCell", for: indexPath) as? GameListTableViewCell else { return UITableViewCell() }
            
            cell.callBackSearch = { [weak self] model in
                self?.router.routeToDetail(header: model.name!, id: String(model.id!))
            }
            cell.searchList = searchGames
            cell.setSearchData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
