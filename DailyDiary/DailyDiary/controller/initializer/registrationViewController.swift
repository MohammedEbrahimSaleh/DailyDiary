import UIKit
import Firebase
import SVProgressHUD

class registrationViewController: UIViewController {

    //variables
    
    var userName = ""
    var email = ""
    var password = ""
    var repeatPass = ""
    var image = ""
    
    
    // outlets
    
    @IBOutlet weak var userNameTextField: DesignableTextField!
    
    @IBOutlet weak var userEmailTextField: DesignableTextField!
    
    @IBOutlet weak var userPasswordTextField: DesignableTextField!
    
    @IBOutlet weak var userRepeatPasswordTextfield: DesignableTextField!
    
    // actions
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        userName=userNameTextField.text!
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
        else if (isValidPassword(testStr: password) == false)
        {
            let myAlert = UIAlertController(title: "Alert", message: "Your password should have at least one uppercase ,at least one digit,at least one lowercase, 8 characters total", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
        }
        else if (isValidEmail(email: email) == false)
        {
            let myAlert = UIAlertController(title: "Alert", message: "It's not a valid email", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
        }
            
        else
        {
            let usersDatabase = Database.database().reference().child("user")
            let userArray = ["userName":userName,"email":email,"image":image]
            usersDatabase.childByAutoId().setValue(userArray)
            {
                (error,refernce) in
                
                if error != nil {
                    print(error!)
                }
                else {print("done")}
            }
            Auth.auth().createUser(withEmail: email, password: password){ (user, error) in
                
                if error != nil {print(error!)}
                else {let myAlert = UIAlertController(title: "Congratulations", message: "Regestration successfull", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){action in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "myMemoriesViewController")as! myMemoriesViewController
                        SVProgressHUD.dismiss()
                        self.present(vc, animated: true, completion: nil)
                        
                    }
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated:true, completion:nil)}
            }
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
    
    func isValidEmail(email:String)->Bool
    {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
}
