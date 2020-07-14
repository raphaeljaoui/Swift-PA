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
        UserDefaults.standard.setValue(false, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        if(UserDefaults.standard.string(forKey: "userEmail") != nil){
            let UserWS: UserWebService = UserWebService()
            UserWS.connexionUser(email: UserDefaults.standard.string(forKey: "userEmail")!, password: UserDefaults.standard.string(forKey: "userPwd")!){ (user) in
                if(user.count > 0){
                    let userConnected = user[0]
                    
                    let ListService = ListServicesViewController()
                    ListService.userConnected = userConnected
                    window.rootViewController = UINavigationController(rootViewController: ListService)
                } else {
                    let slideUnViewController = HomeViewController()
                    window.rootViewController =  UINavigationController(rootViewController: slideUnViewController)
                }
                window.makeKeyAndVisible()
                self.window = window
            }
            return true
        } else {
            let slideUnViewController = HomeViewController()
            window.rootViewController =  UINavigationController(rootViewController: slideUnViewController)
        }
        
        window.makeKeyAndVisible()
        self.window = window
               
        return true
    }
}

