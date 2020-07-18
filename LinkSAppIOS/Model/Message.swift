//
//  Message.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 18/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class Message: CustomStringConvertible {
    var id: Int
    var content: String
    var date: String
    var id_sender: Int
    var id_dest: Int
    
    init(id: Int, content: String, date: String, id_sender: Int, id_dest: Int){
        self.id = id
        self.content = content
        self.date = date
        self.id_sender = id_sender
        self.id_dest = id_dest
    }
    
    var description: String {
        return "\(self.content)"
    }
    
}
