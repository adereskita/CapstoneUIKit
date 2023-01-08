//
//  DetailGenresCollectionViewCell.swift
//  Capstone
//
//  Created by Ade on 12/25/22.
//

import UIKit

class DetailGenresCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genreImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    private func setupView() {
        cardView.cardStyle()
        genreImage.layer.cornerRadius = 10
        
        stackView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        stackView.layer.cornerRadius = 10
        stackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: -20, bottom: 20, right: 20)
    }
    
    func setData(data: Developer?) {
        if let data = data {
            genreLabel.text = data.name
            let url = URL(string: data.imageBackground ?? "")
            genreImage.kf.setImage(with: url)
        }
    }

}
