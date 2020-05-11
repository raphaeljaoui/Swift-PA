//
//  ProfilCell.swift
//  LinkSAppIOS
//
//  Created by Imane on 30/04/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class ProfilCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         
        addSubview(controlSwitch)
        controlSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        controlSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
     }
    
    // Pour mes bouttons switch
    lazy var controlSwitch: UISwitch = {
        
        let switchC = UISwitch()
        switchC.onTintColor = UIColor(red: (246/255.0), green: (72/255.0), blue: (1/255.0), alpha: 1.0)
        switchC.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        switchC.translatesAutoresizingMaskIntoConstraints = false
        return  switchC
    }()
    
    @objc func switchAction(button: UISwitch) {
        if button.isOn {
            print("On")
        } else {
            print("Off")
        }
    }
    
     var section: Section? {
           didSet {
               guard let sectionType = section else { return }
               textLabel?.text = sectionType.description
               controlSwitch.isHidden = !sectionType.switchBool
           }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
