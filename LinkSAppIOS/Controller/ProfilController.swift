
//
//  ProfilController.swift
//  LinkSAppIOS
//
//  Created by Imane on 30/04/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit
import StoreKit

private let reuseIdentifier = "ProfilCell"

class ProfilController: UIViewController {

    var tableView: UITableView!
    var infoUser: InfoUser!
    var userConnected: User? = nil

    @objc func nav(){
        self.navigationController?.pushViewController(ProfilFormController(), animated: true)
    }
    
    @objc func navDelete(){
        self.navigationController?.pushViewController(DeleteController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .white
        configUI()
        
        
       SKStoreReviewController.requestReview()
    }

    // Ma fonction pour configurer ma tableView
    func configTableV() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
            
        // J'enregistre ma UITableViewCell qui est ProfilCells
        tableView.register(ProfilCell.self, forCellReuseIdentifier: reuseIdentifier)
        // J'ajoute ma tableView a la subView
        view.addSubview(tableView)
        
        // Pour mon InfoUser qui contient son image+nom+email
        tableView.frame = view.frame
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        // Je crée mon InfoUser avec la frame ci-dessus
        infoUser = InfoUser(frame: frame)
        // Je défini la tableHeaderView sur cet infoUser
        tableView.tableHeaderView = infoUser
        
    }
    
    func configUI() {
        configTableV()
        navigationItem.title = "Profil"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .gray
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if (tabBar.selectedItem == tabBar.items?[1]) {
            let mesServices = MesServicesViewController()
            mesServices.userConnected = self.userConnected
            navigationController?.pushViewController(mesServices, animated: false)
        } else if (tabBar.selectedItem == tabBar.items?[2]) {
            let messages = MessagesController()
            navigationController?.pushViewController(messages, animated: true)
        } else if (tabBar.selectedItem == tabBar.items?[3]) {
            let profil = ProfilController()
            navigationController?.pushViewController(profil, animated: true)
        }
    }

}

extension ProfilController: UITableViewDelegate, UITableViewDataSource {
    
    // nombre de sections : 2 Compte & Options
    func numberOfSections(in tableView: UITableView) -> Int {
        // Le nombre de case que j'ai crée dans mon enum : ProfilSection
        return ProfilSections.allCases.count
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        guard let section = ProfilSections(rawValue: section) else { return 0 }
            
        switch section {
            
        case .Compte: return CompteOptions.allCases.count
        case .Options: return OpOptions.allCases.count
        case .Points: return Points.allCases.count
            
        }
    }
    
    // Ma fonction retourne UIView et va créer le header de nos deux sections
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Titre & couleur de mes sections : Compte & Option
        let view = UIView()
        view.backgroundColor = UIColor (red: (4/255.0), green: (146/255.0), blue: (255/255.0), alpha: 1.0)
        
        let titreSection = UILabel()
        titreSection.textColor = .white
        titreSection.font = UIFont.boldSystemFont(ofSize: 16)
        // Récupérer la descrip de mes deux cases pour les mettre en titre
        titreSection.text = ProfilSections(rawValue: section)?.description
        view.addSubview(titreSection)
        titreSection.translatesAutoresizingMaskIntoConstraints = false
        titreSection.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titreSection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
            
        return view
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfilCell
        
        //guard pr unwrap
        guard let section = ProfilSections(rawValue: indexPath.section) else { return UITableViewCell() }

        //  Définir les cell pour notre compte section & option section
        switch section {
            case .Compte:
                let compte = CompteOptions(rawValue: indexPath.row)
                cell.section = compte
            case .Options:
                let options = OpOptions(rawValue: indexPath.row)
                cell.section = options
            case .Points:
                let points = Points(rawValue: indexPath.row)
                cell .section = points
            
        }
             
        return cell
    }
    
    // affiche sur la console la row sur laquelle nous avons cliqué
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = ProfilSections(rawValue: indexPath.section) else { return }
        
        switch section {
            
        case .Compte:
                            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
//            let deco = HomeViewController()
//            navigationController?.pushViewController(deco, animated: true)
          
        case .Points:
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    let pop = PopUpPoints()
                    self.view.addSubview(pop)
                }
        
        case .Options:
                print(OpOptions(rawValue: indexPath.row)?.description)
          
            
        }
        
    }
    
    
}
