//
//  SearchBarTableViewCell.swift
//  Capstone
//
//  Created by Ade Reskita on 17/12/22.
//

import UIKit
import RxSwift
import RxCocoa

typealias GetTextSearchBar = (String) -> Void

class SearchBarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var getTextSearchBar: GetTextSearchBar?
    
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        bindSearchBar()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindSearchBar() {
        searchBar.rx.text
                    .orEmpty
                    .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
                    .distinctUntilChanged()
                    .subscribe { [unowned self] (query) in
                        getTextSearchBar?(query)
                    }.disposed(by: disposeBag)
    }
    
}
