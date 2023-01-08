//
//  LocalDataSource.swift
//  Capstone
//
//  Created by Ade on 12/25/22.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalDataSourceProtocol {
    func getFavorites() -> Observable<[FavoriteEntity]>
    func addFavorites(from categories: FavoriteEntity) -> Observable<Bool>
    func removeFavorites(id: String) -> Observable<Bool>
}

final class LocalDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
        
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }
    
}

extension LocalDataSource: LocalDataSourceProtocol {
    
    func getFavorites() -> Observable<[FavoriteEntity]> {
        return Observable<[FavoriteEntity]>.create { observer in
            if let realm = self.realm {
                let favorites: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(favorites.toArray(ofType: FavoriteEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addFavorites(from favorites: FavoriteEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(favorites, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
                
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
        
    }
    
    func removeFavorites(id: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    let object = realm.objects(FavoriteEntity.self).filter("id = %@", id).first
                    try realm.write {
                        if let obj = object {
                            realm.delete(obj)
                            observer.onNext(true)
                            observer.onCompleted()
                        }
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
