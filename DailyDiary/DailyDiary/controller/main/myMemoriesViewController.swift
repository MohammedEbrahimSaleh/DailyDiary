//
//  myMemoriesViewController.swift
//  new
//
//  Created by IOS on 3/21/19.
//  Copyright © 2019 IOS. All rights reserved.
//

import UIKit

// a structure for the array model we need
struct ModelArray{
    var memoryArray:[memorymodel]
    init(memoryArray:[memorymodel])
    {
        self.memoryArray=memoryArray
    }
}
// the structure for every elemnt inside the array we need
struct memorymodel {
    var memoryTitle = ""
    var memoryBody = ""
    var memoryDate = ""
    init(memoryTitle:String,memoryDate:String,memoryBody:String)
    {
        self.memoryBody=memoryBody
        self.memoryDate=memoryDate
        self.memoryTitle=memoryTitle
    }
}
// an actuall array for memeories
var  myMemoriesArray : ModelArray = ModelArray.init(memoryArray: [])

class myMemoriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,DataCollection {
    
    // outlets
    @IBOutlet weak var myMemoriesTable: UITableView!
    
    // actions
    @IBAction func addMemoriesBtnPressed(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"addMemoryViewController") as!addMemoryViewController
        vc.initator = "vc1"
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func logOutBtnPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = UIAlertController(title: "log out", message: "Are you sure you want to log out ?", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default){ action in
           let vc = storyboard.instantiateViewController(withIdentifier: "logInViewController") as! logInViewController
            self.present(vc, animated: true, completion: nil)
        }
        myAlert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel){ action in }
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated: true, completion: nil)
    
    }
    
    // table functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMemoriesArray.memoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myMemoriesTable.dequeueReusableCell(withIdentifier: "memoryCell", for: indexPath) as! memoriesTableViewCell
        cell.memoryDate.text = myMemoriesArray.memoryArray[indexPath.row].memoryDate
        cell.memoryTitle.text = myMemoriesArray.memoryArray[indexPath.row].memoryTitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"showMemoryViewController") as!showMemoryViewController
        vc.index = indexPath.row
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMemoriesTable.delegate = self
        myMemoriesTable.dataSource = self
        myMemoriesTable.reloadData()
    }
    
    // Protocole functions
    
    func editCell(index: Int) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"addMemoryViewController") as!addMemoryViewController
        vc.initator="vc2"
        vc.memoryTitle = myMemoriesArray.memoryArray[index].memoryTitle
        vc.memoryBody = myMemoriesArray.memoryArray[index].memoryBody
        vc.memoryDate = myMemoriesArray.memoryArray[index].memoryDate
        myMemoriesArray.memoryArray.remove(at: index)
        self.present(vc, animated: true, completion: nil)
    }
    
    func deleteCell(index: Int) {
        myMemoriesArray.memoryArray.remove(at: index)
    }
    
    // to reload data ater appear again
    override func viewWillAppear(_ animated: Bool) {
        myMemoriesTable.reloadData()
    }
}

