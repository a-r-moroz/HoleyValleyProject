//
//  File.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import Foundation
import RealmSwift

final class RealmManager {

    private static let realm = try! Realm()

    class func read<T: Object>(type: T.Type) -> [T] {
        return Array(realm.objects(type.self))
    }

    class func add<T: Object>(object: T) {
        try? realm.write({
            realm.add(object)
        })
    }

    class func remove<T: Object>(object: T) {
        try? realm.write({
            realm.delete(object)
        })
    }

    class func startTransaction() {
        realm.beginWrite()
    }

    class func closeTransaction() {
        try? realm.commitWrite()
    }
    
    static func deleteDecoration(object: FavoriteDecorationRealm) {
        let data = read(type: FavoriteDecorationRealm.self)
        guard let objectToDelete = data.filter({ $0.name == object.name }).first else { return }
        try? realm.write({
            realm.delete(objectToDelete)
        })
    }
}

/*
 static func delegate(object: SavedCoordinates) {
     let data = read()
     guard let objectToDelete = data.filter({ $0.latitude == object.latitude && $0.longitude == object.longitude }).first else { return }
     
     try? realm.write({
         realm.delete(objectToDelete)
     })
 }
 */

/*
 
 class func remove<T: Object>(object: T) {
     try? realm.write({
         realm.delete(object)
     })
 }
 */
