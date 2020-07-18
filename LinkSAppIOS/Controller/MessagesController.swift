//
//  MessagesController.swift
//  LinkSAppIOS
//
//  Created by Imane on 08/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class MessagesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()

        // Do any additional setup after loading the view.
    }

    func configUI() {
       navigationItem.title = "Messages"
       navigationController?.navigationBar.backgroundColor = .white
       navigationController?.navigationBar.barTintColor = .gray
       navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
