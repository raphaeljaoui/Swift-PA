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
        
        navigationItem.title = "\(dest!.name) \(dest!.surname)"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.MessagesTableView.register(UINib(nibName: "InMessageTableViewCell", bundle: nil), forCellReuseIdentifier: inCellId)
        self.MessagesTableView.register(UINib(nibName: "OutMessageTableViewCell", bundle: nil), forCellReuseIdentifier: OutCellId)
        
        self.hideKeyboardWhenTappedAround()
        self.MessagesTableView.delegate = self
        self.MessagesTableView.dataSource = self
        MessagesTableView.separatorStyle = .none
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
            
            var checkCallback = false
            MessageWS.sendMessage(message: newMessage){ (res) in
                if(res || checkCallback) {
                    checkCallback = false
                    self.messagesList?.append(newMessage)
                    DispatchQueue.main.sync {
                        self.messageText.text = ""
                        self.MessagesTableView.insertRows(at: [IndexPath(row: self.messagesList!.count-1, section: 0)], with: .left)
                        self.MessagesTableView.reloadData()
                    }
                }
            }            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let messages = messagesList else { return 0}
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let message = messagesList?[indexPath.item] else {
            let cell = tableView.dequeueReusableCell(withIdentifier: inCellId, for: indexPath) as! InMessageTableViewCell
            cell.message.text = "Pas de message"
            return cell
        }
        
        if(message.id_dest == userConnected?.id){
            let cell = tableView.dequeueReusableCell(withIdentifier: inCellId, for: indexPath) as! InMessageTableViewCell
            cell.message.text = "\(message.content)"
            cell.date.text = "\(message.date.prefix(10))"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: OutCellId, for: indexPath) as! OutMessageTableViewCell

        cell.message.text = "\(message.content)"
        cell.date.text = "\(message.date.prefix(10))"
        return cell
    }

}
