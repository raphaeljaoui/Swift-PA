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
        let user = User(id_user: 1, name: "jaoui", surname: "Raphael", email: "r.jaoui@gmail.com", birthdate: "1998/01/10", points: 10, type: "admin")
        
        user.picture = "image"
        user.gender = 1
        user.adress = "10 rue de test"
        user.city = "paris"
        user.postcode = 75001
        user.category = "course"
        
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
