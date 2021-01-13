//
//  WeekTableViewCell.swift
//  HCPL
//
//  Created by Skywave-Mac on 24/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class WeekTableViewCell: UITableViewCell {

    @IBOutlet weak var weekday: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var viewborder: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
