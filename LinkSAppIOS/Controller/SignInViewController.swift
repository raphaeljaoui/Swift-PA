//
//  SignInViewController.swift
//  LinkSAppIOS
//
//  Created by Apple on 19/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit
import CryptoKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    let userWebService: UserWebService = UserWebService()
    
    
    @IBOutlet weak var mailFiels: UITextField!
    @IBOutlet weak var passwordFields: UITextField!
   
    @IBAction func loginButton(_ sender: Any) {
        connexionRequest()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mailFiels.delegate = self
        self.passwordFields.delegate = self
        // Do any additional setup after loading the view.
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
                    print(user[0])
                    userConnected = user[0]
                    
                    let eventVC = ListServicesViewController()
                    eventVC.userConnected = userConnected
                    self.navigationController?.pushViewController(eventVC, animated: true)
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
        let hashed = SHA256.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        return hashString
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
