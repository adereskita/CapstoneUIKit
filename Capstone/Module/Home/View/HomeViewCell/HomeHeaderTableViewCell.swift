//
//  HomeHeaderTableViewCell.swift
//  Capstone
//
//  Created by Ade Reskita on 17/12/22.
//

import UIKit

typealias DidTapImageHeader = (Bool) -> Void

class HomeHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    var callBack: DidTapImageHeader?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageHeader.isUserInteractionEnabled = true
        imageHeader.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped() {
        callBack?(true)
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        callBack?(false)
    }
}
