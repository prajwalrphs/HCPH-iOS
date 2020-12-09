//
//  LeftMenuTableViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 26/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class LeftMenuTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblprofile: UILabel!
    
    @IBOutlet weak var sidetable: UITableView!
    
    var arrlable = ["Home","Contact","About","User Profile","Privacy Policy","Enable dark Mode","Logout"]
    var arrimages = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "call-2"),#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "user"),#imageLiteral(resourceName: "policyicon"),#imageLiteral(resourceName: "user"),#imageLiteral(resourceName: "logout-2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrimages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SidemenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SidemenuTableViewCell", for: indexPath) as! SidemenuTableViewCell
        
                
        if indexPath.row == 5{
            cell.img.image = arrimages[indexPath.row]
            cell.lbl.text = arrlable[indexPath.row]
            cell.img.image = cell.img.image?.withRenderingMode(.alwaysTemplate)
            cell.img.tintColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)
            cell.onoff.isHidden = false
        }else{
            cell.img.image = arrimages[indexPath.row]
            cell.lbl.text = arrlable[indexPath.row]
            cell.img.image = cell.img.image?.withRenderingMode(.alwaysTemplate)
            cell.img.tintColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)
            cell.onoff.isHidden = true
        }
        

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 2
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 2{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 1
            self.navigationController?.pushViewController(navigate, animated: true)
        }
    }
    
}
