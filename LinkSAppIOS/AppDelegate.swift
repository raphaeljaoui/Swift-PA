//
//  AppDelegate.swift
//  LinkSAppIOS
//
//  Created by Imane on 30/04/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let slideUnViewController = SlideUnViewController()
        window.rootViewController =  UINavigationController(rootViewController: slideUnViewController)
        
        window.makeKeyAndVisible()
        self.window = window
               
        return true
    }
}

