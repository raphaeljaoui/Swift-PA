//
//  SignUpViewController.swift
//  LinkSAppIOS
//
//  Created by Apple on 22/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit
import CommonCrypto

class SignUpViewController: UIViewController {

    let UserWS: UserWebService = UserWebService()

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var SurnameTF: UITextField!
    @IBOutlet weak var birthdateTF: UITextField!
    @IBOutlet weak var adressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var CPTF: UITextField!
    @IBOutlet weak var pwd1TF: UITextField!
    @IBOutlet weak var pwd2TF: UITextField!
    @IBOutlet weak var connexion: UIButton!
    @IBOutlet weak var inscription: UIButton!
    
    var birthdatePicker: UIDatePicker?
    var selectedBirthDate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inscription.layer.cornerRadius = inscription.bounds.size.height/2
        connexion.layer.cornerRadius = connexion.bounds.size.height/2
        
        self.hideKeyboardWhenTappedAround()
        setupPicker()
    }

    @IBAction func inscription(_ sender: Any) {
        if(emailTF.text != "" && nameTF.text != "" && SurnameTF.text != "" && adressTF.text != "" && cityTF.text != "" && CPTF.text != "" && pwd1TF.text != "" && pwd2TF.text != ""){
            guard let email = emailTF.text,
                let name = nameTF.text,
                let surname = SurnameTF.text,
                let birthdate = selectedBirthDate,
                let adress = adressTF.text,
                let city = cityTF.text,
                let postcode = CPTF.text,
                let pwd1 = pwd1TF.text,
                let pwd2 = pwd2TF.text else { return }
            
            if(postcode.isInt == false){
                sendError(message: "Le code postal est incorrect")
            } else if(!pwd1.contains(pwd2)){
                sendError(message: "Les mots de passe ne correspondent pas")
            } else if (email.contains("@") && email.contains(".")) { // Vérification de l'adresse mail
                UserWS.getUserByEmail(emailUser: email){ (user) in
                    if(user.count == 0){
                        let userToRegister = User(id_user: 0, name: name, surname: surname, email: email, birthdate: birthdate, points: 10, type: "member")
                        userToRegister.adress = adress
                        userToRegister.city = city
                        userToRegister.postcode = Int(postcode)
                        userToRegister.adress = adress
                        userToRegister.password = self.hashPassword(data: pwd1)
                        userToRegister.active = 1
                            
                        self.registerUser(user: userToRegister)
                    } else {
                        self.sendError(message: "Cet adresse mail est déjà utilisée")
                    }
                }
            } else {
                sendError(message: "Entrez une adresse mail valide")
            }
        } else {
            sendError(message: "Remplissez les champs manquants")
        }
    }
    
    @IBAction func btnConnection(_ sender: Any) {
        let connection = SignInViewController()
        self.navigationController?.pushViewController(connection, animated:true)
    }
    
    func registerUser(user: User){
        UserWS.setUser(user: user){ (res) in
            DispatchQueue.main.sync {
                if(res == true){
                    let connection = SignInViewController()
                    self.navigationController?.pushViewController(connection, animated:true)
                }
            }
        }
    }
    
    func setupPicker(){
        //BirthDate picker
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.birthdatePicker = UIDatePicker()
        birthdatePicker?.locale = Locale(identifier: "fr")
        birthdatePicker?.datePickerMode = .date
        birthdatePicker?.addTarget(self, action: #selector(dateServiceChange(birthdatePicker:)), for: .valueChanged)
        
        self.birthdateTF.inputView = birthdatePicker
    }
    
    @objc func dateServiceChange(birthdatePicker : UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.birthdateTF.text = formatter.string(from: birthdatePicker.date)
        formatter.dateFormat = "yyyy-MM-dd"
        self.selectedBirthDate = formatter.string(from: birthdatePicker.date)
    }
    
    func sendError(message: String){
        let alertController = UIAlertController(title: "Erreur d'inscription", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Valider", style: .default))
        self.present(alertController, animated: true, completion: nil)
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
