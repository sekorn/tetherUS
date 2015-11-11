//
//  AvatarView.swift
//  tetherUS
//
//  Created by Scott on 11/6/15.
//  Copyright © 2015 Scott Kornblatt. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {

    let kAvatarSize: CGFloat = 150.0
    
    var borderColor: UIColor = UIColor.blackColor() {
        didSet {
            configure()
        }
    }
    
    var imageAvatar: UIImage? {
        didSet {
            configure()
        }
    }
    
    var borderWidth: CGFloat? = 2.0 {
        didSet {
            configure()
        }
    }

    func configure() {
        
        self.layer.cornerRadius = kAvatarSize/2.0
        self.layer.borderWidth = borderWidth!
        self.layer.borderColor = borderColor.CGColor
        self.clipsToBounds = true
        
        // configure avatar
        if let imageAvatar = imageAvatar {
            self.image = imageAvatar
        }
    }
}
