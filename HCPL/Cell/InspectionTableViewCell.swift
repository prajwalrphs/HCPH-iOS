
import UIKit

class InspectionTableViewCell: UITableViewCell {

    @IBOutlet var viewborder: UIView!
    @IBOutlet var violationslbl: UILabel!
    @IBOutlet var descriptionlbl: UILabel!
    @IBOutlet var demeritslbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
