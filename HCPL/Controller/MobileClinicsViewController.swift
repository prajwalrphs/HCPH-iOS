//
//  MobileClinicsViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 04/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class MobileClinicsViewController: UIViewController {

    @IBOutlet weak var lblmobilehealth: UILabel!
    @IBOutlet weak var lblhealthvillage: UILabel!
    @IBOutlet weak var lblhealthvillagedes: UILabel!
    @IBOutlet weak var lblpublichealth: UILabel!
    @IBOutlet weak var lblpublichealthdes: UILabel!
    @IBOutlet weak var lblour: UILabel!
    @IBOutlet weak var lblformore: UILabel!
    @IBOutlet weak var lblnumber: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.lblmobilehealth.text = "   Mobile Health Village"
//        self.lblhealthvillage.text = "What is a Mobile Health Village?"
//        self.lblhealthvillagedes.text = "A Mobile Health Village Is a  pop-up mobile experience whaere Harris County residents of all ages benefit from HCPH's extensive health education and wellness services. from playing interactive virtual games, to seeing foster-ready pets, tp shopping at the farmer's market, to recivinf free medical or dental checkups, you and your family can enjoy a day of fun healthy activities."
//        self.lblpublichealth.text = "Taking Public health of the Public"
//        self.lblpublichealthdes.text = "A Mobile Health Village comprise seven highly interactive, state-of-the-art mobile anits, each providing specific HCPH services to the community. The Village Travels throughout unincorporated Harris Country (outside the City of Houston) to serve families in need. it is our way of extending a helping hand -- closer to your home"
//        self.lblour.text = "Our Mobile Health Village visits different communities in Harris County throughout the year"
//        self.lblformore.text = "For more information"
//        self.lblnumber.text = "832.927.7517"

    }
    
    @IBAction func backpoo(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
