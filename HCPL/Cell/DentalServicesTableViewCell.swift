//
//  DentalServicesTableViewCell.swift
//  HCPL
//
//  Created by Skywave-Mac on 04/08/21.
//  Copyright © 2021 Skywave-Mac. All rights reserved.
//

import UIKit

class DentalServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var viewlayout: UIView!
    @IBOutlet var ArrowRight: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}