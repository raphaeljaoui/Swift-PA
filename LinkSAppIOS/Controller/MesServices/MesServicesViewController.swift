//
//  MesServicesViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 05/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class MesServicesViewController: UIViewController, UITabBarDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let typeServiceWS: TypeServiceWebService = TypeServiceWebService()
    let ServiceWS: ServiceWebService = ServiceWebService()

    var userConnected: User? = nil
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var collectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let albumsCellId = "albumsCellId"
    var servicesArray: [Service]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont.systemFont(ofSize: 24)
        
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        guard let user = userConnected else {
            return
        }
        guard let idUser = user.id else {
            return
        }
        
        self.ServiceWS.getMyAppliances(userId: idUser){ (services) in
            if(services.count > 0){
                self.servicesArray = services
                
                self.configUI()
                self.setupViews()
            } else {
            }
        }
        
        self.navigationItem.hidesBackButton = true
        tabBar.selectedItem = tabBar.items?[1]
        self.tabBar.delegate = self
        self.collectionView.delegate = self
    }
    
    func configUI() {
        navigationItem.title = "Mes Services"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .gray
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if (tabBar.selectedItem == tabBar.items?[0]) {
            let ListService = ListServicesViewController()
            ListService.userConnected = self.userConnected
            navigationController?.pushViewController(ListService, animated: false)
        } else if (tabBar.selectedItem == tabBar.items?[2]) {
            let messages = ListConversationsViewController()
            navigationController?.pushViewController(messages, animated: true)
        } else if (tabBar.selectedItem == tabBar.items?[3]) {
            let profil = ProfilViewController()
            profil.userConnected = userConnected
            navigationController?.pushViewController(profil, animated: true)
        }
    }
    
    @IBAction func switchServices(_ sender: Any) {
        guard let user = userConnected else {
            return
        }
        guard let idUser = user.id else {
            return
        }
        
        if(segmentControl.selectedSegmentIndex == 1){
            DispatchQueue.main.async {
                self.ServiceWS.getMyServices(userId: idUser){ (services) in
                    if(services.count > 0){
                        self.servicesArray = services
                        self.collectionView.reloadData()
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.ServiceWS.getMyAppliances(userId: idUser){ (services) in
                    if(services.count > 0){
                        self.servicesArray = services
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: albumsCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.servicesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumsCellId, for: indexPath) as! ServiceCollectionViewCell
        let service = servicesArray[indexPath.row]
        cell.nameService.text = service.name
        cell.descService.text = service.desc
        cell.dateService.text = service.date
        
        cell.dateService.text = String(service.date.prefix(10))
        
        cell.images = servicesArray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (view.frame.width/2) - 16, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detail = ServiceInfosViewController()
        detail.service = servicesArray[indexPath.item]
        detail.userConnected = userConnected
        self.navigationController?.pushViewController(detail, animated:true)
    }


}
