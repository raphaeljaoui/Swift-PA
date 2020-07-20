//
//  WinWebService.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 13/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class WinWebService {
    func getUserBadges(idUser: Int, completion: @escaping ([Win]) -> Void ) -> Void {
        let url = Config.urlAPI + "/badges/user/\(idUser)"
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
            let win = json.compactMap { (obj) -> Win? in
                guard let dict = obj as? [String: Any] else {
                    return nil
                }
                
                return WinFactory.WinFrom(dictionary: dict)
            }
            DispatchQueue.main.sync {
                completion(win)
            }
            
           }
        task.resume()
    }
    
    func setBadgeToUser(win: Win, completion: @escaping (Bool) -> Void) -> Void {
        let url = Config.urlAPI + "/win"
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: WinFactory.dictionaryFrom(win: win), options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let httpRes = res as? HTTPURLResponse {
                completion(httpRes.statusCode == 200)
            }
            completion(false)
            
           }
        task.resume()
    }
}
