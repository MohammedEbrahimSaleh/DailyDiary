//
//  myProfileViewController.swift
//  DailyDiary
//
//  Created by Other user on 3/30/19.
//  Copyright © 2019 SoftTechnology. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class myProfileViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    //-------------------- The variables--------------------------
    var picker:UIImagePickerController?=UIImagePickerController()
    var textField: UITextField?
    
    //-------------------- The Outlets--------------------------
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    //-------------------- The Actions--------------------------
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func updateUserNameBtnPressed(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Update", message: "Change your user name", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
            
            let userID = (Auth.auth().currentUser?.uid)
            Database.database().reference().child("user").child(userID!+"/userName").setValue(self.textField?.text)
            {
                (error,refernce) in
                
                if error != nil {
                    print(error!)
                }
                else {self.getUserNameFromDatabase()}
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    
    }
    
    @IBAction func updatePasswordBtnPressed(_ sender: UIButton) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "changePasswordViewController") as! changePasswordViewController
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = UIAlertController(title: "log out", message: "Are you sure you want to log out ?", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default){ action in
            SVProgressHUD.show()
            do {
                try Auth.auth().signOut()
            }
            catch{
                print("Error in signing out")
            }
            let vc = storyboard.instantiateViewController(withIdentifier: "logInViewController") as! logInViewController
            SVProgressHUD.dismiss()
            self.present(vc, animated: true, completion: nil)
        }
        myAlert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel){ action in }
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    //-----------------------view did load--------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

       getUserNameFromDatabase()
        
        roundProfilePicture()
        
        // tap gesture for image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(myProfileViewController.tapGesture(gesture:)))
        profilePicture.addGestureRecognizer(tapGesture)
        profilePicture.isUserInteractionEnabled = true
        picker?.delegate=self
        
        
    }
//-------------------- The functions--------------------------
    
    
    
   // the tapgesture function
    @objc func tapGesture(gesture: UIGestureRecognizer) {
        let alert:UIAlertController=UIAlertController(title: " Options", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let gallaryAction = UIAlertAction(title: "Open Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in self.openGallary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in self.cancel()
            
        }
        
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    // Alert actions functions
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    
    func cancel(){
        print("Cancel Clicked")
    }
    //image Picker functions
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profilePicture.contentMode = .scaleAspectFill
        profilePicture.image = chosenImage
        dismiss(animated: true, completion: nil)

    }
    // a function to get UserName From the Database .child("-LbKRP-emgr08TAQEEqO")
    func getUserNameFromDatabase(){
        let user = Database.database().reference().child("user").child((Auth.auth().currentUser?.uid)!)
            user.observeSingleEvent(of: .value, with: { (snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            let userName = snapshotValue?.value(forKey: "userName") as? String ?? "not found"
            self.userNameLbl.text = userName
            
        })
        {
            (error) in print(error.localizedDescription)
        }
    }
    // function to round the profile picture
    func roundProfilePicture(){
        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        // self.profileImage.layer.cornerRadius = 10.0
        self.profilePicture.clipsToBounds = true
        self.profilePicture.layer.borderWidth = 3.0
        self.profilePicture.layer.borderColor = UIColor(red: 225/225, green: 236/225, blue: 152/225, alpha: 1).cgColor
        
    }
    
    func configurationTextField(textField: UITextField!) {
        if (textField) != nil {
            self.textField = textField!        //Save reference to the UITextField
            self.textField?.placeholder = "Enter new password";
        }
    }

}
