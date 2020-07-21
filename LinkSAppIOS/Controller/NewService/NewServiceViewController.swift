//
//  NewServiceViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 13/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class NewServiceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITabBarDelegate {
    
    let typeServiceWS: TypeServiceWebService = TypeServiceWebService()
    let ServiceWS: ServiceWebService = ServiceWebService()
    let UserWS: UserWebService = UserWebService()

    var userConnected: User? = nil
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var DescriptionField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var deadlineField: UITextField!
    
    @IBOutlet weak var btnCreate: UIButton!
    var typeServicePicker: UIPickerView!
    var dateServicePicker: UIDatePicker?
    var deadlinePicker: UIDatePicker?
    
    var typeServiceList: [TypeService]? = nil
    var selectedTypeService: TypeService!
    var selectedDate: String!
    var selectedDeadline: String!

    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let typeChoose = TypeService(idType: 0, name: "Choisir votre type de service", desc: "", pic: "", act: 1)
        typeServiceList?.insert(typeChoose, at: 0)
        
        setupPicker()
        configUI()
        
        self.hideKeyboardWhenTappedAround()
        tabBar.selectedItem = tabBar.items?[0]
        self.tabBar.delegate = self
    }

    func configUI() {
        btnCreate.layer.cornerRadius = btnCreate.bounds.size.height/2
        
        navigationItem.title = "Créer un nouveau service"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupPicker(){
        //Type picker
        typeServicePicker = UIPickerView()
        typeServicePicker.delegate = self
        typeServicePicker.dataSource = self
        typeField.inputView = typeServicePicker
        selectedTypeService = typeServiceList?[0]
        
        //Date & deadLine pickers
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.dateServicePicker = UIDatePicker()
        self.deadlinePicker = UIDatePicker()
        dateServicePicker?.locale = Locale(identifier: "fr")
        deadlinePicker?.locale = Locale(identifier: "fr")
        dateServicePicker?.addTarget(self, action: #selector(dateServiceChange(datePicker:)), for: .valueChanged)
        deadlinePicker?.addTarget(self, action: #selector(deadlineServiceChange(datePicker:)), for: .valueChanged)
        
        let minDate = Date()
        dateServicePicker?.minimumDate = minDate
        deadlinePicker?.minimumDate = minDate
        
        self.dateField.inputView = dateServicePicker
        self.deadlineField.inputView = deadlinePicker
    }
    
        func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (tabBar.selectedItem == tabBar.items?[1]) {
            let mesServices = MesServicesViewController()
            mesServices.userConnected = self.userConnected
            navigationController?.pushViewController(mesServices, animated: false)
        } else if (tabBar.selectedItem == tabBar.items?[2]) {
            let messages = ListConversationsViewController()
            messages.userConnected = self.userConnected
            navigationController?.pushViewController(messages, animated: false)
        } else if (tabBar.selectedItem == tabBar.items?[3]) {
            let profil = ProfilViewController()
            profil.userConnected = userConnected
            navigationController?.pushViewController(profil, animated: false)
        }
    }
    
    @IBAction func createService(_ sender: Any) {
        let nameService = nameField.text
        let descriptionService = DescriptionField.text
        let dateService = selectedDate
        let deadlineService = selectedDeadline
        let idTypeService = selectedTypeService.id
        
        if (nameService == "" ||  descriptionService == "" ||  dateService == "" ||  deadlineService == "" || idTypeService == 0) {
            let alertController = UIAlertController(title: "Erreur de création", message: "Merci de renseigner tous les champs manquants.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Valider", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } else if(checkDates()){
            let alertController = UIAlertController(title: "Erreur de création", message: "La deadline ne peut pas être après la date", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Compris !", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            if(userConnected!.points >= 1){
                guard let idUser = userConnected?.id else { return }
                let serviceToCreate = Service(idService: 0, name: nameService!, date: dateService!, deadline: deadlineService!, cost: 1, profit: 1, access: "normal", type: idTypeService, creator: idUser, Statut: 1)
                serviceToCreate.desc = descriptionService
                ServiceWS.setService(service: serviceToCreate){ (res) in
                    if(res == true){
                        self.userConnected?.points -= 1
                        self.UserWS.updateUser(user: self.userConnected!){ (res) in
                            if(res == true){
                                self.redirectionListService()
                            }
                        }
                    }
                }
            } else {
                let alertController = UIAlertController(title: "Erreur de création", message: "Vous ne pouvez pas créer de service si vous n'avez pas de points !", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Valider", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func updateUserPoints(){
        self.userConnected?.points -= 1
        self.UserWS.updateUser(user: self.userConnected!){ (res) in
            if(res == true){
                self.redirectionListService()
            }
        }
    }
    
    func redirectionListService() {
        DispatchQueue.main.sync {
            let listServices = ListServicesViewController()
            listServices.userConnected = self.userConnected
            self.navigationController?.pushViewController(listServices, animated:true)
        }
    }
    
    func checkDates()-> Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: selectedDate)
        let deadline = formatter.date(from: selectedDeadline)
        
        if(deadline! > date!){
            return true
        }
        return false
    }
    
    @objc func dateServiceChange(datePicker : UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.dateField.text = formatter.string(from: datePicker.date)
        formatter.dateFormat = "yyyy-MM-dd"
        self.selectedDate = formatter.string(from: datePicker.date)
    }
    
    @objc func deadlineServiceChange(datePicker : UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.deadlineField.text = formatter.string(from: datePicker.date)
        formatter.dateFormat = "yyyy-MM-dd"
        self.selectedDeadline = formatter.string(from: datePicker.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeField.text = self.typeServiceList?[row].name
        selectedTypeService = typeServiceList?[row]
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let types = typeServiceList else {
            return 0
        }
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let types = typeServiceList else {
            return "undefined"
        }
        return types[row].name
    }

}
