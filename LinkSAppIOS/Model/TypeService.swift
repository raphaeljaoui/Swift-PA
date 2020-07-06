//
//  TypeService.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 05/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class TypeService: CustomStringConvertible {
    
    var id: Int
    var name: String
    var desc: String
    var picture: String
    var active: Int
    
    init(idType: Int, name: String, desc: String, pic: String, act: Int) {
        self.id = idType
        self.name = name
        self.desc = desc
        self.picture = pic
        self.active = act
    }
    
    
    
    var description: String{
        return "name"
    }
}
