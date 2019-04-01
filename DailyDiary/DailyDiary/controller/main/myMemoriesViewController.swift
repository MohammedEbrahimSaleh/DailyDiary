//
//  myMemoriesViewController.swift
//  new
//
//  Created by IOS on 3/21/19.
//  Copyright © 2019 IOS. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class myMemoriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,DataCollection {
    // variables
    var  myMemoriesArray : [Memory] = [Memory]()
    // outlets
    @IBOutlet weak var myMemoriesTable: UITableView!
    
    // actions
    @IBAction func addMemoriesBtnPressed(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"addMemoryViewController") as!addMemoryViewController
        vc.initator = "vc1"
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func myProfilePageBtnPressed(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"myProfileViewController") as!myProfileViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    // table functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMemoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myMemoriesTable.dequeueReusableCell(withIdentifier: "memoryCell", for: indexPath) as! memoriesTableViewCell
        cell.memoryDate.text = myMemoriesArray[indexPath.row].memoryDate
        cell.memoryTitle.text = myMemoriesArray[indexPath.row].memoryTitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"showMemoryViewController") as!showMemoryViewController
        vc.index = indexPath.row
        vc.memoryTitle = myMemoriesArray[indexPath.row].memoryTitle
        vc.memoryBody = myMemoriesArray[indexPath.row].memoryBody
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMemoriesTable.delegate = self
        myMemoriesTable.dataSource = self
        retriveMemories()
        myMemoriesTable.reloadData()
    }
    
    // Protocole functions
    
    func editCell(index: Int) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"addMemoryViewController") as!addMemoryViewController
        vc.initator="vc2"
        vc.memoryTitle = myMemoriesArray[index].memoryTitle
        vc.memoryBody = myMemoriesArray[index].memoryBody
        vc.memoryDate = myMemoriesArray[index].memoryDate
        myMemoriesArray.remove(at: index)
        self.present(vc, animated: true, completion: nil)
    }
    
    func deleteCell(index: Int) {
        myMemoriesArray.remove(at: index)
    }
    
    // to reload data ater appear again
    override func viewWillAppear(_ animated: Bool) {
        myMemoriesTable.reloadData()
    }
    // funcion to retrive messages from data base
    func retriveMemories(){
        let memoryDB = Database.database().reference().child("memory").child((Auth.auth().currentUser?.uid)!)
        memoryDB.observe(.childAdded, with: { (snapshot) in
            let snapshotValue =  snapshot.value as!  Dictionary<String,String>
            let memoryTitle = snapshotValue["memoryTitle"]!
            let memoryBody = snapshotValue["memoryBody"]!
            let memoryDate = snapshotValue["memoryDate"]!
            
            let oneMemory = Memory()
            oneMemory.memoryTitle = memoryTitle
            oneMemory.memoryBody = memoryBody
            oneMemory.memoryDate = memoryDate
            
           self.myMemoriesArray.append(oneMemory)
            self.myMemoriesTable.reloadData()
            
        })
        
    }
}

