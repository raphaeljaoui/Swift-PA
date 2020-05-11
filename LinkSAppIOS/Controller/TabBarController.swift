//
//  TabBarController.swift
//  LinkSAppIOS
//
//  Created by Imane on 30/04/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let services = ServicesController()
    let myServices = MyServicesController()
    let messages = MessagesController()
    let profil = ProfilController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        viewControllers = [create(title: "Services", image: "services", controller: services),
                                
                        create(title: "Mes Services", image: "myservices", controller: myServices),
                            
                        create(title: "Messages", image: "messages", controller: messages),
                                
                        create(title: "Profil", image: "profil", controller: profil)]
    }
    
    func create(title: String, image: String, controller: UIViewController) -> UINavigationController {
    
        let viewC = UINavigationController(rootViewController: controller)
        
        viewC.tabBarItem.title = title
        
        viewC.tabBarItem.image = UIImage(named: image)
        
        return viewC
    }
}
