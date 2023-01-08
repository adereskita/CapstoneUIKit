//
//  FavoriteTableViewCell.swift
//  Capstone
//
//  Created by Ade on 12/26/22.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favImage.layer.cornerRadius = 4
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: FavoriteModel?) {
        if let data = data {
            let url = URL(string: data.imageUrl ?? "")
            favImage.kf.setImage(with: url)
            titleLabel.text = data.title
            descLabel.text = data.desc?.htmlToString
        }
    }
}
