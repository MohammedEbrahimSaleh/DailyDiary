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

class myProfileViewController: UIViewController {

    // variables
    
    //outlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    //actions
    @IBAction func updateUserNameBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func updatePasswordBtnPressed(_ sender: UIButton) {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
