//
//  GameListTableViewCell.swift
//  Capstone
//
//  Created by Ade Reskita on 17/12/22.
//

import UIKit

typealias DidSelectCollection = (Game) -> Void
typealias DidSelectCollectionSearch = (GameResult) -> Void

class GameListTableViewCell: UITableViewCell {
    
    @IBOutlet var gameCollectionView: DynamicCollectionView!
    @IBOutlet var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var genreLabel: UILabel!
    var gameList: [Game]? {
        didSet {
            gameCollectionView.reloadData()
        }
    }
    var searchList: [GameResult]? {
        didSet {
            gameCollectionView.reloadData()
        }
    }
    var callBack: DidSelectCollection?
    var callBackSearch: DidSelectCollectionSearch?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isMultipleTouchEnabled = true
        selectionStyle = .none
        setupCollection()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionViewHeightConstraint.constant = gameCollectionView.collectionViewLayout.collectionViewContentSize.height
        gameCollectionView.collectionViewLayout.invalidateLayout()
        gameCollectionView.layoutIfNeeded()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection != nil else { return }
        gameCollectionView?.collectionViewLayout.invalidateLayout()
    }
    
    private func setupCollection() {
        gameCollectionView.register(GameListCollectionViewCell.nib(), forCellWithReuseIdentifier: GameListCollectionViewCell.identifier)
        gameCollectionView.dataSource = self
        gameCollectionView.delegate = self
        self.layoutSubviews()
    }
    
    func setData(data: GenreResult?) {
        searchList = nil
        if let data = data {
            self.genreLabel.text = data.name
//            self.layoutSubviews()
            collectionViewHeightConstraint.constant = 160
            
            if let layout = gameCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                layout.collectionView?.isScrollEnabled = true
                layout.invalidateLayout()
            }
            self.layoutIfNeeded()
        }
        self.setNeedsLayout()
    }
    
    func setSearchData() {
        self.genreLabel.text = "Search result"
        gameList = nil
        if let layout = gameCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.collectionView?.isScrollEnabled = false
            layout.invalidateLayout()
        }
        self.layoutSubviews()
    }
}

extension GameListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList?.isEmpty ?? true ? gameList?.count ?? 0 : searchList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameListCollectionViewCell", for: indexPath) as? GameListCollectionViewCell else { return UICollectionViewCell() }

        if let gameSerch = searchList?[indexPath.row] {
            cell.setSearchData(data: gameSerch)
        } else {
            let gameObj = gameList?[indexPath.row]
            cell.setData(data: gameObj)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let gameList = gameList {
            let gameObj = gameList[indexPath.row]
            callBack!(gameObj)
        }
        if let searchGame = searchList {
            let gameObj = searchGame[indexPath.row]
            callBackSearch!(gameObj)
        }
    }
}

extension GameListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width / 2.5
        return CGSize(width: cellWidth, height: 160)
    }
}
