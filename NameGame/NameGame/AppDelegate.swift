//
//  AppDelegate.swift
//  NameGame
//
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let rootViewController = GameModesViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        
        return true
    }
    
}
