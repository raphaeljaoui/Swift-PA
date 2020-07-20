//
//  MessageWebService.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 18/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

class MessagesWebService {
    
    func getMessagesFor2Users(idSender: Int, idDest: Int, completion: @escaping ([Message]) -> Void ) -> Void {
           let url = Config.urlAPI + "/messages/\(idSender)&\(idDest)"

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
               let users = json.compactMap { (obj) -> Message? in
                    guard let dict = obj as? [String: Any] else {
                       return nil
                    }
                   
                    return MessageFactory.MessageFrom(dictionary: dict)
               }
               DispatchQueue.main.sync {
                   completion(users)
               }
               
              }
           task.resume()
    }
    
     func getUserConversationsBySender(idSender: Int, completion: @escaping ([User]) -> Void ) -> Void {
           let url = Config.urlAPI + "/conversations/expediteur/\(idSender)"

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
               let users = json.compactMap { (obj) -> User? in
                    guard let dict = obj as? [String: Any] else {
                       return nil
                    }
                   
                    return UserFactory.userFrom(dictionary: dict)
               }
               DispatchQueue.main.sync {
                   completion(users)
               }
               
              }
           task.resume()
    }
    
    func getUserConversationsByDest(idDest: Int, completion: @escaping ([User]) -> Void ) -> Void {
        let url = Config.urlAPI + "/conversations/destinataire/\(idDest)"
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
            let users = json.compactMap { (obj) -> User? in
                 guard let dict = obj as? [String: Any] else {
                    return nil
                 }
                 
                 return UserFactory.userFrom(dictionary: dict)
            }
            DispatchQueue.main.sync {
                completion(users)
            }
            
           }
        task.resume()
    }
    
    func sendMessage(message: Message, completion: @escaping (Bool) -> Void) -> Void {
        let url = Config.urlAPI + "/messages"
        guard let urlApi  = URL(string: url) else {
            return;
        }
        var request = URLRequest(url: urlApi)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: MessageFactory.dictionaryFrom(message: message), options: .fragmentsAllowed)
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
