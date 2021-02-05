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
    @IBOutlet weak var lbltitle: UILabel!
    
    var TableArr = [String]()
    var TitleName:String!
    var Titlehead:String!
    
    var WeekArray = [" Monday"," Tuesday"," Wednesday"," Thursday"," Friday"]
    var Timearray = ["8:00am-5:00pm","8:00am-5:00pm","8:00am-5:00pm","8:00am-5:00pm","8:00am-5:00pm"]
    var CallArray = ["Call for Appointment"]
    var ClinicArray = ["Humbali Clinic","Humbali Clinic"]
    var NumberArray = ["123.345.78900","123.345.78900"]
    
    var TitleArray = ["Harris County Public Health Humble Clinic","Harris County Public Health Southeast Clinic"]
    var AddressArray = ["1730 Humble Place Drive Humble, TX 77338","3737 Red Bluff Road Pasadena, TX 77503"]
    var FirstNumberArray = ["832-927-7350","832-927-7350"]
    var secondTitleArray = ["Dental","Dental"]
    var SecondNumberArray = ["832-927-7350","832-927-7350"]
    
    var DentalTitleArray = ["Harris County Public Health Humble Clinic","Harris County Public Health Southeast Clinic"]
    var DentalAddressArray = ["1730 Humble Place Drive Humble, TX 77338","3737 Red Bluff Road Pasadena, TX 77503"]
    var DentalFirstNumberArray = ["832.927.1300","713.274.9430"]
    var DentalsecondTitleArray = ["Dental","Dental"]
    var DentalSecondNumberArray = ["832-927-7350","832-927-7350"]
    
    
    var RefugeeTitleArray = ["Outreach Center","interfaith Ministries","Catholic Charities","Alliance for Multicultureal Community Services","Refugee Services of Texas","YMCA International Services"]
    var RefugeeAddressArray = ["7447 Harwin Drive, Suite 180 Houston Texas 77036","3217 Montrose Blvd Houston, Texas 77006","2900 Louisiana Street Houston, TX 77006","6440 Hillcroft St Suite 411 Houston, Texas 77081","6065 Hillcroft Street Suite 513 Houston, Texas 77081","6300 Westpark Suite 600 Houston, Texas 77057"]
    
    var RefugeeFirstNumberArray = ["(713)274-2599","(713)533-4900","(713)874-6574","(713)776-4700","(713)644-6224","(713)339-9015"]
    var RefugeesecondTitleArray = ["FAX"]
    var RefugeeSecondNumberArray = ["(713)437-4611"]
    
    var DantalWeekArray = [" Monday-Friday"]
    var DantalTimearray = ["8am-5pm"]
    
    var HealthArraydays = [" Monday"," Tuesday"," Wednesday"," Thursday"," Friday"," Saturday"]
    var HealthArrayTime = ["8am-5pm","8am-5pm","8am-7pm","8am-5pm","8am-5pm","8am-2pm"]
    var HealthArrayCall = ["Open on the 2nd Saturday of the month"]
    
    var RefugeeArraydays = [" Monday"," Tuesday"," Wednesday"," Thursday"," Friday"]
    var RefugeeArrayTime = ["8:30 am-5:00 pm","8:30 am-5:00 pm","8:30 am-5:00 pm","8:30 am-5:00 pm","8:30 am-5:00 pm"]
    var RefugeeArrayCall = ["Walk-ins are welcome, however we recommend calling before you arrive"]
    
    var WICTitleArray = ["WIC Administration Office","Harris County Public Helalth Antoine WIC Center","Harris County Public Helalth Bear Creek WIC","Harris County Public Helalth Decker Drive WIC Center","Harris County Public Helalth Emerald Plaza WIC Center","Harris County Public Helalth Fallbrook WIC Center","Harris County Public Humble WIC Center","Harris County Public Helalth Cypress Station WIC Center","Harris County Public Helalth Shaver WIC Center","Harris County Public Helalth Scarsdale WIC Center","Harris County Public Helalth Tomball WIC Center","Harris County Public Helalth Southeast WIC Center"]
    
    var WICAddressArray = ["2223 West Loop south, Suit 529 Houston Taxes 77027","5815 Antoine Drive Houston, Texas 77091","16233 Clay Road, Suit 318, Houston TX 77084","4128 decker Drive,Baytown, Texas 77520","11509 Veterans Memorial Drive,Suite 400 Houston,Texas 77067","14901 SH 249 Tomball Parkway,suit 107 Houston, Texas 77086","8950 Will Clyton Parkway, Suite A Humble Texas 77338","221 FM 1960 West, suit A Houston, Texas 77090","152 Fairmont Parkway, Pasadena,Texas 77504","10851 Scarsdale Boulevard,Suit 116 Houston,teaxas 77089","701 East Main street, Suite # 145b Tomball, Teaxas 77375","3737 red Bluff Road Pasadena,Teaxas 77503"]
    
    var WICArraydays = [" Monday"," Tuesday"," Wednesday"," Thursday"," Friday"," Saturday"]
    var WICArrayTime = ["8:00 am-5:30 pm","8:00 am-5:30 pm","8:00 am-5:30 pm","8:00 am-2:30 pm","8:00 am-2:30 pm","Call for an appointment"]
    var WICCallArray = ["Please note that for Saturday appointments,you must call Moday - Friday"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbltext.text = TitleName
        self.lbltitle.text = Titlehead
    }
    
    @IBAction func backpoo(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          return 1
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if TitleName == "Health and Wellness Clinic Services"{
            
            if indexPath.row == 0{
                let navigate:LocationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationsViewController") as! LocationsViewController
                navigate.TitleArray = TitleArray
                navigate.AddressArray = AddressArray
                navigate.FirstNumberArray = FirstNumberArray
                navigate.secondTitleArray = secondTitleArray
                navigate.SecondNumberArray = SecondNumberArray
                navigate.ConditionString = "Health and Wellness Clinic Services"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
            
            if indexPath.row == 1{
                let navigate:HoursViewController = self.storyboard?.instantiateViewController(withIdentifier: "HoursViewController") as! HoursViewController
                navigate.WeekArray = HealthArraydays
                navigate.Timearray = HealthArrayTime
                navigate.CallArray = HealthArrayCall
                navigate.TitleTopBar = "Hours"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
            
            if indexPath.row == 2{
                let navigate:HoursViewController = self.storyboard?.instantiateViewController(withIdentifier: "HoursViewController") as! HoursViewController
                navigate.WeekArray = DantalWeekArray
                navigate.Timearray = DantalTimearray
                navigate.TitleTopBar = "Dantal"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
        }
        
        if TitleName == "Refugee Helth Screeing Program"{
            
            if indexPath.row == 0{
                let navigate:LocationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationsViewController") as! LocationsViewController
                navigate.TitleArray = RefugeeTitleArray
                navigate.AddressArray = RefugeeAddressArray
                navigate.FirstNumberArray = RefugeeFirstNumberArray
                navigate.secondTitleArray = RefugeesecondTitleArray
                navigate.SecondNumberArray = RefugeeSecondNumberArray
                navigate.ConditionString = "Refugee Helth Screeing Program"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
            
            if indexPath.row == 1{
                let navigate:HoursViewController = self.storyboard?.instantiateViewController(withIdentifier: "HoursViewController") as! HoursViewController
                navigate.WeekArray = RefugeeArraydays
                navigate.Timearray = RefugeeArrayTime
                navigate.CallArray = RefugeeArrayCall
                navigate.TitleTopBar = "Hours"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
        }
        
        if TitleName == "Dental Services"{
            
            if indexPath.row == 0{
                let navigate:LocationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationsViewController") as! LocationsViewController
                navigate.TitleArray = DentalTitleArray
                navigate.AddressArray = DentalAddressArray
                navigate.FirstNumberArray = DentalFirstNumberArray
                navigate.secondTitleArray = DentalsecondTitleArray
                navigate.SecondNumberArray = DentalSecondNumberArray
                navigate.ConditionString = "Dental Services"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
            
            if indexPath.row == 1{
                let navigate:HoursViewController = self.storyboard?.instantiateViewController(withIdentifier: "HoursViewController") as! HoursViewController
                navigate.WeekArray = WeekArray
                navigate.Timearray = Timearray
                navigate.CallArray = CallArray
                navigate.ClinicArray = ClinicArray
                navigate.NumberArray = NumberArray
                navigate.TitleTopBar = "Hours"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
        }
        
        if TitleName == "Women, infants and Children (WIC)"{
            
            if indexPath.row == 0{
                let navigate:LocationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationsViewController") as! LocationsViewController
                navigate.TitleArray = WICTitleArray
                navigate.AddressArray = WICAddressArray
//                navigate.FirstNumberArray = DentalFirstNumberArray
//                navigate.secondTitleArray = DentalsecondTitleArray
//                navigate.SecondNumberArray = DentalSecondNumberArray
                navigate.ConditionString = "WIC"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
            
            if indexPath.row == 1{
                let navigate:HoursViewController = self.storyboard?.instantiateViewController(withIdentifier: "HoursViewController") as! HoursViewController
                navigate.WeekArray = WICArraydays
                navigate.Timearray = WICArrayTime
                navigate.CallArray = WICCallArray
                navigate.TitleTopBar = "Hours"
                self.navigationController?.pushViewController(navigate, animated: true)
            }
        }
            
        }
     
    }
    
