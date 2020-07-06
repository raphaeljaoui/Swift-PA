//
//  MesServicesViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 05/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class MesServicesViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont.systemFont(ofSize: 24)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
