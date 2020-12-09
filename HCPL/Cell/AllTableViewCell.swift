//
//  AllTableViewCell.swift
//  HCPL
//
//  Created by Skywave-Mac on 03/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class AllTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var viewlayout: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
