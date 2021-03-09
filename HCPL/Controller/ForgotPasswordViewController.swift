
import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var sendagainoutlate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendagainoutlate.layer.cornerRadius = 25
        self.sendagainoutlate.clipsToBounds = true
    }
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SendAgain(_ sender: UIButton) {
        
    }
    
}
