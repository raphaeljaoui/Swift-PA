//
//  TypeServiceFactory.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 05/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class TypeServiceFactory{
    
    //Function type to switch Service to dictionnary with right values
    static func TypeServiceFrom(dictionary: [String: Any]) -> TypeService? {
        guard let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let description = dictionary["description"] as? String,
            let picture = dictionary["picture"] as? String,
            let active = dictionary["active"] as? Int else {
                return nil
        }
        let type = TypeService(idType: id, name: name, desc: description, pic: picture, act: active)
        
        return type
    }
    
    static func dictionaryFrom(type: TypeService) -> [String: Any] {
        return [
            "name": type.name,
            "description": type.desc,
            "picture": type.picture,
            "active": type.active,
        ]
    }
}
