
import UIKit

class AllTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var viewlayout: UIView!
    @IBOutlet var ArrowRight: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
