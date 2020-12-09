//
//  AllTableViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 03/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class AllTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var lbltext: UILabel!
    
    var TableArr = [String]()
    var TitleName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbltext.text = TitleName
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return TableArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell:AllTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
            
            cell.lbl.text = TableArr[indexPath.row]
            cell.viewlayout.layer.cornerRadius = 10
            
            cell.viewlayout.backgroundColor = UIColor.white
            cell.viewlayout.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.viewlayout.layer.shadowOpacity = 2
            cell.viewlayout.layer.shadowOffset = CGSize.zero
            cell.viewlayout.layer.shadowRadius = 2

            return cell
        }
        
}
