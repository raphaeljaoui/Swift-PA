//
//  MessageFactory.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 18/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class MessageFactory{
    static func MessageFrom(dictionary: [String: Any]) -> Message? {
        guard let id = dictionary["id"] as? Int,
            let id_sender = dictionary["id_sender"] as? Int,
            let id_dest = dictionary["id_dest"] as? Int,
            let content = dictionary["content"] as? String,
            let date = dictionary["date"] as? String else {
                return nil
        }
        let message = Message(id: id, content: content, date: date, id_sender: id_sender, id_dest: id_dest)

        return message
    }
    
    static func dictionaryFrom(message: Message) -> [String: Any] {
        return [
            "id_sender": message.id_sender,
            "id_dest": message.id_dest,
            "content": message.content,
            "date": message.date,
        ]
    }
}
