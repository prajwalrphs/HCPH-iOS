//
//  HoursViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 24/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class HoursViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var lblheadTitle: UILabel!
    
    var WeekArray = [String]()
    var Timearray = [String]()
    var CallArray = [String]()
    var ClinicArray = [String]()
    var NumberArray = [String]()
    
    var TitleTopBar:String!
    
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblheadTitle.text = TitleTopBar
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
          return 3
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section==0{
            return WeekArray.count
            
        }
        else if section == 1{
            return CallArray.count
        }
        else {
            
            return ClinicArray.count
           
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeekTableViewCell") as! WeekTableViewCell
            cell.weekday.text = WeekArray[indexPath.row]
            cell.time.text = Timearray[indexPath.row]
            cell.time.layer.cornerRadius = 10
            cell.time.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.time.layer.borderWidth = 1
            cell.time.clipsToBounds = true
            
            cell.viewborder.backgroundColor = UIColor.white
            cell.viewborder.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.viewborder.layer.shadowOpacity = 2
            cell.viewborder.layer.shadowOffset = CGSize.zero
            cell.viewborder.layer.shadowRadius = 2
        
            return cell
            
        } else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CallforAppointmentTableViewCell") as! CallforAppointmentTableViewCell
            cell.lbl.text = CallArray[indexPath.row]
            return cell
 
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CallforAppointmenttwoTableViewCell") as! CallforAppointmenttwoTableViewCell
            cell.clinicname.text = ClinicArray[indexPath.row]
            cell.number.text = NumberArray[indexPath.row]
            cell.borderview.backgroundColor = UIColor.white
            cell.borderview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.borderview.layer.shadowOpacity = 2
            cell.borderview.layer.shadowOffset = CGSize.zero
            cell.borderview.layer.shadowRadius = 2
            cell.call.layer.cornerRadius = 10
            cell.call.layer.borderWidth = 1
            cell.call.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            return cell

        }

        
    }

}
