
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
        
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

