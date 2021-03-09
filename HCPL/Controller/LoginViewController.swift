
import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var hiddenShow: UIButton!
    @IBOutlet weak var loginoutlate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginoutlate.layer.cornerRadius = 25
        self.loginoutlate.clipsToBounds = true
        
        txtemail.delegate = self
        txtpassword.delegate = self
    }
    
    @IBAction func hideshow(_ sender: UIButton) {
           sender.isSelected = !sender.isSelected
           if sender.isSelected {
           self.txtpassword.isSecureTextEntry = false
           self.showImage.image = UIImage(systemName: "eye.fill")
           } else {
           self.txtpassword.isSecureTextEntry = true
           self.showImage.image = UIImage(systemName: "eye.slash.fill")
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
    }
    
    @IBAction func guestuser(_ sender: UIButton) {
    let naviagte:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as!
               ViewController
    self.navigationController?.pushViewController(naviagte, animated: true)
    }
    
    @IBAction func signup(_ sender: UIButton) {
    
        let naviagte:SignUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as!
                   SignUpViewController
        self.navigationController?.pushViewController(naviagte, animated: true)
    }
    
    @IBAction func Retrieve(_ sender: UIButton) {
        let naviagte:ForgotPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as!
                   ForgotPasswordViewController
        self.navigationController?.pushViewController(naviagte, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                
       textField.resignFirstResponder()
       return true
      }
            
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                
        self.view.endEditing(true)
       }
    
}

extension LoginViewController{
    func hideKeyboardTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
