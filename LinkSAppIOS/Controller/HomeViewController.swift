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

        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
        
    }
    
    
    @IBAction func connection(_ sender: UIButton) {
        //let signIn:SignInViewController = SignInViewController()
        //self.present(signIn, animated: true, completion: nil)
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUp.layer.cornerRadius = signUp.bounds.size.height/2
        signIn.layer.cornerRadius = signIn.bounds.size.height/2

        self.navigationItem.hidesBackButton = true
    }

}
