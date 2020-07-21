//
//  ListServicesViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 06/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit


class ListServicesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITabBarDelegate, ListServicesViewControllerDelegate {
    
    let typeServiceWS: TypeServiceWebService = TypeServiceWebService()
    let ServiceWS: ServiceWebService = ServiceWebService()
    
    var userConnected: User? = nil
    var typeToDisplay: Int? = nil
    
    let imagesCellId = "imagesCellId"
    let serviceCellId = "serviceCellId"
    
    var typesArray: [TypeService]!
    var servicesArray: [Service]!
    
    @IBOutlet weak var tabBar: UITabBar!
    
    class func newInstance(userConnected: User) -> ListServicesViewController {
        DispatchQueue.main.sync {
            let listService = ListServicesViewController()
            listService.userConnected = userConnected
            return listService
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        tabBar.selectedItem = tabBar.items?[0]
        self.tabBar.delegate = self
        
        guard let type = typeToDisplay else {
            self.ServiceWS.getServices(statutId: 1){ (services) in
                if(services.count > 0){
                    self.servicesArray = services
                }
                self.configUI()
                self.setupViews()
            }
            return
        }
        self.ServiceWS.getServicesByTypeService(id_type: type, id_statut: 1){ (services) in
            if(services.count > 0){
                self.servicesArray = services
            }
            self.configUI()
            self.setupViews()
        }
        
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
    
    @objc
    func newServiceView(){
        self.typeServiceWS.getTypesService{ (typesServices) in
            if(typesServices.count > 0){
                let newService = NewServiceViewController()
                newService.typeServiceList = typesServices
                newService.userConnected = self.userConnected
                self.navigationController?.pushViewController(newService, animated:true)
            }
        }
    }
    
    
    func nav(){
        let detail = ServiceInfosViewController()
        self.navigationController?.pushViewController(detail, animated:true)
    }
    
    func configUI() {
        navigationItem.hidesBackButton = true
        let newService = UIBarButtonItem(title: "Nouveau Service", style: .plain, target: self, action: #selector(newServiceView))
        
        navigationItem.rightBarButtonItem = newService
        navigationItem.title = "Services"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    let backgroundImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(#imageLiteral(resourceName: "fondBlanc.png"))
        return iv
    }()
    
    func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(ImagesCell.self, forCellWithReuseIdentifier: imagesCellId)
        collectionView.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: serviceCellId)
        
        view.addSubview(collectionView)
        collectionView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: tabBar.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            guard let services = self.servicesArray else { return 0 }
            return services.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceCellId, for: indexPath) as! ServiceCollectionViewCell
            let service = servicesArray[indexPath.row]
            cell.nameService.text = service.name
            cell.descService.text = service.desc
            cell.dateService.text = service.date
            
            cell.dateService.text = String(service.date.prefix(10))
            cell.images = servicesArray
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCellId, for:indexPath) as! ImagesCell
        cell.Typesdelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: (view.frame.width/2) - 16, height: 100)
        }
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        }
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let detail = ServiceInfosViewController()
            detail.service = servicesArray[indexPath.item]
            detail.userConnected = userConnected
            self.navigationController?.pushViewController(detail, animated:true)
        }
    }
    
    @objc internal func typeTap(id_type: Int){
        let detail = ListServicesViewController()
        detail.userConnected = userConnected
        detail.typeToDisplay = id_type
        self.navigationController?.pushViewController(detail, animated:false)
    }
}
