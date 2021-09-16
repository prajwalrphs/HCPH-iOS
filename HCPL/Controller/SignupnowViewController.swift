
import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class SignupnowViewController: UIViewController {

    @IBOutlet var txtname: MDCBaseTextField!
    @IBOutlet var txtaddress: MDCBaseTextField!
    @IBOutlet var txtphone: MDCBaseTextField!
    @IBOutlet var txtemail: MDCBaseTextField!
    @IBOutlet var txtcontect: MDCBaseTextField!
    
    @IBOutlet var btnsubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnsubmit.layer.cornerRadius = 20
        self.btnsubmit.clipsToBounds = true
    }

    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
