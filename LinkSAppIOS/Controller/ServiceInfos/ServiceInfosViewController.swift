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
    let ApplyWS : ApplyWebService = ApplyWebService()
    
    var service: Service? = nil
    var userConnected: User? = nil
    
    @IBOutlet weak var creatorService: UILabel!
    @IBOutlet weak var nameService: UILabel!
    @IBOutlet weak var typeService: UILabel!
    @IBOutlet weak var descriptionService: UILabel!
    @IBOutlet weak var dateService: UILabel!
    @IBOutlet weak var deadlineService: UILabel!
    @IBOutlet weak var profitService: UILabel!
    @IBOutlet weak var btnPostulate: UIButton!
    
    
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
        
        self.UserWS.getUserById(idUser: idUser){ (creator) in
            if(creator.count > 0){
                self.creatorService.text = creator[0].name
                
                guard let user = self.userConnected else {
                    return
                }
                
                if( user.id == creator[0].id){
                    print(user.id)
                    self.btnPostulate.isHidden = true
                    
                }
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
    
    @IBAction func btnPostulate(_ sender: Any) {
        
        guard let id_service = service?.id else {
            return
        }
        
        let userAppliance = Apply(id_service: id_service)
        userAppliance.id_user = userConnected?.id
        userAppliance.execute = 1
        
        self.ApplyWS.setAppliance(apply: userAppliance){ (type) in
            print(type)
        }
        
    }

}
