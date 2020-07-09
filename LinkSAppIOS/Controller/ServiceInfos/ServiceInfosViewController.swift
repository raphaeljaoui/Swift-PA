//
//  ServiceInfosViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 07/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class ServiceInfosViewController: UIViewController {
    
    let UserWS : UserWebService = UserWebService()
    let TypeWS : TypeServiceWebService = TypeServiceWebService()
    
    var service: Service? = nil
    
    @IBOutlet weak var creatorService: UILabel!
    @IBOutlet weak var nameService: UILabel!
    @IBOutlet weak var typeService: UILabel!
    @IBOutlet weak var descriptionService: UILabel!
    @IBOutlet weak var dateService: UILabel!
    @IBOutlet weak var deadlineService: UILabel!
    @IBOutlet weak var profitService: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let actualService = service else {
            return
        }
        
        nameService.text = actualService.name
        descriptionService.text = actualService.desc
        dateService.text = actualService.date
        deadlineService.text = actualService.deadline
        profitService.text = String(actualService.profit)
        
        setCreatorName()
        
        setTypeName()
        
        
        
        print(service?.name)
        // Do any additional setup after loading the view.
    }

    func setCreatorName() -> Void {
        guard let idUser = service?.id_creator else {
            creatorService.text = "Inconnu"
            return
        }
        
        self.UserWS.getUserById(idUser: idUser){ (user) in
            if(user.count > 0){
                self.creatorService.text = user[0].name
            } else {
                
            }
        }
    }
    
    func setTypeName() -> Void {
        guard let idType = service?.id_type else {
            typeService.text = "Inconnu"
            return
        }
        
        self.TypeWS.getTypesServiceById(idType: idType){ (type) in
            print(type)
            if(type.count > 0){
                self.typeService.text = type[0].name
            } else {
                
            }
        }
    }

}
