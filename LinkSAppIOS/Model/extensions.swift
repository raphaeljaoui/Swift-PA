//
//  extensions.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 14/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
