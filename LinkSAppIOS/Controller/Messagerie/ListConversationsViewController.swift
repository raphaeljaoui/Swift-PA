//
//  ListConversationsViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 18/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class ListConversationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    let MessageWS: MessagesWebService = MessagesWebService()
    let UserWS: UserWebService = UserWebService()
    
    var userConnected: User? = nil
    
    var conversationUser: [User] = []
    
    let albumsCellId = "albumsCellId"

    @IBOutlet weak var tabBar: UITabBar!
    let listConversations : UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let idUser = userConnected?.id else { return }
        
        //Faire les 2 calls API
        self.MessageWS.getUserConversationsByDest(idDest: idUser){ (sender) in
            if(sender.count > 0){
                self.conversationUser = sender
            }
            self.MessageWS.getUserConversationsBySender(idSender: idUser) { (dest) in
                if(dest.count > 0){
                    if(self.conversationUser.count > 0){
                        for counter in 0..<dest.count {
                            if(!self.existInConversation(userId: dest[counter].id!,conversationList: self.conversationUser)){
                                self.conversationUser.append(dest[counter])
                            }
                        }
                    } else {
                        self.conversationUser = dest
                    }
                }
                self.setupView()
                self.configUI()
            }
        }
        
        self.navigationItem.hidesBackButton = true
        tabBar.selectedItem = tabBar.items?[2]
        self.tabBar.delegate = self
    }
    
    func configUI() {
        navigationItem.title = "Mes conversations"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
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
        } else if (tabBar.selectedItem == tabBar.items?[3]) {
            let profil = ProfilViewController()
            profil.userConnected = userConnected
            navigationController?.pushViewController(profil, animated: false)
        }
    }
    
    func setupView(){
        self.listConversations.delegate = self
        self.listConversations.dataSource = self
        
        listConversations.register(UINib(nibName: "ConversationsTableViewCell", bundle: nil), forCellReuseIdentifier: self.albumsCellId)
        
        view.addSubview(listConversations)
        listConversations.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: tabBar.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func existInConversation(userId : Int, conversationList: [User]) -> Bool {
        for counter in 0..<conversationList.count {
            if(userId == conversationList[counter].id!){
                return true
            }
        }
        return false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversationUser.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: albumsCellId, for: indexPath) as! ConversationsTableViewCell

        let user = self.conversationUser[indexPath.item]
        cell.nameUser.text = "\(user.name) \(user.surname)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let idUserConnected = userConnected?.id else { return }
        let user = self.conversationUser[indexPath.item]
        MessageWS.getMessagesFor2Users(idSender: idUserConnected, idDest: user.id!){ (messages) in
            
            print(messages)
            
            if(messages.count > 0){
                let messageController = MessagesViewController()
                messageController.userConnected = self.userConnected
                messageController.dest = self.conversationUser[indexPath.item]
                messageController.messagesList = messages
                self.navigationController?.pushViewController(messageController, animated:true)
            }
            
        }
        
    }

}
