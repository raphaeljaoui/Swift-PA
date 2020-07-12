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
    let ServiceWS: ServiceWebService = ServiceWebService()
    
    var service: Service? = nil
    var userConnected: User? = nil
    var userExecutor: User? = nil
    
    @IBOutlet weak var creatorService: UILabel!
    @IBOutlet weak var nameService: UILabel!
    @IBOutlet weak var typeService: UILabel!
    @IBOutlet weak var descriptionService: UILabel!
    @IBOutlet weak var dateService: UILabel!
    @IBOutlet weak var deadlineService: UILabel!
    @IBOutlet weak var profitService: UILabel!
    @IBOutlet weak var executorService: UILabel!
    
    @IBOutlet weak var btnPostulate: UIButton!
    @IBOutlet weak var btnVolunteers: UIButton!
    @IBOutlet weak var btnDeleteService: UIButton!
    @IBOutlet weak var btnEndService: UIButton!
    
    
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
        setExecutorName()
        
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
                    self.btnPostulate.isHidden = true
                    self.btnVolunteers.isHidden = false
                    self.btnDeleteService.isHidden = false
                } else {
                    self.btnVolunteers.isHidden = true
                    self.btnDeleteService.isHidden = true
                    self.executorService.isHidden = true
                    self.btnEndService.isHidden = true
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
    
    func setExecutorName() -> Void {
        guard let idService = service?.id else {
            return
        }
        
        self.ApplyWS.getExecutorOfAService(idService: idService){ (user) in
            
            if(user.count > 0){
                self.userExecutor = user[0]
                self.executorService.text = user[0].name
                self.btnVolunteers.isHidden = true
                self.btnDeleteService.isHidden = true
            } else {
                self.btnEndService.isHidden = true
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
    
    @IBAction func btnVolunteers(_ sender: Any) {
        displayVolunteers()
    }
    
    @IBAction func btnDeleteService(_ sender: Any) {
        print("Eh cocotte jle supprime ton truc ?")
        guard let serviceToDelete = self.service else {
            return
        }
        
        let userAppliance = Apply(id_service: serviceToDelete.id)
        userAppliance.execute = 0
        self.ApplyWS.updateAppliance(apply: userAppliance) { (res) in }
        
        serviceToDelete.Statut = 0
        self.ServiceWS.updateService(service: serviceToDelete){ (res) in
            
        }
    }
    @IBAction func btnEndService(_ sender: Any) {
        let volunteers = EvaluationViewController()
        volunteers.service = self.service
        volunteers.userConnected = self.userConnected
        volunteers.idExecutor = self.userExecutor?.id
        self.navigationController?.pushViewController(volunteers, animated:true)
    }
    
    func displayVolunteers() -> Void {
        guard let idService = service?.id else {
            return
        }
        
        self.ApplyWS.getAppliances(idService: idService){ (volunteersList) in
            if(volunteersList.count > 0){
                let volunteers = ListVolunteersViewController()
                volunteers.service = self.service
                volunteers.userConnected = self.userConnected
                volunteers.volunteersList = volunteersList
                self.navigationController?.pushViewController(volunteers, animated:true)
                
            } else {
                
            }
        }
    }
    
}
