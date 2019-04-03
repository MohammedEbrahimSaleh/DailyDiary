//  addMemoryViewController.swift
//  new
//  Created by IOS on 3/21/19.
//  Copyright © 2019 IOS. All rights reserved.

import UIKit
import Firebase
import SVProgressHUD

class addMemoryViewController: UIViewController{

    // variables
    var memoryID = ""
    var memoryTitle = ""
    var memoryBody = ""
    var memoryDate = ""
    let date = Date()
    let formatter = DateFormatter()
    var initator = ""
    
    //outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoryBodyTextField: UITextView!

    ////actions
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        titleTextField.allowsEditingTextAttributes = false
        memoryBodyTextField.allowsEditingTextAttributes = false
        SVProgressHUD.show()
       self.memoryTitle = titleTextField.text!
        self.memoryBody = memoryBodyTextField.text!
        
        if self.initator == "vc1"
        {
           self.memoryID = self.random()
        }
        
        
        let memoryDatabase = Database.database().reference().child("memory").child((Auth.auth().currentUser?.uid)!)
        
        let memoriesDictionary = ["memoryID":memoryID,"memoryTitle":memoryTitle,"memoryBody":memoryBody,"memoryDate":memoryDate]
        memoryDatabase.child(self.memoryID).setValue(memoriesDictionary){
            (error,refernce) in
            
            if error != nil {
                print(error!)
            }
            else {let myAlert = UIAlertController(title: "Done", message: "Memory is saved ", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){action in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier:"myMemoriesViewController") as!myMemoriesViewController
                    SVProgressHUD.dismiss()
                    self.present(vc, animated: true, completion: nil)
                    
                }
                myAlert.addAction(okAction)
                self.present(myAlert, animated:true, completion:nil)}
            }
        }
        
    
    
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"myMemoriesViewController") as!myMemoriesViewController
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.allowsEditingTextAttributes = true
        memoryBodyTextField.allowsEditingTextAttributes = true
        titleTextField.text = memoryTitle
        memoryBodyTextField.text = memoryBody
        formatter.dateFormat = "dd/MM/yyyy"
        memoryDate = formatter.string(from: date)
        
        // tab gesture stuff
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(addMemoryViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    // dismiss when view is tapped
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    // a function to generate memory Id
    func random() -> String
    {
        let a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        
        var s = ""
        
        for _ in 0..<28
        {
            let r = Int(arc4random_uniform(UInt32(a.characters.count)))
            
            s += String(a[a.index(a.startIndex, offsetBy: r)])
        }
        
        return s
    }
}
