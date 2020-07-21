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
    let MessageWS: MessagesWebService = MessagesWebService()
    
    var service: Service? = nil
    var userConnected: User? = nil
    var userExecutor: User? = nil
    var userCreator: User? = nil
    
    @IBOutlet weak var creatorService: UILabel!
    @IBOutlet weak var nameService: UILabel!
    @IBOutlet weak var typeService: UILabel!
    @IBOutlet weak var descriptionService: UILabel!
    @IBOutlet weak var dateService: UILabel!
    @IBOutlet weak var deadlineService: UILabel!
    @IBOutlet weak var profitService: UILabel!
    @IBOutlet weak var executorService: UILabel!
    @IBOutlet weak var labelApplied: UILabel!
    
    
    @IBOutlet weak var btnPostulate: UIButton!
    @IBOutlet weak var btnVolunteers: UIButton!
    @IBOutlet weak var btnDeleteService: UIButton!
    @IBOutlet weak var btnEndService: UIButton!
    @IBOutlet weak var btnSendMessage: UIButton!
    
    
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
        configUI()
        
        // Do any additional setup after loading the view.
    }
    
    func configUI() -> Void{
        btnEndService.layer.cornerRadius = btnEndService.bounds.size.height/2
        btnDeleteService.layer.cornerRadius = btnDeleteService.bounds.size.height/2
        btnSendMessage.layer.cornerRadius = btnSendMessage.bounds.size.height/2
        
        navigationItem.title = service?.name
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setCreatorName() -> Void {
        guard let idCreator = service?.id_creator else {
            creatorService.text = "Inconnu"
            return
        }
        
        self.UserWS.getUserById(idUser: idCreator){ (creator) in
            if(creator.count > 0){
                self.userCreator = creator[0]
                self.creatorService.text = creator[0].name
                
                guard let userConnectedId = self.userConnected?.id else {
                    return
                }
                
                if( userConnectedId == creator[0].id){
                    self.btnPostulate.isHidden = true
                    self.labelApplied.isHidden = true
                    self.btnVolunteers.isHidden = false
                    self.btnDeleteService.isHidden = false
                    
                    //hide button endService because service is already ended
                    if(self.service?.Statut == 2){
                        self.btnEndService.isHidden = true
                    }
                      
                } else {
                    self.btnVolunteers.isHidden = true
                    self.btnDeleteService.isHidden = true
                    self.executorService.isHidden = true
                    self.btnEndService.isHidden = true
                    
                    //Check if user has already postulate
                    self.ApplyWS.getUserApplianceAtService(idService: self.service!.id, idUser: userConnectedId){ (res) in
                        if(res.count > 0){
                            self.btnPostulate.isHidden = true
                            if(res[0].execute == 2){
                                self.labelApplied.text = "Vous réalisez ce service"
                            }
                        } else {
                            self.labelApplied.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    func setTypeName() -> Void {
        guard let idType = service?.id_type else {
            typeService.text = "Inconnu"
            return
        }
        
        self.TypeWS.getTypesServiceById(idType: idType){ (type) in
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
                self.executorService.text = "\(user[0].name) \(user[0].surname)"
                self.btnVolunteers.isHidden = true
                self.btnDeleteService.isHidden = true
            } else {
                self.btnSendMessage.isHidden = true
                self.executorService.isHidden = true
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
            DispatchQueue.main.sync {
                let listServices = ListServicesViewController()
                listServices.userConnected = self.userConnected
                self.navigationController?.pushViewController(listServices, animated:false)
            }
        }
    }
    
    @IBAction func btnVolunteers(_ sender: Any) {
        displayVolunteers()
    }
    
    @IBAction func btnSendMessage(_ sender: Any) {
        guard let userConnectedId = self.userConnected?.id else {
            return
        }
        let idSender = userConnectedId
        if(userConnectedId == service?.id_creator){
            let idDest = userExecutor?.id
            sendMessage(idSender: idSender, idDest: idDest!)
        } else if (userConnectedId == service?.executorUser){
            let idDest = service?.id_creator
            sendMessage(idSender: idSender, idDest: idDest!)
        }
    }

    
    @IBAction func btnDeleteService(_ sender: Any) {
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
        volunteers.executor = self.userExecutor
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
    
    func sendMessage(idSender: Int, idDest: Int){
        MessageWS.getMessagesFor2Users(idSender: idSender, idDest: idDest){ (messages) in
            let messageController = MessagesViewController()
            messageController.userConnected = self.userConnected
            
            if(idDest == self.userCreator?.id){
                messageController.dest = self.userCreator
            } else {
                messageController.dest = self.userExecutor
            }
            
            if(messages.count > 0){
                
                messageController.messagesList = messages
                
            } else {
                messageController.messagesList = []
            }
            self.navigationController?.pushViewController(messageController, animated:true)
            
            
        } 
    }
    
}
