
import UIKit

class CallforAppointmenttwoTableViewCell: UITableViewCell {

    @IBOutlet weak var clinicname: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var borderview: UIView!
    @IBOutlet weak var call: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
