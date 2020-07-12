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
    
    var service: Service? = nil
    var userConnected: User? = nil
    var idExecutor: Int? = nil

    @IBOutlet weak var commentaireTF: UITextField!
    @IBOutlet weak var noteSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnEndService(_ sender: Any) {
        let commentary = commentaireTF.text
        let note = noteSlider.value
        
        if (commentary == "") {
            let alertController = UIAlertController(title: "Impossible d'envoyer l'évaluation", message: "Veuillez inscrire un commentaire", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        
        guard let idUser = idExecutor,
            let idService = service?.id else {
                return
        }
        //print(service)
        
        let applyToClose = Apply(id_service: idService)
        applyToClose.id_user = idUser
        applyToClose.execute = 2
        applyToClose.commentaire = commentary
        applyToClose.note = Int(note)
        
        ApplyWS.updateAppliance(apply: applyToClose){ (res) in
            if(res == true){
                guard let serviceToUpdate = self.service else {
                    return
                }
                serviceToUpdate.Statut = 2
                
                self.ServiceWS.updateService(service: serviceToUpdate){ (res) in
                    
                }
            }
        }
        
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
