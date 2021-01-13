//
//  LocationsTableViewCell.swift
//  HCPL
//
//  Created by Skywave-Mac on 25/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

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

}
