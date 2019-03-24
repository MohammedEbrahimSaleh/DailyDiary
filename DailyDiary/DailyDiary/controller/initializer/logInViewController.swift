//
//  logInViewController.swift
//  new
//
//  Created by Other user on 3/21/19.
//  Copyright © 2019 IOS. All rights reserved.
//

import UIKit

class logInViewController: UIViewController {

    // variables
    
    var email :String = ""
    var password :String = ""
    
    //outlets
    
    @IBOutlet weak var userEmailTextField: DesignableTextField!
    
    @IBOutlet weak var userPasswordTextField: DesignableTextField!
    
    // actions
    @IBAction func logInBtnPressed(_ sender: UIButton) {
        
        email=userEmailTextField.text!
        password=userPasswordTextField.text!
        
        if (email.isEmpty)
        {
            displayMyAlertMessage(alertTitle: "Alert", userMessage: "Please enter your email")
            return;
        }
        else if (password.isEmpty)
        {
            displayMyAlertMessage(alertTitle: "Alert", userMessage: "Please enter your Password if you forgot it press forget password button")
            return;
        }
        if email=="1"&&password=="1"
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "myMemoriesViewController")as! myMemoriesViewController
            self.present(vc, animated: true, completion: nil)
        }
        else
        {
            displayMyAlertMessage(alertTitle: "Alert", userMessage: "Wrong  email or passwoed")
        }
        
        
    }
    
    @IBAction func forgetPasswordBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "forgetPasswordViewController")as! forgetPasswordViewController
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "registrationViewController")as! registrationViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(logInViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    func displayMyAlertMessage(alertTitle:String,userMessage:String)
    {
        let myAlert = UIAlertController(title: alertTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
