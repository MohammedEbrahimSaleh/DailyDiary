//
//  changePasswordViewController.swift
//  DailyDiary
//
//  Created by Other user on 4/1/19.
//  Copyright © 2019 SoftTechnology. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class changePasswordViewController: UIViewController {
//------------------------------variables-----------------
    var userPassword = ""
    var oldPassword = ""
    var newpassword = ""
    var repeateNewPassword = ""
    var ref = Database.database().reference()
//------------------------------outlets-------------------
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatNewPasswordTextField: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var updateBtn: UIButton!
    
//------------------------------actions-------------------
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        
        let user = ref.child("user").child((Auth.auth().currentUser?.uid)!)
        user.observeSingleEvent(of: .value, with: { (snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            print(snapshot)
            self.userPassword = snapshotValue?.value(forKey: "password") as? String ?? "not found"
            print(self.userPassword)
         })
        
        if (oldPasswordTextField.text?.isEmpty)!
    {
        let myAlert = UIAlertController(title: "error", message: "Old password is required", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default){ action in }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
    }
  else
    {
       oldPassword = oldPasswordTextField.text!
        if (userPassword != oldPassword)
        {

            let myAlert = UIAlertController(title: "error", message: "wrong password", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default){ action in }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        else
        {
            oldPasswordTextField.isHidden = true
            doneBtn.isHidden = true
            self.showHiddenObjects()
            
        }
        
       
      }
        
    }
    
    
    
    @IBAction func updateBtnPressed(_ sender: UIButton) {
        
       SVProgressHUD.show()
       newpassword = newPasswordTextField.text!
       repeateNewPassword = repeatNewPasswordTextField.text!
        
        if (newpassword.isEmpty||repeateNewPassword.isEmpty)
        {
            
            
            let myAlert = UIAlertController(title: "Alert", message: "Enter password twice to change", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
            
        }
        else if (newpassword != repeateNewPassword)
        {
            let myAlert = UIAlertController(title: "Alert", message: "Your New password and the repeated password don't match", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
        }
        else
        {
        Auth.auth().currentUser?.updatePassword(to: newpassword) { (error) in
            print("Password changed")}
            let userID = (Auth.auth().currentUser?.uid)
           self.ref.child("user").child(userID!+"/password").setValue(self.newpassword)
            {
                (error,refernce) in
                
                if error != nil {
                    print(error!)
                }
                else {print("done")}
            }

        }
        SVProgressHUD.dismiss()
        let myAlert = UIAlertController(title: "Done", message: "Password Updated sucessfully", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){action in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "myProfileViewController")as! myProfileViewController
            self.present(vc, animated: true, completion: nil)
       }
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil)
    }
//------------------------------View did load-------------
    override func viewDidLoad() {
        super.viewDidLoad()

        oldPasswordTextField.isHidden = false
        doneBtn.isHidden = false
        roundProfilePicture()
        hideObjects()
        
        
    }
//------------------------------Functions-------------------
    func hideObjects()
    {
        newPasswordTextField.isHidden = true
        repeatNewPasswordTextField.isHidden = true
        updateBtn.isHidden = true
    }
    func showHiddenObjects()
    {
        newPasswordTextField.isHidden = false
        repeatNewPasswordTextField.isHidden = false
        updateBtn.isHidden = false
    }
    func roundProfilePicture(){
        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        // self.profileImage.layer.cornerRadius = 10.0
        self.profilePicture.clipsToBounds = true
        self.profilePicture.layer.borderWidth = 3.0
        self.profilePicture.layer.borderColor = UIColor(red: 225/225, green: 236/225, blue: 152/225, alpha: 1).cgColor
        
    }
}
