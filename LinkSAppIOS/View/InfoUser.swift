//
//  InfoUser.swift
//  LinkSAppIOS
//
//  Created by Imane on 30/04/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class InfoUser: UIView {
    

    let id: UILabel = {
        let label = UILabel()
        label.text = "Imane Benach"
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let profil: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoprofil")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let modifInfosBtn:UIButton = {
        let modif = UIButton(type: .system)
        modif.setTitle("Modifier informations", for: .normal)
        modif.translatesAutoresizingMaskIntoConstraints = false
        modif.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        modif.setTitleColor(.black, for: .normal)
        modif.addTarget(ProfilController(), action: #selector(ProfilController.nav), for: .touchUpInside)
        return modif
       }()
    
     let suppAccount:UIButton = {
        let supp = UIButton(type: .system)
        supp.setTitle("Supprimer compte", for: .normal)
        supp.translatesAutoresizingMaskIntoConstraints = false
        supp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        supp.setTitleColor(.black, for: .normal)
        supp.addTarget(ProfilController(), action: #selector(ProfilController.navDelete), for: .touchUpInside)
        return supp
     }()
    
    let justificatif:UIButton = {
       let justifi = UIButton(type: .system)
       justifi.setTitle("Ajouter justificatifs", for: .normal)
       justifi.translatesAutoresizingMaskIntoConstraints = false
       justifi.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
       justifi.setTitleColor(.black, for: .normal)
       return justifi
    }()
    
    // J'ajoute mes subView à ma main view à travers ces contraintes.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Pour mon image
        let imageDimension: CGFloat = 60
        addSubview(profil)
        profil.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profil.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profil.widthAnchor.constraint(equalToConstant: imageDimension).isActive = true
        profil.heightAnchor.constraint(equalToConstant: imageDimension).isActive = true
        profil.layer.cornerRadius = imageDimension / 6
        
        addSubview(id)
        id.centerYAnchor.constraint(equalTo: profil.centerYAnchor, constant: -24).isActive = true
        id.leftAnchor.constraint(equalTo: profil.rightAnchor, constant: 12).isActive = true

        
        addSubview(modifInfosBtn)
        modifInfosBtn.centerYAnchor.constraint(equalTo: profil.centerYAnchor, constant: 3).isActive = true
        modifInfosBtn.leftAnchor.constraint(equalTo: profil.rightAnchor, constant: 13).isActive = true
        
        
        addSubview(justificatif)
        justificatif.centerYAnchor.constraint(equalTo: profil.centerYAnchor, constant: 16).isActive = true
        justificatif.leftAnchor.constraint(equalTo: profil.rightAnchor, constant: 13).isActive = true
        
        addSubview(suppAccount)
        suppAccount.centerYAnchor.constraint(equalTo: profil.centerYAnchor, constant: 29).isActive = true
        suppAccount.leftAnchor.constraint(equalTo: profil.rightAnchor, constant: 13).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
