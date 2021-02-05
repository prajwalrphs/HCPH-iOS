//
//  ContactallTableViewCell.swift
//  HCPL
//
//  Created by Skywave-Mac on 27/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

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

}
