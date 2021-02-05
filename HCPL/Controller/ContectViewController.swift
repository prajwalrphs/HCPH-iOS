//
//  ContectViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 26/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import AMTabView

class ContectViewController: UIViewController,TabItem,UITableViewDelegate,UITableViewDataSource {

    var tabImage: UIImage? {
      return UIImage(named: "call-2")
    }
    
    @IBOutlet weak var Contactstable: UITableView!
    
    
    var indexsecondArray = ["For new mothers, infants and children services Women,infants and Children (WIC) Clinics"]
    var indexsecondArrayarrAddress = ["2223 West Loop South, Houston, TX 77027"]
    var indexsecondArrayarrMobile = ["(713) 407-5800"]
    
    var arrTitle = ["For Food establishment (Environmental Public Health)","For report issue (Home Screen)","For health Wellness Services(Disease Control and Clinical Prevention,plus Nutrition and Chronic Disease Prevention)","For animal issues(Veterinary Public Health)","For preparedness and response (Office of Public preparedness & Response)","For mosquito issues (Mosquito Control)"]
    
    var arrAddress = ["101 S. Richey Suite G. Pasadena, TX 77506","101 S. Richey Suite G. Pasadena, TX 77506","For general health and wellness services Clinical health Prevention Clinics","101 S. Richey Suite G. Pasadena, TX 77506","101 S. Richey Suite G. Pasadena, TX 77506","101 S. Richey Suite G. Pasadena, TX 77506"]
    
    var arrMap = ["101 S. Richey Suite G. Pasadena, TX 77506","2223 West Loop South, Houston, TX 77027","2223 West Loop South, Houston, TX 77027","612 Camino Road,Houston, TX 77076","2223 West Loop South, Houston, TX 77027","3330 Old Spanish Trail,Bldg. D, Houston, Tx 77021"]
    
    var arrMObile = ["(713)274-6300","(713)439-6000","(713)212-6800","(281)999-3191","(713)439-6000","(713)440-4800"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ContactallTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactallTableViewCell", for: indexPath) as! ContactallTableViewCell
        
        
        
        if indexPath.row == 2{
            cell.heightconstraint.constant = 343
            
            cell.mappinsecond.image = cell.mappin.image?.withRenderingMode(.alwaysTemplate)
            cell.mappinsecond.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.btnlocationsecond.layer.cornerRadius = 15
            cell.btnlocationsecond.layer.borderWidth = 1
            cell.btnlocationsecond.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

            cell.btncallsecond.layer.cornerRadius = 15
            cell.btncallsecond.layer.borderWidth = 1
            cell.btncallsecond.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.lbltitle.text = arrTitle[indexPath.row]
            cell.lbladdress.text = arrAddress[indexPath.row]
            cell.lblmap.text = arrMap[indexPath.row]
            cell.lblmobilenumber.text = arrMObile[indexPath.row]
            
            cell.lblsecondtitle.text = "For new mothers, infants and children services Women,infants and Children (WIC) Clinics"
            cell.lblsecondaddress.text = "2223 West Loop South, Houston, TX 77027"
            cell.lblsecondmobilenumber.text = "(713) 407-5800"
            
            cell.contectview.layer.cornerRadius = 10
            cell.contectview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.contectview.layer.borderWidth = 1
            cell.contectview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.contectview.layer.shadowRadius = 1
            
            cell.mappin.image = cell.mappin.image?.withRenderingMode(.alwaysTemplate)
            cell.mappin.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.btnlocation.layer.cornerRadius = 15
            cell.btnlocation.layer.borderWidth = 1
            cell.btnlocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

            cell.btncall.layer.cornerRadius = 15
            cell.btncall.layer.borderWidth = 1
            cell.btncall.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
        }else{
            
            cell.heightconstraint.constant = 163
                        
            cell.lbltitle.text = arrTitle[indexPath.row]
            cell.lbladdress.text = arrAddress[indexPath.row]
            cell.lblmap.text = arrMap[indexPath.row]
            cell.lblmobilenumber.text = arrMObile[indexPath.row]
            
            cell.contectview.layer.cornerRadius = 10
            cell.contectview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.contectview.layer.borderWidth = 1
            cell.contectview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.contectview.layer.shadowRadius = 1
            
            cell.mappin.image = cell.mappin.image?.withRenderingMode(.alwaysTemplate)
            cell.mappin.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.btnlocation.layer.cornerRadius = 15
            cell.btnlocation.layer.borderWidth = 1
            cell.btnlocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

            cell.btncall.layer.cornerRadius = 15
            cell.btncall.layer.borderWidth = 1
            cell.btncall.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
        }
    
        
        return cell
        
    }
}
