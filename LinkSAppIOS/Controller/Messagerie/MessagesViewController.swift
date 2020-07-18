//
//  MessagesViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 18/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let MessageWS: MessagesWebService = MessagesWebService()
    
    var userConnected: User? = nil
    var dest: User? = nil
    var messagesList: [Message]? = nil
    
    let inCellId = "inCellId"
    let OutCellId = "OutCellId"
    
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var MessagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(messagesList)
        
        self.MessagesTableView.register(UINib(nibName: "InMessageTableViewCell", bundle: nil), forCellReuseIdentifier: inCellId)
        self.MessagesTableView.register(UINib(nibName: "OutMessageTableViewCell", bundle: nil), forCellReuseIdentifier: OutCellId)
        
        
        self.MessagesTableView.delegate = self
        self.MessagesTableView.dataSource = self
        
    }

    @IBAction func btnSendMessage(_ sender: Any) {
        if(messageText.text != ""){
            guard let idSender = userConnected?.id,
                let idDest = dest?.id else {
                    return
            }
            let now = Date()
            let format        = DateFormatter()
            format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let dateFormated = format.string(from: now)
            let newMessage = Message(id: 0, content: messageText.text!, date: dateFormated, id_sender: idSender, id_dest: idDest)
            
            MessageWS.sendMessage(message: newMessage){ (res) in
            }            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let messages = messagesList else { return 0}
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let message = messagesList?[indexPath.item] else {
            let cell = tableView.dequeueReusableCell(withIdentifier: inCellId, for: indexPath) as! InMessageTableViewCell

            cell.message.text = "Pas de message"
            return cell
            
        }
        
        print(message.id_dest)
        print(userConnected?.id)
        
        if(message.id_dest == userConnected?.id){
            let cell = tableView.dequeueReusableCell(withIdentifier: inCellId, for: indexPath) as! InMessageTableViewCell

            cell.message.text = "\(message.content)"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: OutCellId, for: indexPath) as! OutMessageTableViewCell

        cell.message.text = "\(message.content)"

        return cell
    }

}
