//
//  EvaluationViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 12/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class EvaluationViewController: UIViewController {

    let ApplyWS : ApplyWebService = ApplyWebService()
    let ServiceWS: ServiceWebService = ServiceWebService()
    let BadgeWS : BadgeWebService = BadgeWebService()
    let WinWS : WinWebService = WinWebService()
    let UserWS : UserWebService = UserWebService()
    
    var service: Service? = nil
    var userConnected: User? = nil
    var executor: User? = nil
    var badgesList: [Badge] = []

    @IBOutlet weak var commentaireTF: UITextField!
    @IBOutlet weak var noteSlider: UISlider!
    @IBOutlet weak var btnEndService: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        btnEndService.layer.cornerRadius = btnEndService.bounds.size.height/2
        navigationItem.title = "Evaluez le service rendu"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @IBAction func btnEndService(_ sender: Any) {
        let commentary = commentaireTF.text
        let note = noteSlider.value
        
        if (commentary == "") {
            let alertController = UIAlertController(title: "Impossible d'envoyer l'évaluation", message: "Veuillez inscrire un commentaire", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        
        guard let idExecutor = executor?.id,
            let idService = service?.id else {
                return
        }
        
        let applyToClose = Apply(id_service: idService)
        applyToClose.id_user = idExecutor
        applyToClose.execute = 2
        applyToClose.commentaire = commentary
        applyToClose.note = Int(note)
        
        ApplyWS.updateAppliance(apply: applyToClose){ (res) in
            if(res == true){
                guard let service = self.service,
                    let userExecutor = self.executor else {
                    return
                }
                service.Statut = 2
                
                self.ServiceWS.updateService(service: service){ (res) in
                    if(res == true){
                        self.executor?.points += service.profit
                        self.UserWS.updateUser(user: userExecutor){ (res) in }
                        self.calculateBadges(idUser: idExecutor, idType: service.id_type)
                    }
                }
            }
        }
    }
    
    func calculateBadges(idUser: Int, idType: Int) -> Void {
        ApplyWS.getTotalNoteForTypeService(userId: idUser, typeId: idType){ (note) in
            if(note.count > 0 && note[0] > 0){
                self.BadgeWS.getBadges(id_type_service: idType){ (badges) in
                    if(badges.count > 0){
                        self.badgesList = badges
                        self.WinWS.getUserBadges(idUser: idUser){ (badgesWin) in
                            self.setNewBadges(UserBadges: badgesWin, noteTotalUser: note[0])
                        }
                    }
                }
            }
        }
        let mesServices = MesServicesViewController()
        mesServices.userConnected = self.userConnected
        self.navigationController?.pushViewController(mesServices, animated: false)
    }

    func setNewBadges(UserBadges: [Win], noteTotalUser: Int) -> Void{
        
        for counterBadgeUser in 0..<UserBadges.count{
            var removeId : Int? = nil
            for counterBadge in 0..<badgesList.count{
                if(UserBadges[counterBadgeUser].id_badge == badgesList[counterBadge].id){
                    removeId = counterBadge
                }
            }
            if(removeId != nil){
                guard let indicebadgeToRemove = removeId else { return }
                badgesList.remove(at: indicebadgeToRemove)
            }
        }
        
        for counterBadge in 0..<badgesList.count{
            if(noteTotalUser >= badgesList[counterBadge].pointsLimit){
                guard let idUser = executor?.id else { return }
                
                let newUserBadge = Win(id_user: idUser, id_badge: badgesList[counterBadge].id)
                self.WinWS.setBadgeToUser(win: newUserBadge){ (res) in
                    self.redirectionMesServices()
                }
            }
        }
        
    }
    
    func redirectionMesServices(){
        DispatchQueue.main.sync {
            let mesServices = MesServicesViewController()
            mesServices.userConnected = self.userConnected
            self.navigationController?.pushViewController(mesServices, animated: false)
        }
    }
}
