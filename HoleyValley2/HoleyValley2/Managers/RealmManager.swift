//
//  File.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import Foundation
import RealmSwift

final class RealmManager {

//    let fileManager = FileManager.default
//    var config = RealmSwift.Realm.Configuration()

//    let urls = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)
//
//    lazy var applicationSupportURL = urls.last {
//        do {
//            try fileManager.createDirectory(at: applicationSupportURL, withIntermediateDirectories: true, attributes: nil)
//            config.fileURL = applicationSupportURL.appendingPathComponent("demo.realm")
//        } catch let err {
//            print(err)
//
//        }
//    }
//
//    // Set this as the configuration used for the default Realm
//    Realm.Configuration.defaultConfiguration = config
//
//    print (Realm.Configuration.defaultConfiguration.fileURL!)


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
}
