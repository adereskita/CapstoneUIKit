//
//  CellHelper.swift
//  Capstone
//
//  Created by Ade Reskita on 17/12/22.
//

import Foundation

enum HomeSection: CaseIterable {
    case header
    case searchBar
    case heroBanner
    case genreList
    case gameList
    
    static func numberOfSection() -> Int {
        return self.allCases.count
    }
    
    static func getSection(_ section: Int) -> HomeSection {
        return self.allCases[section]
    }
}

enum DetailSection: CaseIterable {
    case imageView
    case gameDescription
    case genreList
    
    static func numberOfSection() -> Int {
        return self.allCases.count
    }
    
    static func getSection(_ section: Int) -> DetailSection {
        return self.allCases[section]
    }
}
