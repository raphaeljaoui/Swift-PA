//
//  ApplyWebService.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 09/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class ApplyWebService{
    
    func getExecutorOfAService(idService: Int, completion: @escaping ([User]) -> Void) -> Void {
        let url = Config.urlAPI + "/service/executor/\(idService)"
        print(url)
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
            let apply = json.compactMap { (obj) -> User? in
                guard let dict = obj as? [String: Any] else {
                    return nil
                }
                
                return UserFactory.userFrom(dictionary: dict)
            }
            DispatchQueue.main.sync {
                completion(apply)
            }
            
           }
        task.resume()
    }
    
    func setAppliance(apply: Apply, completion: @escaping (Bool) -> Void) -> Void {
        let url = Config.urlAPI + "/apply"
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ApplyFactory.dictionaryFrom(apply: apply), options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let httpRes = res as? HTTPURLResponse {
                completion(httpRes.statusCode == 200)
            }
            completion(false)
            
           }
        task.resume()
    }
    
    func getAppliances(idService: Int, completion: @escaping ([User]) -> Void) -> Void {
        let url = Config.urlAPI + "/apply/service/\(idService)"
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
            let apply = json.compactMap { (obj) -> User? in
                guard let dict = obj as? [String: Any] else {
                    return nil
                }
                
                return UserFactory.userFrom(dictionary: dict)
            }
            DispatchQueue.main.sync {
                completion(apply)
            }
            
           }
        task.resume()
    }
    
    func updateAppliance(apply: Apply, completion: @escaping (Bool) -> Void) -> Void {
        let url = Config.urlAPI + "/apply"
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "PATCH"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ApplyFactory.dictionaryFrom(apply: apply), options: .fragmentsAllowed)
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
