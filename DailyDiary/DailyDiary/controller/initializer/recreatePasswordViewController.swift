//
//  recreatePasswordViewController.swift
//  MetroMasr
//
//  Created by Other user on 2/23/19.
//  Copyright © 2019 SoftTechnology. All rights reserved.
//

import UIKit

class recreatePasswordViewController: UIViewController {

    //variables
    
    var newPassword = ""
    var repeateNewPassword = ""
    
    // outlets
    
    @IBOutlet weak var recreatPasswordTextField: DesignableTextField!
    
    @IBOutlet weak var repeatePasswordTextField: DesignableTextField!
    
    //actions

    @IBAction func doneBtnPresed(_ sender: UIButton) {
        
        newPassword=recreatPasswordTextField.text!
        repeateNewPassword=repeatePasswordTextField.text!
        
        
        if (newPassword.isEmpty || repeateNewPassword.isEmpty)
        {
            let myAlert = UIAlertController(title: "Alert", message: "You need to Enter the new psassword \n Remember", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
        }
        
        else if (newPassword != repeateNewPassword)
        {
            let myAlert = UIAlertController(title: "Alert", message: "Your password and the repeated password don't match", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
        }
        
        else
         {
            let myAlert = UIAlertController(title: "Done", message: "Password sucessfully changed now you can Log in", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){action in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "logInViewController")as! logInViewController
                self.present(vc, animated: true, completion: nil)
                
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)

        }
        
        
    }
    
    // view did load
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(logInViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        super.viewDidLoad()
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }


}
