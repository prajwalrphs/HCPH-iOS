
import UIKit

protocol DropSwitch: AnyObject {
    
    func SwitchisDrop(cell: DropDownTableViewCell)
}

class DropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var OptionSwitch: UISwitch!
    @IBOutlet var ViewBorder: UIView!
    @IBOutlet var lineview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    weak var DropSwitchisOn: DropSwitch?
    
    @IBAction func Option(_ sender: UISwitch) {
        
        DropSwitchisOn?.SwitchisDrop(cell: self)
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
