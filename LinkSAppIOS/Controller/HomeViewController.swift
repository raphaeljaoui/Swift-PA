//
//  HomeViewController.swift
//  LinkSAppIOS
//
//  Created by Apple on 19/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var signIn: UIButton!
    
    
    @IBAction func inscription(_ sender: UIButton) {
        let signUp:SignUpViewController = SignUpViewController()
         self.present(signUp, animated: true, completion: nil)

    }
    
    
    @IBAction func connection(_ sender: UIButton) {
        let signIn:SignInViewController = SignInViewController()
                     self.present(signIn, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signIn.layer.cornerRadius = 10
             self.signUp.layer.borderWidth = 2
             self.signUp.layer.cornerRadius = 10

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
