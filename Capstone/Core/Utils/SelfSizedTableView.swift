//
//  SelfSizedTableView.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import UIKit

class SelfSizedTableView: UITableView {

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
