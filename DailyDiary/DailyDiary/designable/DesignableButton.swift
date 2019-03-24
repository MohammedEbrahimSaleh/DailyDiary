//
//  DesignableButton.swift
//  Gifty
//
//  Created by IOS on 2/7/19.
//  Copyright © 2019 Other user. All rights reserved.
//

import UIKit

class DesignableButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1/UIScreen.main.nativeScale
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/5
        layer.borderColor = isEnabled ? tintColor.cgColor : UIColor.lightGray.cgColor
    }
}
