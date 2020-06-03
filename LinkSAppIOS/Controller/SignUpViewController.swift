//
//  SignUpViewController.swift
//  LinkSAppIOS
//
//  Created by Apple on 22/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    let userWebService: UserWebService = UserWebService()

    @IBAction func inscription(_ sender: Any) {
        let user = User(id_user: 1, name: "jaoui", surname: "Raphael", email: "r.jaoui@gmail.com", password: "password", birthdate: "1998/01/10", picture: "image", points: 10, gender: 1, adresse: "10 rue de test", city: "paris", postcode: 75001, category: "course", type: "admin")
        
        let userSignUp = UserSignUp(table: "user", values: user)
        
        self.userWebService.logUser(signUp: userSignUp){(success) in
            print(userSignUp)
            print(success)
        }
        let signIn:SignInViewController = SignInViewController()
        self.present(signIn, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
