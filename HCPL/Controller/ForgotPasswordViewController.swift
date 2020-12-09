//
//  ForgotPasswordViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 24/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var sendagainoutlate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendagainoutlate.layer.cornerRadius = 25
        self.sendagainoutlate.clipsToBounds = true
    }
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SendAgain(_ sender: UIButton) {
        
    }
    
}
