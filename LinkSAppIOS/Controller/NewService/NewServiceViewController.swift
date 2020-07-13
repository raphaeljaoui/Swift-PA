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

    var userConnected: User? = nil
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var DescriptionField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var deadlineField: UITextField!
    
    @IBOutlet weak var btnCreate: UIButton!
    var typeServicePicker: UIPickerView!
    var datePicker: UIDatePicker?
    var deadlinePicker: UIDatePicker?
    
    var typeServiceList: [TypeService]? = nil
    var selectedTypeService: TypeService!
    var selectedDate: String!
    var selectedDeadline: String!

    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        
        self.navigationItem.hidesBackButton = true

        tabBar.selectedItem = tabBar.items?[0]
        self.tabBar.delegate = self
    }

    func configUI() {
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
        typeField.text = self.typeServiceList?[1].name
        selectedTypeService = typeServiceList?[1]
        
        //Date & deadLine pickers
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.datePicker = UIDatePicker()
        self.deadlinePicker = UIDatePicker()
        datePicker?.locale = Locale(identifier: "fr")
        deadlinePicker?.locale = Locale(identifier: "fr")
        datePicker?.addTarget(self, action: #selector(dateServiceChange(datePicker:)), for: .valueChanged)
        deadlinePicker?.addTarget(self, action: #selector(deadlineServiceChange(datePicker:)), for: .valueChanged)
        
        let minDate = Date()
        datePicker?.minimumDate = minDate
        deadlinePicker?.minimumDate = minDate
        
        self.dateField.inputView = datePicker
        self.deadlineField.inputView = deadlinePicker
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (tabBar.selectedItem == tabBar.items?[1]) {
            let eventVC = MesServicesViewController()
            eventVC.userConnected = self.userConnected
            navigationController?.pushViewController(eventVC, animated: false)
        } else if (tabBar.selectedItem == tabBar.items?[2]) {
            let feedbackVC = MessagesController()
            navigationController?.pushViewController(feedbackVC, animated: true)
        } else if (tabBar.selectedItem == tabBar.items?[3]) {
            let feedbackVC = ProfilController()
            navigationController?.pushViewController(feedbackVC, animated: true)
        }
    }
    
    @IBAction func createService(_ sender: Any) {
        let nameService = nameField.text
        let descriptionService = DescriptionField.text
        let dateService = selectedDate
        let deadlineService = selectedDeadline
        let idTypeService = selectedTypeService.id
        
        if (nameService == "" ||  descriptionService == "" ||  dateService == "" ||  deadlineService == "" ) {
            let alertController = UIAlertController(title: "Erreur de création", message: "Merci de renseigner tous les champs manquants.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Valider", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            guard let idUser = userConnected?.id else { return }
            let serviceToCreate = Service(idService: 0, name: nameService!, date: dateService!, deadline: deadlineService!, cost: 1, profit: 1, access: "normal", type: idTypeService, creator: idUser, Statut: 1)
            serviceToCreate.desc = descriptionService
            ServiceWS.setService(service: serviceToCreate){ (res) in
                
            }
        }
        
    }
    
    @objc func dateServiceChange(datePicker : UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.dateField.text = formatter.string(from: datePicker.date)
        formatter.dateFormat = "yyyy-mm-dd"
        self.selectedDate = formatter.string(from: datePicker.date)
    }
    
    
    @objc func deadlineServiceChange(datePicker : UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.deadlineField.text = formatter.string(from: datePicker.date)
        formatter.dateFormat = "yyyy-mm-dd"
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
