
import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtusername: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var passwordeye: UIImageView!
    @IBOutlet weak var txtretypepassword: UITextField!
    @IBOutlet weak var retypepasswordeye: UIImageView!
    @IBOutlet weak var signupoutlate: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signupoutlate.layer.cornerRadius = 25
        self.signupoutlate.clipsToBounds = true
        
        txtusername.delegate = self
        txtemail.delegate = self
        txtpassword.delegate = self
        txtretypepassword.delegate = self
        
    }
    
    @IBAction func password(_ sender: UIButton) {
           sender.isSelected = !sender.isSelected
           if sender.isSelected {
           self.txtpassword.isSecureTextEntry = false
           self.passwordeye.image = UIImage(systemName: "eye.fill")
           } else {
           self.txtpassword.isSecureTextEntry = true
           self.passwordeye.image = UIImage(systemName: "eye.slash.fill")
        }
    }
    
    @IBAction func retypepassword(_ sender: UIButton) {
           sender.isSelected = !sender.isSelected
           if sender.isSelected {
           self.txtretypepassword.isSecureTextEntry = false
           self.retypepasswordeye.image = UIImage(systemName: "eye.fill")
           } else {
           self.txtretypepassword.isSecureTextEntry = true
           self.retypepasswordeye.image = UIImage(systemName: "eye.slash.fill")
        }
    }
    
    @IBAction func Signup(_ sender: UIButton) {
        
    }
    
    @IBAction func Login(_ sender: UIButton) {
        let naviagte:LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as!
                   LoginViewController
        self.navigationController?.pushViewController(naviagte, animated: true)
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                
       textField.resignFirstResponder()
       return true
      }
            
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                
        self.view.endEditing(true)
       }
    
}

extension SignUpViewController{
    func hideKeyboardTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
