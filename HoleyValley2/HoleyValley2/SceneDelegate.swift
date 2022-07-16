//
//  SceneDelegate.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var overlayWIndow: UIWindow?
    var scene: UIWindowScene?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        self.window?.rootViewController = SplashViewController(nibName: String(describing: SplashViewController.self), bundle: nil)
        self.window?.makeKeyAndVisible()
//        self.window?.isHidden = false
        splashController()
//        NotificationManager.requestDefaultAutorization()
//        self.scene = windowScene
    }
    
    private func createOverlayWindow() {
        
        guard let scene = scene else { return }

        overlayWIndow = UIWindow(windowScene: scene)
        overlayWIndow?.windowScene = scene
        overlayWIndow?.rootViewController = OverlayViewController(nibName: String(describing: OverlayViewController.self), bundle: nil)
        overlayWIndow?.makeKeyAndVisible()
    }
    
    private func clearOverlayWindow() {
        
        overlayWIndow = nil
        window?.makeKeyAndVisible()
    }
    
    func splashController() {

        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fireTimer(sender:)), userInfo: nil, repeats: false)
    }
    
    @objc func fireTimer(sender: Timer) {
        
        self.window?.rootViewController = BarController()
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//        clearOverlayWindow()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
//        createOverlayWindow()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}


/*
 
 pod 'Firebase/Analytics'
 pod 'Firebase/Core'
 pod 'Firebase/Database'
 pod 'Firebase/Firestore'
 pod 'Firebase/Storage'
 pod 'IQKeyboardManager'
 pod 'FSCalendar'
 pod 'SDWebImage', '~> 5.0'
 pod 'Haptica'
 pod 'RealmSwift'
 
 */
