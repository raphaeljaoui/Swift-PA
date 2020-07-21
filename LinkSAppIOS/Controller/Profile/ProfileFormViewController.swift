//
//  ProfileFormViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 15/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class ProfileFormViewController: UIViewController {
    
    let UserWS: UserWebService = UserWebService()
    
    var userConnected: User? = nil

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var BirthdateTF: UITextField!
    @IBOutlet weak var AdressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var PCTF: UITextField!
    @IBOutlet weak var btnModifyUserInfos: UIButton!
    
    var birthdatePicker: UIDatePicker?
    var selectedBirthDate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
        self.hideKeyboardWhenTappedAround()
        setupPicker()
        setupPlaceholders()
    }

    @IBAction func btnModifyUserInfos(_ sender: Any) {
        if(nameTF.text != ""){
            guard let name = nameTF.text else {return}
            userConnected?.name = name
        }
        
        if(surnameTF.text != ""){
            guard let surname = surnameTF.text else {return}
            userConnected?.surname = surname
        }
        
        if(BirthdateTF.text != ""){
            userConnected?.birthdate = selectedBirthDate
        }
        
        if(AdressTF.text != ""){
            guard let adress = AdressTF.text else {return}
            userConnected?.adress = adress
        }
        
        if(cityTF.text != ""){
            guard let city = cityTF.text else {return}
            userConnected?.city = city
        }
        
        if(PCTF.text != ""){
            guard let postcode = PCTF.text else {return}
            if(postcode != "" && postcode.isInt == false){
                sendError(message: "Le code postal est incorrect")
            } else {
                userConnected?.postcode = Int(postcode)
            }
        }
        self.updateUser()
    }

    func configUI(){
        navigationItem.title = "Modifier les infos de mon profil : "
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .gray
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupPlaceholders(){
        nameTF.placeholder = userConnected?.name
        surnameTF.placeholder = userConnected?.surname
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birthdate = formatter.date(from: userConnected!.birthdate)
        formatter.dateFormat = "dd/MM/yyyy"
        BirthdateTF.placeholder = formatter.string(from: birthdate!)

        
        guard let adress = userConnected?.adress else {return}
        AdressTF.placeholder = adress
        
        guard let city = userConnected?.city else {return}
        cityTF.placeholder = city
        
        guard let postcode = userConnected?.postcode else {return}
        PCTF.placeholder = String(postcode)
    }
    
    func setupPicker(){
        //BirthDate picker
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.birthdatePicker = UIDatePicker()
        birthdatePicker?.locale = Locale(identifier: "fr")
        birthdatePicker?.datePickerMode = .date
        birthdatePicker?.addTarget(self, action: #selector(dateServiceChange(birthdatePicker:)), for: .valueChanged)
        
        self.BirthdateTF.inputView = birthdatePicker
    }
    
    @objc func dateServiceChange(birthdatePicker : UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.BirthdateTF.text = formatter.string(from: birthdatePicker.date)
        formatter.dateFormat = "yyyy-MM-dd"
        self.selectedBirthDate = formatter.string(from: birthdatePicker.date)
    }
    
    func updateUser(){
        UserWS.updateUser(user: userConnected!){ (res) in
            DispatchQueue.main.sync {
                if(res == true){
                    let connection = ProfilViewController()
                    connection.userConnected = self.userConnected
                    self.navigationController?.pushViewController(connection, animated:true)
                }
            }
        }
    }

    func sendError(message: String){
        let alertController = UIAlertController(title: "Erreur d'inscription", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Valider", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }

}
