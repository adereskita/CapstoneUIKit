//
//  GenresInfoTableViewCell.swift
//  Capstone
//
//  Created by Ade on 12/25/22.
//

import UIKit
import SkeletonView

class GenresInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: DynamicCollectionView!
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    var gameGenres: [Developer]?
    var isload = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCollection() {
        collectionView.register(DetailGenresCollectionViewCell.nib(), forCellWithReuseIdentifier: DetailGenresCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.setNeedsLayout()
    }
    
    func setData(genres: [Developer]?) {
        if let genres = genres {
            isload = false
            titleLabel.text = "Genres"
            gameGenres = genres
            collectionView.reloadData()
        }
    }
}

extension GenresInfoTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameGenres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gameObj = gameGenres?[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailGenresCollectionViewCell", for: indexPath) as? DetailGenresCollectionViewCell else { return UICollectionViewCell() }
        if isload {
            cell.genreImage.showAnimatedGradientSkeleton()
        } else {
            cell.genreImage.hideSkeleton()
            cell.setData(data: gameObj)
        }
        return cell
    }
}

extension GenresInfoTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width / 2
        let height = heightconstraint.constant
        return CGSize(width: cellWidth, height: height)
    }
}
