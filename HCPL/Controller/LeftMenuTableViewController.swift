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
    
    var arrlable = ["Home","Contact","About","Privacy Policy","Report Issue"]
    var arrimages = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "call-2"),#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "secure"),#imageLiteral(resourceName: "alarm"),#imageLiteral(resourceName: "user")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("releaseVersionNumber==>\(Bundle.main.releaseVersionNumber ?? "")")
        print("buildVersionNumber==>\(Bundle.main.buildVersionNumber ?? "")")
        
        arrlable.append("Version \(Bundle.main.releaseVersionNumber ?? "")")

        // Do any additional setup after loading the view.
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrimages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SidemenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SidemenuTableViewCell", for: indexPath) as! SidemenuTableViewCell
        
            cell.img.image = arrimages[indexPath.row]
            cell.lbl.text = arrlable[indexPath.row]
            cell.img.image = cell.img.image?.withRenderingMode(.alwaysTemplate)
            cell.img.tintColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 2
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 1{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 0
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 2{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 1
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 3{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 3
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 4{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 4
            self.navigationController?.pushViewController(navigate, animated: true)
        }
 
    }
    
    
    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
    
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
