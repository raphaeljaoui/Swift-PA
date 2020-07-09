//
//  Apply.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 09/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class Apply: CustomStringConvertible{
    
    var id_service : Int
    var id_user : Int?
    var execute : Int?
    var note : Int?
    var commentaire : String?
    
    init(id_service: Int) {
        self.id_service = id_service
    }
    
    
    var description: String{
        return "name"
    }
}
