//
//  SignInViewController.swift
//  LinkSAppIOS
//
//  Created by Apple on 19/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit
import CommonCrypto

class SignInViewController: UIViewController, UITextFieldDelegate {

    let userWebService: UserWebService = UserWebService()
    
    
    @IBOutlet weak var mailFiels: UITextField!
    @IBOutlet weak var passwordFields: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButton(_ sender: Any) {
        connexionRequest()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mailFiels.delegate = self
        self.passwordFields.delegate = self
        loginButton.layer.cornerRadius = loginButton.bounds.size.height/2
        
    }
    
    func connexionRequest(){
        guard let email = self.mailFiels.text,
            let password = self.passwordFields.text else {
                return
        }

        if (email == "" ||  password == "") {
            let alertController = UIAlertController(title: "Erreur de connexion", message: "Merci de renseigner tous les champs manquants.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Valider", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        
        if (!email.contains("@") || !email.contains(".")) { // Vérification de l'adresse mail
            let alertController = UIAlertController(title: "Erreur de connexion", message: "Merci d'indiquer une adresse mail valide.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Valider", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        
        let pwd = hashPassword(data: password)
        
        var userConnected: User!
        
        DispatchQueue.main.async {
            self.userWebService.connexionUser(email: email, password: pwd){ (user) in
                if(user.count > 0){
                    userConnected = user[0]
                    
                    UserDefaults.standard.set(userConnected.email,forKey: "userEmail")
                    UserDefaults.standard.set(pwd,forKey: "userPwd")
                    UserDefaults.standard.synchronize()
                    
                    let ListService = ListServicesViewController()
                    ListService.userConnected = userConnected
                    self.navigationController?.pushViewController(ListService, animated: true)
                } else {
                    let alert = UIAlertController(title: "Erreur", message: "Mot de passe ou email invalide", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
        
    }

    func hashPassword(data : String) -> String {
        let inputData = Data(data.utf8)
        let hashed = sha256(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        return hashString
    }

    func sha256(data : Data) -> Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return Data(hash)
    }

}
