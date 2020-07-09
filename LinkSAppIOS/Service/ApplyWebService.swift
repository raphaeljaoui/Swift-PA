//
//  ApplyWebService.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 09/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class ApplyWebService{
    
    func getExecutorOfAService(idService: Int, completion: @escaping ([Apply]) -> Void) -> Void {

        guard let urlApi  = URL(string: "http://localhost:4000/apply/executor/\(idService)") else {
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
            let apply = json.compactMap { (obj) -> Apply? in
                guard let dict = obj as? [String: Any] else {
                    return nil
                }
                
                return ApplyFactory.ApplyFrom(dictionary: dict)
            }
            DispatchQueue.main.sync {
                completion(apply)
            }
            
           }
        task.resume()
    }
    
    func setAppliance(apply: Apply, completion: @escaping (Bool) -> Void) -> Void {

        guard let urlApi  = URL(string: "http://localhost:4000/apply") else {
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
}
