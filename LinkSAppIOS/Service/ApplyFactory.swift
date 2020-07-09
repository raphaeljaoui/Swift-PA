//
//  ApplyFactory.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 09/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class ApplyFactory{
    
    //Function type to switch Service to dictionnary with right values
    static func ApplyFrom(dictionary: [String: Any]) -> Apply? {
        guard let id_service = dictionary["id_service"] as? Int else {
                return nil
        }
        let apply = Apply(id_service: id_service)
        apply.id_user = dictionary["id_user"] as? Int
        apply.execute = dictionary["execute"] as? Int
        apply.note = dictionary["note"] as? Int
        apply.commentaire = dictionary["commmentaire"] as? String
        
        return apply
    }
    
    static func dictionaryFrom(apply: Apply) -> [String: Any] {
        return [
            "id_service": apply.id_service,
            "id_user": apply.id_user,
            "execute": apply.execute,
            "note": apply.note,
            "commentaire": apply.commentaire
        ]
    }
}
