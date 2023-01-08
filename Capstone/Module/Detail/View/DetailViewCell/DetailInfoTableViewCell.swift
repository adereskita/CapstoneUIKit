//
//  DetailInfoTableViewCell.swift
//  Capstone
//
//  Created by Ade on 12/24/22.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView

typealias DidAddFavorite = (FavoriteButtonState) -> Void

class DetailInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    var addFavorite: DidAddFavorite?
    var isLiked = false
    var latestState: FavoriteButtonState = .Unlike {
        didSet {
            latestState = isLiked ? .Liked : .Unlike
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setButtonUI(isLiked: Bool) {
        switch isLiked {
        case true:
            self.favoriteButton.isUserInteractionEnabled = false
            self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.favoriteButton.tintColor = .systemPink
        case false:
            self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.favoriteButton.tintColor = .systemGray
        }
    }
    
    func setButtonState(subjectButton: PublishSubject<FavoriteButtonState>) {
        favoriteButton.rx.tap
            .scan(latestState) { [unowned self] lastState, _ in
                switch lastState {
                case .Liked:
                    self.setButtonUI(isLiked: false)
                    return .Unlike
                case .Unlike:
                    self.setButtonUI(isLiked: true)
                    return .Liked
                }
            }
            .bind(to: subjectButton)
            .disposed(by: disposeBag)
    }
    
    func setupData(model: GameDetail?) {
        guard let model = model else { return }
        titleLabel.text = model.nameOriginal
        descLabel.text = model.gameDetailDescription?.htmlToString
    }
}
