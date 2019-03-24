//
//  DesignableTextField.swift
//  Gifty
//
//  Created by Other user on 2/3/19.
//  Copyright © 2019 Other user. All rights reserved.
//

import UIKit
@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable var leftImage: UIImage?{
        didSet {
            updateView()
        }
    }
    func updateView(){
        if let image = leftImage{
           leftViewMode = .always
            let imageView = UIImageView(frame:CGRect(x: 5,y: 0,width: 20,height:20))
            imageView.image=image
            imageView.tintColor = tintColor
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
            view.addSubview(imageView)
            leftView = view
        }
        else{
            // image is nill
           leftViewMode = .never
        }
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder!: "", attributes: [NSAttributedStringKey.foregroundColor : tintColor])
    } 
    
}
