//
//  EnvironmentalViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 24/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class EnvironmentalViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var ArrofEnvironment = ["Built Environment","Pools","Drinking Water","Neighbourhood Nuisance","Lead Abatement"]
    var ArrofServices = ["Shelter Animal","report Animal Cruelty","VPH maps","Events Calender","Wish List"]
    var ArrofFoodServices = ["Search establishments","Permit renewals","New Customer","Events and Marjets","FAQ","Food Safety"]
    
    var TableArrScroll = [String]()
    
//    var CommercialArray = ["CommercialPools"]
//    var ids = [1]
//    var FoodTitle = "Food Safety"
    
    var FoodSafetyArray = ["Choose Subject","Food Made Me Sick","Unclean Preparation","Something in My Food"]
    var Foodids = [1,2,3,4]
    var FoodTitle = "Food Safety"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArrScroll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:EnvironmentalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EnvironmentalTableViewCell", for: indexPath) as! EnvironmentalTableViewCell
        
        cell.lblname.text = TableArrScroll[indexPath.row]
        cell.borderview.backgroundColor = UIColor.white
        cell.borderview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.borderview.layer.shadowOpacity = 2
        cell.borderview.layer.shadowOffset = CGSize.zero
        cell.borderview.layer.shadowRadius = 5
        cell.borderview.layer.cornerRadius = 15
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if TableArrScroll == ArrofEnvironment{
            if indexPath.row == 0{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Programs/Built-Environment-Program", title: "Built Environment")
            }else if indexPath.row == 1{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Programs/Pool-Permits-and-Water-Safety", title: "Pools")
            }else if indexPath.row == 2{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Drinking-Water", title: "Drinking Water")
            }else if indexPath.row == 3{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Services/NeighborhoodNuisance", title: "Neighborhood Nuisance")
            }else{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Programs/Lead-Hazard-Control", title: "Lead Abatement")
            }
        }else if TableArrScroll == ArrofServices{
            if indexPath.row == 0{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Programs/Built-Environment-Program", title: "Built Environment")
            }else if indexPath.row == 1{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Programs/Pool-Permits-and-Water-Safety", title: "Pools")
            }else if indexPath.row == 2{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Drinking-Water", title: "Drinking Water")
            }else if indexPath.row == 3{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Services/NeighborhoodNuisance", title: "Neighborhood Nuisance")
            }else{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Programs/Lead-Hazard-Control", title: "Lead Abatement")
            }
        }else{
            if indexPath.row == 0{
              
            }else if indexPath.row == 1{
                let alert = UIAlertController(title: "",
                    message: "",
                    preferredStyle: .alert)
                
                let attribMsg = NSAttributedString(string: "Permit Renewal",
                                                   attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
 
                alert.setValue(attribMsg, forKey: "attributedTitle")
                
                let action1 = UIAlertAction(title: "Fixed Food Establishments", style: .default, handler: { (action) -> Void in
                        print("ACTION 1 selected!")
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Food-Permit-Renewals/Fixed-Food-Establishments", title: "Permit Renewal")
                    })
                 
                    let action2 = UIAlertAction(title: "Mobile Units New", style: .default, handler: { (action) -> Void in
                        print("ACTION 2 selected!")
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Food-Permit-Renewals/Mobile-Units-Renewal", title: "Permit Renewal")
                    })
                 
                    let action3 = UIAlertAction(title: "Chnage Of Ownership", style: .default, handler: { (action) -> Void in
                        print("ACTION 3 selected!")
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Food-Permit-Renewals/Change-of-Ownership", title: "Permit Renewal")
                    })
                     
                    // Cancel button
                    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                
                // Restyle the view of the Alert
                alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)  // change text color of the buttons
                alert.view.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)  // change background color
                alert.view.layer.cornerRadius = 25
                
                alert.addAction(action1)
                alert.addAction(action2)
                alert.addAction(action3)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            }else if indexPath.row == 2{
                let alert = UIAlertController(title: "",
                    message: "",
                    preferredStyle: .alert)
                
                let attribMsg = NSAttributedString(string: "New Customer",
                                                   attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
 
                alert.setValue(attribMsg, forKey: "attributedTitle")
                
                let action1 = UIAlertAction(title: "Fixed Food Establishments", style: .default, handler: { (action) -> Void in
                        print("ACTION 1 selected!")
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Food-Permit-Renewals/Fixed-Food-Establishments", title: "New Customer")
                    })
                 
                    let action2 = UIAlertAction(title: "Mobile Units New", style: .default, handler: { (action) -> Void in
                        print("ACTION 2 selected!")
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Food-Permit-Renewals/Mobile-Units-Renewal", title: "New Customer")
                    })
                 
                    let action3 = UIAlertAction(title: "Chnage Of Ownership", style: .default, handler: { (action) -> Void in
                        print("ACTION 3 selected!")
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Food-Permit-Renewals/Change-of-Ownership", title: "New Customer")
                    })
                     
                    // Cancel button
                    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                
                // Restyle the view of the Alert
                alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)  // change text color of the buttons
                alert.view.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)  // change background color
                alert.view.layer.cornerRadius = 25
                
                alert.addAction(action1)
                alert.addAction(action2)
                alert.addAction(action3)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            }else if indexPath.row == 3{
                let alert = UIAlertController(title: "",
                    message: "",
                    preferredStyle: .alert)
                
                let attribMsg = NSAttributedString(string: "Events and Markets",
                                                   attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
 
                alert.setValue(attribMsg, forKey: "attributedTitle")
                
                let action1 = UIAlertAction(title: "Farmers Market Vendor", style: .default, handler: { (action) -> Void in
                        print("ACTION 1 selected!")
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Events-and-Markets/Farmers-Market-Vendors", title: "Events and Markets")
                    })
                 
                    let action2 = UIAlertAction(title: "Food Sample Permit", style: .default, handler: { (action) -> Void in
                        print("ACTION 2 selected!")
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Events-and-Markets/Food-Sample-Permit", title: "Events and Markets")
                    })
                 
                    let action3 = UIAlertAction(title: "Temporary Event Permit", style: .default, handler: { (action) -> Void in
                        print("ACTION 3 selected!")
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Events-and-Markets/Temporary-Event", title: "Events and Markets")
                    })
                     
                    // Cancel button
                    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                
                // Restyle the view of the Alert
                alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)  // change text color of the buttons
                alert.view.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)  // change background color
                alert.view.layer.cornerRadius = 25
                
                alert.addAction(action1)
                alert.addAction(action2)
                alert.addAction(action3)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            }else if indexPath.row == 4{
                self.naviGetTo(url: "http://publichealth.harriscountytx.gov/About/Organization-Offices/EPH/Food-Safety", title: "FAQ")
            }else{
                let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
                navigate.CommercialArray = FoodSafetyArray
                navigate.ids = Foodids
                navigate.Title = FoodTitle
                navigate.PlaceholderGet = "Food Safety"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
        }
        

    }
    
    
    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
    
}
