
import UIKit

protocol reportanissue: AnyObject {
    
    func btnidTappedreportanissue(cell: SearchlistingTableViewCell)
}

class SearchlistingTableViewCell: UITableViewCell {

    @IBOutlet var lbltitle: UILabel!
    @IBOutlet var lblyork: UILabel!
    @IBOutlet var lblkaty: UILabel!
    @IBOutlet var lblmiles: UILabel!
    @IBOutlet var lblDemerits: UILabel!
    @IBOutlet var lbldate: UILabel!
    @IBOutlet var lbllastinsp: UILabel!
    @IBOutlet var buttonview: UIView!
    @IBOutlet var buttonimage: UIImageView!
    @IBOutlet var reportissueoutlate: UIButton!
    @IBOutlet var borderview: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    weak var delegatereportanissue: reportanissue?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func reportanissueTapped(sender: AnyObject) {
        delegatereportanissue?.btnidTappedreportanissue(cell: self)
    }

}
