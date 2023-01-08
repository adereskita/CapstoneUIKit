//
//  DynamicHeightCollectionView.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import UIKit

class DynamicCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
}
