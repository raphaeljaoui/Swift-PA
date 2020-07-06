//
//  ListServicesViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 06/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit


class ListServicesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITabBarDelegate {
    
    let typeServiceWebService: TypeServiceWebService = TypeServiceWebService()
    
    var userConnected: User? = nil
    
    let imagesCellId = "imagesCellId"
    let albumsCellId = "albumsCellId"
    
    var imageArray: [TypeService]!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var typesServicesTableView: UITableView!
    
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
        
        //print(userConnected)
        
        loadTypesServices()
        
        configUI()
        setupViews()
        
        self.navigationItem.hidesBackButton = true
        tabBar.selectedItem = tabBar.items?[0]
        self.tabBar.delegate = self
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(tabBar.selectedItem)
        if (tabBar.selectedItem == tabBar.items?[1]) {
            let eventVC = MesServicesViewController()
            navigationController?.pushViewController(eventVC, animated: false)
        } else if (tabBar.selectedItem == tabBar.items?[2]) {
            let feedbackVC = MessagesController()
            navigationController?.pushViewController(feedbackVC, animated: true)
        } else if (tabBar.selectedItem == tabBar.items?[3]) {
            let feedbackVC = ProfilController()
            navigationController?.pushViewController(feedbackVC, animated: true)
        }
    }
    
    
    func loadTypesServices() {
        
        self.typeServiceWebService.getTypesService{ (typesServices) in
            if(typesServices.count > 0){
                self.imageArray = typesServices
                print(typesServices)
                for counter in 0..<typesServices.count {
                    self.imageArray?.append(typesServices[counter])
                }
            } else {
            }
        }
    }
    
    func nav(){
        let detail = CategoryController()
        self.navigationController?.pushViewController(detail, animated:true)
    }
    
    func configUI() {
        navigationItem.title = "Services"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .gray
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
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumsCellId)
        
        view.addSubview(collectionView)
        collectionView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: tabBar.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 18
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumsCellId, for: indexPath) as! AlbumCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCellId, for:indexPath) as! ImagesCell
        print(self.imageArray)
        cell.images = self.imageArray
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: (view.frame.width/3) - 16, height: 100)
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
        let detail = CategoryController()
        self.navigationController?.pushViewController(detail, animated:true)
    }
    
    
}
