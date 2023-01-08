//
//  GameDetailViewController.swift
//  Capstone
//
//  Created by Ade Reskita on 19/12/22.
//

import UIKit
import RxSwift
import SkeletonView

class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: SelfSizedTableView!
    var presenter: DetailPresenter!
    var gameDetail: GameDetail?
    var id: String = ""
    var isLiked = false
    
    private let disposeBag = DisposeBag()
    
    init(with presenter: DetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.presenter = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupTableview()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        self.tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }
    
    func setupTableview() {
        tableView.register(DetailImageTableViewCell.nib(), forCellReuseIdentifier: DetailImageTableViewCell.identifier)
        tableView.register(DetailInfoTableViewCell.nib(), forCellReuseIdentifier: DetailInfoTableViewCell.identifier)
        tableView.register(GenresInfoTableViewCell.nib(), forCellReuseIdentifier: GenresInfoTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func bind() {
        presenter.getDetails(id: self.id)
        presenter.gameDetails.subscribe(onNext: { [weak self] result in
            self?.gameDetail = result
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        presenter.buttonTap.subscribe(onNext: { [weak self] isLiked in
            print("tapped \(isLiked)")
            let favModel = FavoritesMapper.mapGamesResponseToEntities(input: self?.gameDetail)
            self?.presenter.addFavorite(favEntity: favModel)
        }).disposed(by: disposeBag)
        
        presenter.buttonStates.subscribe(onNext: { [weak self] isLiked in
            self?.isLiked = isLiked
        }).disposed(by: disposeBag)
        
        presenter.reloadData.subscribe(onNext: { [weak self] in
            self?.tableView.reloadData()
        })
    }
}

extension GameDetailViewController: UITableViewDelegate {
    // MARK: - Scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DetailImageTableViewCell {
            cell.scrollViewDidScroll(scrollView: scrollView)
//            adjustParallax(for: cell)
        }
    }
}

extension GameDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSection.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch DetailSection.getSection(section) {
        case .imageView:
            return 1
        case .gameDescription:
            return 1
        case .genreList:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch DetailSection.getSection(indexPath.section) {
        case .imageView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImageTableViewCell", for: indexPath) as? DetailImageTableViewCell else { return UITableViewCell() }
            
            cell.callBack = { [weak self] in
                if let navController = self?.navigationController {
                    navController.popViewController(animated: true)
                }
            }
            
            if presenter.loadingState {
                cell.imageDetail.showAnimatedGradientSkeleton()
            } else {
                cell.imageDetail.hideSkeleton()
                cell.setupImage(imageUrl: gameDetail?.backgroundImage)
            }
            
//            cell.setupImage(imageUrl: gameDetail?.backgroundImage)
            
            return cell
        case .gameDescription:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoTableViewCell", for: indexPath) as? DetailInfoTableViewCell else { return UITableViewCell() }
            
            if presenter.loadingState {
                cell.titleLabel.showAnimatedGradientSkeleton()
            } else {
                cell.titleLabel.hideSkeleton()
                cell.setupData(model: gameDetail)
                cell.setButtonUI(isLiked: isLiked)
                cell.setButtonState(subjectButton: presenter.buttonTap)
            }
            
            return cell
        case .genreList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenresInfoTableViewCell", for: indexPath) as? GenresInfoTableViewCell else { return UITableViewCell() }
            
            if presenter.loadingState {
                cell.titleLabel.text = ""
            } else {
                cell.setData(genres: gameDetail?.genres)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}
