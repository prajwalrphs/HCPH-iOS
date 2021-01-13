//
//  LocationsViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 25/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var TitleArray = [String]()
    var AddressArray = [String]()
    var FirstNumberArray = [String]()
    var secondTitleArray = [String]()
    var SecondNumberArray = [String]()
    
    var ConditionString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LocationsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LocationsTableViewCell", for: indexPath) as! LocationsTableViewCell
        
        if ConditionString == "Health and Wellness Clinic Services"{
            
            cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
            cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.lblsecondTitle.isHidden = false
            cell.lblSecondNumber.isHidden = false
            cell.btnCallSecond.isHidden = false
            
            cell.lblTitle.text = TitleArray[indexPath.row]
            cell.lblAddress.text = AddressArray[indexPath.row]
            cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
            cell.lblsecondTitle.text = secondTitleArray[indexPath.row]
            cell.lblSecondNumber.text = SecondNumberArray[indexPath.row]
            
            cell.Mainview.layer.cornerRadius = 10
            
            cell.Mainview.backgroundColor = UIColor.white
            cell.Mainview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.Mainview.layer.shadowOpacity = 2
            cell.Mainview.layer.shadowOffset = CGSize.zero
            cell.Mainview.layer.shadowRadius = 2
            
            
            cell.btnLocation.layer.cornerRadius = 15
            cell.btnLocation.layer.borderWidth = 1
            cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            cell.btnCallFirst.layer.cornerRadius = 15
            cell.btnCallFirst.layer.borderWidth = 1
            cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
         
            
            cell.btnCallSecond.layer.cornerRadius = 15
            cell.btnCallSecond.layer.borderWidth = 1
            cell.btnCallSecond.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.heightconstraint.constant = 280
            
        }
        
        if ConditionString == "Refugee Helth Screeing Program"{
            if(indexPath.row == 0){
                
                cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
                cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                
                cell.lblsecondTitle.isHidden = false
                cell.lblSecondNumber.isHidden = false
                cell.btnCallSecond.isHidden = false
                
                cell.lblTitle.text = TitleArray[indexPath.row]
                cell.lblAddress.text = AddressArray[indexPath.row]
                cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
                cell.lblsecondTitle.text = secondTitleArray[indexPath.row]
                cell.lblSecondNumber.text = SecondNumberArray[indexPath.row]
                
                cell.Mainview.layer.cornerRadius = 10
                
                cell.Mainview.backgroundColor = UIColor.white
                cell.Mainview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                cell.Mainview.layer.shadowOpacity = 2
                cell.Mainview.layer.shadowOffset = CGSize.zero
                cell.Mainview.layer.shadowRadius = 2
                
                
                cell.btnLocation.layer.cornerRadius = 15
                cell.btnLocation.layer.borderWidth = 1
                cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
                cell.btnCallFirst.layer.cornerRadius = 15
                cell.btnCallFirst.layer.borderWidth = 1
                cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
             
                
                cell.btnCallSecond.layer.cornerRadius = 15
                cell.btnCallSecond.layer.borderWidth = 1
                cell.btnCallSecond.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                
                cell.heightconstraint.constant = 280
                  
            }else{
                
                cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
                cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                
                cell.lblsecondTitle.isHidden = true
                cell.lblSecondNumber.isHidden = true
                cell.btnCallSecond.isHidden = true
                
                cell.lblTitle.text = TitleArray[indexPath.row]
                cell.lblAddress.text = AddressArray[indexPath.row]
                cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
           
                cell.Mainview.layer.cornerRadius = 10
                
                cell.Mainview.backgroundColor = UIColor.white
                cell.Mainview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                cell.Mainview.layer.shadowOpacity = 2
                cell.Mainview.layer.shadowOffset = CGSize.zero
                cell.Mainview.layer.shadowRadius = 2
                
                
                cell.btnLocation.layer.cornerRadius = 15
                cell.btnLocation.layer.borderWidth = 1
                cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
                cell.btnCallFirst.layer.cornerRadius = 15
                cell.btnCallFirst.layer.borderWidth = 1
                cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
             
                cell.heightconstraint.constant = 185
                
            }
        }
        
        
        if ConditionString == "Dental Services"{
            cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
            cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.lblsecondTitle.isHidden = true
            cell.lblSecondNumber.isHidden = true
            cell.btnCallSecond.isHidden = true
            
            cell.lblTitle.text = TitleArray[indexPath.row]
            cell.lblAddress.text = AddressArray[indexPath.row]
            cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
       
            cell.Mainview.layer.cornerRadius = 10
            
            cell.Mainview.backgroundColor = UIColor.white
            cell.Mainview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.Mainview.layer.shadowOpacity = 2
            cell.Mainview.layer.shadowOffset = CGSize.zero
            cell.Mainview.layer.shadowRadius = 2
            
            
            cell.btnLocation.layer.cornerRadius = 15
            cell.btnLocation.layer.borderWidth = 1
            cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            cell.btnCallFirst.layer.cornerRadius = 15
            cell.btnCallFirst.layer.borderWidth = 1
            cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
         
            cell.heightconstraint.constant = 160
        }
        
        if ConditionString == "WIC"{
            cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
            cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.lblsecondTitle.isHidden = true
            cell.lblSecondNumber.isHidden = true
            cell.btnCallSecond.isHidden = true
            cell.lblFirstNumber.isHidden = true
            
            cell.lblTitle.text = TitleArray[indexPath.row]
            cell.lblAddress.text = AddressArray[indexPath.row]
            //cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
       
            cell.Mainview.layer.cornerRadius = 10
            
            cell.Mainview.backgroundColor = UIColor.white
            cell.Mainview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.Mainview.layer.shadowOpacity = 2
            cell.Mainview.layer.shadowOffset = CGSize.zero
            cell.Mainview.layer.shadowRadius = 2
            
            
            cell.btnLocation.layer.cornerRadius = 15
            cell.btnLocation.layer.borderWidth = 1
            cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            cell.btnCallFirst.layer.cornerRadius = 15
            cell.btnCallFirst.layer.borderWidth = 1
            cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
         
            cell.heightconstraint.constant = 178
            cell.Lblheightconstraint.constant = 0
            
        }
      
        return cell
    }
 
}
