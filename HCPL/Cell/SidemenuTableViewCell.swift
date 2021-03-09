
import UIKit

protocol SwitchisOn: AnyObject {
    
    func SwitchisOnTapped(cell: SidemenuTableViewCell)
}

class SidemenuTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var darklightmode: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    weak var delegateSwitchisOn: SwitchisOn?
    
    @IBAction func Dark(_ sender: UISwitch) {
        
        delegateSwitchisOn?.SwitchisOnTapped(cell: self)
        
//        if sender.isOn {
//
//            print("is on")
//            UserDefaults.standard.set("on", forKey: AppConstant.ISONISOFF)
//            UIApplication.shared.windows.forEach { window in
//                 window.overrideUserInterfaceStyle = .dark
//             }
//        } else {
//            print("is off")
//            UserDefaults.standard.set("off", forKey: AppConstant.ISONISOFF)
//            UIApplication.shared.windows.forEach { window in
//                 window.overrideUserInterfaceStyle = .light
//             }
//        }
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

