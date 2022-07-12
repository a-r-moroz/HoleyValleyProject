//
//  AppDelegate.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit
import Firebase
import RealmSwift
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 0, blue: 108/255, alpha: 1)
        UITabBar.appearance().tintColor = UIColor(red: 140/255, green: 102/255, blue: 53/255, alpha: 1)
//        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0, green: 252/255, blue: 255/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = .systemGray2

//        UITabBar.appearance().barTintColor = .blue
        
//        UITabBar.appearance().backgroundColor = .black
        
        FirebaseApp.configure()
        
        GMSServices.provideAPIKey("AIzaSyAS6qgX2yi3HcDVg_Um0ScpBP4wkp3R5pM")
        
        var config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
        })
        config.deleteRealmIfMigrationNeeded = true

        Realm.Configuration.defaultConfiguration = config

        _ = try! Realm()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
//    func openRealm() {
//
//        let defaultRealmPath = Realm.defaultPath
//        let bundleReamPath = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent("default.realm")
//
//        if !NSFileManager.defaultManager().fileExistsAtPath(defaultRealmPath) {
//            NSFileManager.defaultManager().copyItemAtPath(bundleReamPath!, toPath: defaultRealmPath, error: nil)
//        }
//    }


}

