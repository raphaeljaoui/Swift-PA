//
//  DeleteController.swift
//  LinkSAppIOS
//
//  Created by Imane on 03/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class DeleteController: UIViewController {

 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createAlert(title: "Supprimer mon compte", message: "Êtes-vous sûr de vouloir supprimer votre compte?")
    }

    @objc func navDelete(){
        self.navigationController?.pushViewController(DeleteController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "Oui", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print ("OUI")
        }))
        
        alert.addAction(UIAlertAction(title: "Non", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("NON")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }



}
