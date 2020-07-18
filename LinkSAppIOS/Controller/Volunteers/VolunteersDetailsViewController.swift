//
//  VolunteersDetailsViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 11/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class VolunteersDetailsViewController: UIViewController {
    
    let ApplyWS : ApplyWebService = ApplyWebService()

    var ListVolunteer: [User]? = nil
    var volunteer: User? = nil
    var userConnected: User? = nil
    var idService: Int? = nil
    
    @IBOutlet weak var nameVolunteer: UILabel!
    @IBOutlet weak var categoryVolunteer: UILabel!
    @IBOutlet weak var badgesVolunteer: UILabel!
    @IBOutlet weak var btnValidateVolunteer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let volunteerInfos = volunteer else {
            return
        }
        
        nameVolunteer.text = "\(volunteerInfos.name) \(volunteerInfos.surname)"
    }

    @IBAction func btnValiateVolunteer(_ sender: Any) {
        guard let id_service = idService,
            let id_user = volunteer?.id,
            let allVolunteers = ListVolunteer else {
            return
        }
        
        let applyAnnulation = Apply(id_service: id_service)
        applyAnnulation.execute = 0
        
        for counter in 0..<allVolunteers.count{
            if(allVolunteers[counter].id != id_user){
                applyAnnulation.id_user = allVolunteers[counter].id
                ApplyWS.updateAppliance(apply: applyAnnulation){ (apply) in
                    print(apply)
                }
            }
        }
        
        let applyExecutor = Apply(id_service: id_service)
        applyExecutor.id_user = id_user
        applyExecutor.execute = 2
        
        ApplyWS.updateAppliance(apply: applyExecutor){ (apply) in
            if(apply == true){
                DispatchQueue.main.sync {
                    let mesServices = MesServicesViewController()
                    mesServices.userConnected = self.userConnected
                    self.navigationController?.pushViewController(mesServices, animated: false)
                }
            }
        }
        

        
    }
    

}
