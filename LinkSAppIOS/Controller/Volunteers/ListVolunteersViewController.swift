//
//  ListVolunteersViewController.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 11/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class ListVolunteersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var service: Service? = nil
    var userConnected: User? = nil
    
    var volunteersList: [User]? = nil
    
    let albumsCellId = "albumsCellId"
        
    @IBOutlet weak var volunteersTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(volunteersList)
        
        self.volunteersTableView.register(UINib(nibName: "VolunteersTableViewCell", bundle: nil), forCellReuseIdentifier: albumsCellId)
        
        
        self.volunteersTableView.delegate = self
        self.volunteersTableView.dataSource = self
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let volunteers = volunteersList else {
            return 0
        }
        return volunteers.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: albumsCellId, for: indexPath) as! VolunteersTableViewCell

        guard let volunteer = self.volunteersList?[indexPath.row] else {
            cell.nameVolunteer.text = "undefined name"
            return cell
        }
        cell.nameVolunteer.text = "\(volunteer.name) \(volunteer.surname)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let volunteerToDisplay = self.volunteersList?[indexPath.item] else {
            return
        }
        
        let volunteers = VolunteersDetailsViewController()
        volunteers.userConnected = self.userConnected
        volunteers.volunteer = volunteerToDisplay
        volunteers.idService = service?.id
        volunteers.ListVolunteer = volunteersList
        self.navigationController?.pushViewController(volunteers, animated:true)
    }
    

}
