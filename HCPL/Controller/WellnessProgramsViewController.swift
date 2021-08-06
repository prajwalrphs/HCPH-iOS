//
//  WellnessProgramsViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 04/08/21.
//  Copyright © 2021 Skywave-Mac. All rights reserved.
//

import UIKit

class WellnessProgramsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var WellnessTable: UITableView!
    @IBOutlet var Wellnesslastview: UIView!
    
    var WellnessProgramsArray = ["Tobacco Cessation","Obesity Reduction","Diabetes Prevention Children and Adults","Immunization for Children and Adults","HIV and STI Programs","Programs Alpha","Programs Beta"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Wellnesslastview.layer.cornerRadius = 7
        Wellnesslastview.layer.borderWidth = 0.6
        Wellnesslastview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func WellnessProgram(_ sender: UIButton) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WellnessProgramsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:WellnessProgramsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WellnessProgramsTableViewCell", for: indexPath) as! WellnessProgramsTableViewCell
        
        cell.lbl.text = WellnessProgramsArray[indexPath.row]
        cell.viewlayout.layer.cornerRadius = 7
        cell.viewlayout.layer.borderWidth = 0.6
        cell.viewlayout.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{

            cell.viewlayout.backgroundColor = AppConstant.ViewColor
            cell.lbl.textColor = AppConstant.NormalTextColor
            cell.ArrowRight.tintColor = AppConstant.LabelColor
            cell.viewlayout.layer.borderColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1)
            
        }else if onoff == "off"{
            
        }else{
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/Services/TobaccoCessation", title: "Tobacco Cessation")
        }
    }
    
    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
}
