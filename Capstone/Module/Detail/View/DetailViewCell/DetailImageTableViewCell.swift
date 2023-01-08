//
//  DetailImageTableViewCell.swift
//  Capstone
//
//  Created by Ade on 12/24/22.
//

import UIKit
import Kingfisher

typealias DidTapBack = () -> Void

class DetailImageTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backButton: AutoAddPaddingButtton!
    @IBOutlet weak var headerBackground: UIView!
    @IBOutlet weak var headerLine: UIView!
    
    var callBack: DidTapBack?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backButton.layer.cornerRadius = 12
        headerLine.layer.cornerRadius = 2.5
        headerBackground.layer.cornerRadius = 16
        headerBackground.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupImage(imageUrl: String?) {
        if let imageUrl = imageUrl {
            let url = URL(string: imageUrl)
            imageDetail.kf.setImage(with: url)
        }
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        callBack?()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
//        bottomSpaceConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        containerHeight.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if scrollView.contentOffset.y >= 0 {
//            // scrolling down
//            containerView.clipsToBounds = true
//            bottomSpaceConstraint?.constant = -scrollView.contentOffset.y / 2
//            topSpaceConstraint?.constant = scrollView.contentOffset.y / 2
//        } else {
//            // scrolling up
//            topSpaceConstraint?.constant = scrollView.contentOffset.y
//            containerView.clipsToBounds = false
//        }
//    }
}
