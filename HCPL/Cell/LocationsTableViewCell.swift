
import UIKit

protocol MyCellDelegateLocation: AnyObject {
    
    func btnidTappedLocation(cell: LocationsTableViewCell)
}

protocol MyCellDelegatecall: AnyObject {
    
    func btnidTappedcall(cell: LocationsTableViewCell)
}

protocol MyCellDelegatecallsecond: AnyObject {
    
    func btnidTappedcallsecond(cell: LocationsTableViewCell)
}

class LocationsTableViewCell: UITableViewCell {

    @IBOutlet weak var Mainview: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblFirstNumber: UILabel!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnCallFirst: UIButton!
    @IBOutlet weak var lblsecondTitle: UILabel!
    @IBOutlet weak var lblSecondNumber: UILabel!
    @IBOutlet weak var btnCallSecond: UIButton!
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    @IBOutlet weak var locationimage: UIImageView!
    @IBOutlet weak var calloneimage: UIImageView!
    @IBOutlet weak var calltwoimage: UIImageView!
    @IBOutlet weak var Lblheightconstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    weak var delegateLocation: MyCellDelegateLocation?
    weak var delegatecall: MyCellDelegatecall?
    weak var delegatecallsecond: MyCellDelegatecallsecond?
    
    @IBAction func LocationnavigateTapped(sender: AnyObject) {
        
        delegateLocation?.btnidTappedLocation(cell: self)

    }
    
    @IBAction func CallnavigateTapped(sender: AnyObject) {
        
        delegatecall?.btnidTappedcall(cell: self)

    }
    
    @IBAction func CallsecondTapped(sender: AnyObject) {
        
        delegatecallsecond?.btnidTappedcallsecond(cell: self)

    }

}
