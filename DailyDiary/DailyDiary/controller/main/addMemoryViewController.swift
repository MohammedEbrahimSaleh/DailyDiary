//  addMemoryViewController.swift
//  new
//  Created by IOS on 3/21/19.
//  Copyright © 2019 IOS. All rights reserved.

import UIKit

class addMemoryViewController: UIViewController{

    // variables
    
    var memoryTitle = ""
    var memoryBody = ""
    var memoryDate = ""
    let date = Date()
    let formatter = DateFormatter()
    var initator = ""
     var index : Int = 0
    
    //outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoryBodyTextField: UITextView!

    ////actions
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        
        memoryTitle = titleTextField.text!
        memoryBody = memoryBodyTextField.text!
//        memoryDate = Date.init(timeIntervalSinceNow: .)
        let memory : memorymodel = memorymodel.init(memoryTitle:memoryTitle,memoryDate:memoryDate,memoryBody:memoryBody )
        if initator=="vc2"
        { myMemoriesArray.memoryArray.remove(at: index)}
        myMemoriesArray.memoryArray.append(memory)
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"myMemoriesViewController") as!myMemoriesViewController
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"myMemoriesViewController") as!myMemoriesViewController
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
