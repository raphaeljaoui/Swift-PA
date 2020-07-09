//
//  ServiceCollectionViewCell.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 08/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameService: UILabel!
    @IBOutlet weak var dateService: UILabel!
    @IBOutlet weak var descService: UILabel!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var stackService: UIStackView!
    @IBOutlet weak var CreatorService: UILabel!
    
    var images: [Service]? {
        didSet {
            //collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
