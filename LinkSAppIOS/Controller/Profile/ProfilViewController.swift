//
//  ProfilViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 14/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit
import StoreKit

private let reuseIdentifier = "ProfilCell"

class ProfilViewController: UIViewController, UITabBarDelegate {
    
    var tableView: UITableView!
    var userConnected: User? = nil

    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var PointsUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .white
        configUI()
        setUserInfos()
        
        self.navigationItem.hidesBackButton = true
        tabBar.selectedItem = tabBar.items?[3]
        self.tabBar.delegate = self
        SKStoreReviewController.requestReview()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (tabBar.selectedItem == tabBar.items?[0]) {
            let ListService = ListServicesViewController()
            ListService.userConnected = self.userConnected
            navigationController?.pushViewController(ListService, animated: false)
        } else if (tabBar.selectedItem == tabBar.items?[1]) {
            let mesServices = MesServicesViewController()
            mesServices.userConnected = self.userConnected
            navigationController?.pushViewController(mesServices, animated: false)
        } else if (tabBar.selectedItem == tabBar.items?[2]) {
            let messages = ListConversationsViewController()
            messages.userConnected = self.userConnected
            navigationController?.pushViewController(messages, animated: true)
        }
    }
    
    func configUI() {
        navigationItem.title = "Profil"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .gray
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUserInfos(){
        nameUser.text = "\(userConnected!.name) \(userConnected!.surname) "
        
        guard let pointsAmount = userConnected?.points else {
            return
        }
        
        if(pointsAmount <= 1){
            PointsUser.text = "\(pointsAmount) Point"
        } else {
            PointsUser.text = "\(pointsAmount) Points"
        }
        
    }
    
    @IBAction func btnModifyInfos(_ sender: Any) {
        modifyUserPage()
    }
    @IBAction func btnDisconnection(_ sender: Any) {
        disconnectUser()
    }
    @IBAction func btnDeleteUser(_ sender: Any) {
        navDelete()
        
    }
    
    func disconnectUser(){
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userPwd")
        UserDefaults.standard.synchronize()
        
        let disconnection = HomeViewController()
        navigationController?.pushViewController(disconnection, animated: true)
    }
    
    func modifyUserPage(){
        let modify = ProfileFormViewController()
        modify.userConnected = userConnected
        self.navigationController?.pushViewController(modify, animated: true)
    }
    
    func navDelete(){
        self.navigationController?.pushViewController(DeleteController(), animated: true)
    }
    
}
