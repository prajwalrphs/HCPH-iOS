//
//  ImageCell.swift
//  FAPaginationLayout
//
//  Created by Fahid Attique on 14/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    
    //  IBOutlets
    
    @IBOutlet var wallpaperImageView: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    
    //  Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
