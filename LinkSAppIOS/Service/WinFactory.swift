//
//  WinFactory.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 13/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class WinFactory{
    
    static func WinFrom(dictionary: [String: Any]) -> Win? {
        guard let id_user = dictionary["id_user"] as? Int,
            let id_badge = dictionary["id_badge"] as? Int else {
                return nil
        }
        let win = Win(id_user: id_user, id_badge: id_badge)

        return win
    }
    
    static func dictionaryFrom(win: Win) -> [String: Any] {
        return [
            "id_user": win.id_user,
            "id_badge": win.id_badge,
        ]
    }
}
