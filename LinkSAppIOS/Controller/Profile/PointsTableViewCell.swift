//
//  PointsTableViewCell.swift
//  LinkSAppIOS
//
//  Created by Sandrine Patin on 15/07/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class PointsTableViewCell: UITableViewCell {

    @IBOutlet weak var LabelPoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
