//
//  ScaledHeightImageView.swift
//  LinkSAppIOS
//
//  Created by Imane on 15/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit

class ScaledHeightImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -200.0, height: -200.0)
    }
    
}
