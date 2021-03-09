
import UIKit

class WeekTableViewCell: UITableViewCell {

    @IBOutlet weak var weekday: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var viewborder: UIView!
    @IBOutlet var borderview: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
