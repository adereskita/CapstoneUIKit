//
//  FavoriteEntity.swift
//  Capstone
//
//  Created by Ade on 12/25/22.
//

import Foundation
import RealmSwift

class FavoriteEntity: Object {

  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var imageUrl: String = ""
  @objc dynamic var desc: String = ""

  override static func primaryKey() -> String? {
    return "id"
  }
}

struct FavoriteModel {
    var id: String?
    var title: String?
    var imageUrl: String?
    var desc: String?
}
