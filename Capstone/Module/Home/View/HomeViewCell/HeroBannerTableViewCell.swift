//
//  HeroBannerTableViewCell.swift
//  Capstone
//
//  Created by Ade Reskita on 17/12/22.
//

import UIKit

class HeroBannerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var heroLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        cardView.cardStyle()
        cardView.backgroundColor = hexStringToUIColor(hex: "FFE9C8")
        heroLabel.text = "Let's download a game to start"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
