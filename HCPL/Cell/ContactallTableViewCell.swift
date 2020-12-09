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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
