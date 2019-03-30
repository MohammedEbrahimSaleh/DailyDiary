//
//  showMemoryViewController.swift
//  new
//
//  Created by IOS on 3/21/19.
//  Copyright © 2019 IOS. All rights reserved.
//

import UIKit

class showMemoryViewController: UIViewController {

    // variables
    var index : Int = 0
    
    @IBOutlet weak var memoryTilteTextField: UITextField!
    @IBOutlet weak var memoryBodyTextView: UITextView!
    // actions
    
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBtnPressed(_ sender: UIBarButtonItem) {
        
        let myAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this memeory ?", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default){ action in
           // myMemoriesArray.remove(at: self.index)
            self.dismiss(animated: true, completion: nil)
        }
        myAlert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel){ action in }
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated: true, completion: nil)
   
    }
 
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier:"addMemoryViewController") as!addMemoryViewController
//        vc.initator = "vc2"
//        vc.index = self.index
//        vc.memoryTitle = myMemoriesArray[self.index].memoryTitle
//        vc.memoryBody = myMemoriesArray[self.index].memoryBody
//
//
//        self.present(vc, animated: true, completion: nil)

    }
    override func viewDidLoad() {
//        memoryTilteTextField.text = myMemoriesArray[index].memoryTitle
//        memoryBodyTextView.text = myMemoriesArray[index].memoryBody
        super.viewDidLoad()

        memoryTilteTextField.allowsEditingTextAttributes = false
        memoryBodyTextView.allowsEditingTextAttributes = false
       
    }
}
