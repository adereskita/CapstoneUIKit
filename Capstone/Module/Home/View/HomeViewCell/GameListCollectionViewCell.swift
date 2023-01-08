//
//  GameListCollectionViewCell.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import UIKit
import Kingfisher

class GameListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var gameImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
//    var delegate: GameListCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    private func setupView() {
        cardView.cardStyle()
        gameImageView.layer.cornerRadius = 10
        gameImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        gameImageView.layoutMargins = UIEdgeInsets(top: 20, left: -20, bottom: 20, right: 20)
    }

    func setData(data: Game?) {
        if let data = data {
            titleLabel.text = data.name
            gameImageView.image = UIImage(named: "controller")
            ratingLabel.text = ""
        }
    }
    
    func setSearchData(data: GameResult?) {
        if let data = data {
            self.titleLabel.text = data.name
            self.ratingLabel.text = "⭐️ " + String(format: "%.1f", data.rating!)
            let url = URL(string: data.backgroundImage ?? "")
            gameImageView?.kf.setImage(with: url)
        }
    }
}
