//
//  SidemenuTableViewCell.swift
//  HCPL
//
//  Created by Skywave-Mac on 26/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class SidemenuTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var onoff: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
