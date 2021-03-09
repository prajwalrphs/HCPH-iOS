
import UIKit
import AMTabView

class ProfileViewController: UIViewController,TabItem {
    
    var tabImage: UIImage? {
      return UIImage(named: "user")
    }
    
    @IBOutlet weak var txtzipcode: UITextField!
    @IBOutlet weak var txtaddress: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var notificationonoff: UISwitch!
    @IBOutlet weak var saveoutlate: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveoutlate.layer.cornerRadius = 25
        self.saveoutlate.clipsToBounds = true
    }
    
    @IBAction func save(_ sender: UIButton) {
    }
    
}
