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
    
    let email: UILabel = {
        let label = UILabel()
        label.text = "adresse@gmail.com"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
       
    let profil: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        id.centerYAnchor.constraint(equalTo: profil.centerYAnchor, constant: -10).isActive = true
        id.leftAnchor.constraint(equalTo: profil.rightAnchor, constant: 12).isActive = true
        
        addSubview(email)
        email.centerYAnchor.constraint(equalTo: profil.centerYAnchor, constant: 10).isActive = true
        email.leftAnchor.constraint(equalTo: profil.rightAnchor, constant: 12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
