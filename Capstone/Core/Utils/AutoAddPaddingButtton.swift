//
//  AutoAddPaddingButtton.swift
//  Capstone
//
//  Created by Ade on 12/24/22.
//

import Foundation
import UIKit

class AutoAddPaddingButtton: UIButton {
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return CGSize(width: baseSize.width + 8,
                          height: baseSize.height + 8)
        }
    }
}

enum FavoriteButtonState {
    case Liked, Unlike
}
