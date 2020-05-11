//
//  ProfilSections.swift
//  LinkSAppIOS
//
//  Created by Imane on 30/04/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation

protocol Section: CustomStringConvertible {
    var switchBool: Bool { get }
}

enum ProfilSections: Int, CaseIterable, CustomStringConvertible {
    case Compte
    case Options
    case Points
    
    var description: String {
        switch self {
        case .Compte: return "Compte"
        case .Options: return "Options"
        case .Points: return "Points"
        }
    }
}

enum CompteOptions: Int, CaseIterable, Section {
    case deconnexion
    
    var switchBool: Bool { return false }
    
    var description: String {
        switch self {
        case .deconnexion: return "Déconnexion"
        }
    }
}

enum OpOptions: Int, CaseIterable, Section {
    // trois cases pr mes trois options
    case notifications
    case newsletter
    // Activer le switch pour les trois options
    var switchBool: Bool {
        switch self {
        case .notifications: return true
        case .newsletter: return true
        }
    }
    
    var description: String {
        switch self {
        case .notifications: return "Notifications"
        case .newsletter: return "Newsletter"
        }
    }
}
enum Points: Int, CaseIterable, Section {
    case afficherPoints
    
    var switchBool: Bool { return false }
    
    var description: String {
        switch self {
        case .afficherPoints: return "Afficher mon nombre de points"

        }
    }
}
