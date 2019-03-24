import UIKit

class registrationViewController: UIViewController {

    //variables
    
    var userName = ""
    var email = ""
    var password = ""
    var repeatPass = ""
    
    
    // outlets
    
    @IBOutlet weak var userNameTextField: DesignableTextField!
    
    @IBOutlet weak var userEmailTextField: DesignableTextField!
    
    @IBOutlet weak var userPasswordTextField: DesignableTextField!
    
    @IBOutlet weak var userRepeatPasswordTextfield: DesignableTextField!
    
    // actions
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        
        userName=userEmailTextField.text!
        email=userEmailTextField.text!
        password=userPasswordTextField.text!
        repeatPass=userRepeatPasswordTextfield.text!
        
        if (userName.isEmpty||email.isEmpty||password.isEmpty||repeatPass.isEmpty)
        {
            
            
            let myAlert = UIAlertController(title: "Alert", message: "All fields are required", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
            
        }
        else if (password != repeatPass)
        {
            let myAlert = UIAlertController(title: "Alert", message: "Your password and the repeated password don't match", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
        }
            
        else
        {
            let myAlert = UIAlertController(title: "Congratulations", message: "Regestration successfull", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){action in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "myMemoriesViewController")as! myMemoriesViewController
                self.present(vc, animated: true, completion: nil)
                
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
        }
        
        
    }
    
    @IBAction func alreadyBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(logInViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        super.viewDidLoad()

       
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
}
