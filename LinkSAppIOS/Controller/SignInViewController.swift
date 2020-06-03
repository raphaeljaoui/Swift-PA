//
//  SignInViewController.swift
//  LinkSAppIOS
//
//  Created by Apple on 19/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    let userWebService: UserWebService = UserWebService()
    
    @IBOutlet weak var mailFiels: UITextField!
    @IBOutlet weak var passwordFields: UITextField!
   
    @IBAction func loginButton(_ sender: Any) {
        guard let email = self.mailFiels.text,
            let password = self.passwordFields.text else {
                return
        }
        let login = Login(email: email, password: password)
        let userLogin = UserLogin(table: "user", values: login)
        self.userWebService.connexionUser(login: userLogin){ (success) in
            print(userLogin)
            print("\(success)")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mailFiels.delegate = self
        self.passwordFields.delegate = self
        // Do any additional setup after loading the view.
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
