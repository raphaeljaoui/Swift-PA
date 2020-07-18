//
//  BadgeWebService.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 12/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class BadgeWebService {
    
    func getBadges(id_type_service: Int, completion: @escaping ([Badge]) -> Void) -> Void {
        let url = Config.urlAPI + "/badge/\(id_type_service)"
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
        guard let bytes = data,
                     err == nil,
            let json = try? JSONSerialization.jsonObject(with: bytes, options: .allowFragments) as? [Any] else {
                       DispatchQueue.main.sync {
                           completion([])
                       }
                   return
               }
            let apply = json.compactMap { (obj) -> Badge? in
                guard let dict = obj as? [String: Any] else {
                    return nil
                }
                
                return BadgeFactory.BadgeFrom(dictionary: dict)
            }
            DispatchQueue.main.sync {
                completion(apply)
            }
            
           }
        task.resume()
    }
    

    
    
}
