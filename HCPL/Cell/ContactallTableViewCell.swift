
import UIKit

protocol MyocationFirst: AnyObject {
    
    func btnidTappedLocationFirst(cell: ContactallTableViewCell)
}

protocol MyocationSecond: AnyObject {
    
    func btnidTappedLocationSecond(cell: ContactallTableViewCell)
}

protocol MycallFirst: AnyObject {
    
    func btnidTappedcallFirst(cell: ContactallTableViewCell)
}

protocol MycallSecond: AnyObject {
    
    func btnidTappedcallSecond(cell: ContactallTableViewCell)
}

class ContactallTableViewCell: UITableViewCell {

    @IBOutlet weak var contectview: UIView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var lblmap: UILabel!
    @IBOutlet weak var lblmobilenumber: UILabel!
    @IBOutlet weak var btnlocation: UIButton!
    @IBOutlet weak var btncall: UIButton!
    @IBOutlet weak var mappin: UIImageView!
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblsecondtitle: UILabel!
    @IBOutlet weak var lblsecondaddress: UILabel!
    @IBOutlet weak var lblsecondmobilenumber: UILabel!
    @IBOutlet weak var mappinsecond: UIImageView!
    @IBOutlet weak var btnlocationsecond: UIButton!
    @IBOutlet weak var btncallsecond: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    weak var delegateLocationFirst: MyocationFirst?
    weak var delegateLocationSecond: MyocationSecond?
    weak var delegatecallFirst: MycallFirst?
    weak var delegatecallSecond: MycallSecond?
    
    @IBAction func LocationnavigateTappedFirst(sender: AnyObject) {
        delegateLocationFirst?.btnidTappedLocationFirst(cell: self)
    }
    
    @IBAction func LocationnavigateTappedSecond(sender: AnyObject) {
        delegateLocationSecond?.btnidTappedLocationSecond(cell: self)
    }
    
    @IBAction func CallnavigateTappedFirst(sender: AnyObject) {
        delegatecallFirst?.btnidTappedcallFirst(cell: self)
    }
    
    @IBAction func CallsecondTappedSecond(sender: AnyObject) {
        delegatecallSecond?.btnidTappedcallSecond(cell: self)
    }
    
}
