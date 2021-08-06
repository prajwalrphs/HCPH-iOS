//
//  DentalServicesViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 04/08/21.
//  Copyright © 2021 Skywave-Mac. All rights reserved.
//

import UIKit
import CoreLocation

class DentalServicesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {

    @IBOutlet var DentalServicesTable: UITableView!
    
    let locationManager = CLLocationManager()
    
    var DentalServicesArray = ["In Clinic Dental Services","Smile servers Services","Community Dental Services","Education Resources","Referrals","Locations","Hours"]
    
    var DentalTitleArray = ["Harris County Public Health Humble Clinic","Harris County Public Health Southeast Clinic"]
    var DentalAddressArray = ["1730 Humble Place Drive Humble, TX 77338","3737 Red Bluff Road Pasadena, TX 77503"]
    var DentalFirstNumberArray = ["832.927.1300","713.274.9430"]
    var DentalsecondTitleArray = ["Dental","Dental"]
    var DentalSecondNumberArray = ["832-927-7350","832-927-7350"]
    
    var WeekArray = [" Monday"," Tuesday"," Wednesday"," Thursday"," Friday"]
    var Timearray = ["8:00am-5:00pm","8:00am-5:00pm","8:00am-5:00pm","8:00am-5:00pm","8:00am-5:00pm"]
    var CallArray = ["Call for Appointment"]
    var ClinicArray = ["Humbali Clinic","Humbali Clinic"]
    var NumberArray = ["123.345.78900","123.345.78900"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DentalServicesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DentalServicesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DentalServicesTableViewCell", for: indexPath) as! DentalServicesTableViewCell
        
        cell.lbl.text = DentalServicesArray[indexPath.row]
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
        
        if Reachability.isConnectedToNetwork(){
            if CLLocationManager.locationServicesEnabled() == true {
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        self.locationManager.requestWhenInUseAuthorization()
//                        if indexPath.row == 5{
//                            let navigate:LocationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationsViewController") as! LocationsViewController
//                            navigate.TitleArray = DentalTitleArray
//                            navigate.AddressArray = DentalAddressArray
//                            navigate.FirstNumberArray = DentalFirstNumberArray
//                            navigate.secondTitleArray = DentalsecondTitleArray
//                            navigate.SecondNumberArray = DentalSecondNumberArray
//                            navigate.ConditionString = "Dental Services"
//                            self.navigationController?.pushViewController(navigate, animated: true)
//                        }
//
//                        if indexPath.row == 6{
//                            let navigate:HoursViewController = self.storyboard?.instantiateViewController(withIdentifier: "HoursViewController") as! HoursViewController
//                            navigate.WeekArray = WeekArray
//                            navigate.Timearray = Timearray
//                            navigate.CallArray = CallArray
//                            navigate.ClinicArray = ClinicArray
//                            navigate.NumberArray = NumberArray
//                            navigate.TitleTopBar = "Hours"
//                            self.navigationController?.pushViewController(navigate, animated: true)
//                        }
                    case .restricted, .denied:
                            print("No access")
                        //self.locationManager.requestWhenInUseAuthorization()
                        let alertController = UIAlertController(title: "HCPL", message: "Please provide location permission from settings screen", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })
                        
                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                            alertController.addAction(cancelAction)
                        
                            alertController.addAction(okAction)

                            self.present(alertController, animated: true, completion: nil)
                        case .authorizedAlways, .authorizedWhenInUse:
                            print("Access")
                            
                            if indexPath.row == 0{
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Dental-Services/Dental-Clinics", title: "In Clinic Dental Services")
                            }
                            
                            if indexPath.row == 1{
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/Services/Dental-Service/SmileSaver", title: "Smile servers Services")
                            }
                            
                            if indexPath.row == 2{
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Dental-Services/Community-Dental-Services", title: "Community Services")
                            }
                            
                            if indexPath.row == 3{
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Dental-Services/Oral-Health-Education-Resources", title: "Education Resources")
                            }
                            
                            if indexPath.row == 4{
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Dental-Services/Referrals", title: "Referrals")
                            }
                            
                            if indexPath.row == 5{
                                let navigate:LocationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationsViewController") as! LocationsViewController
                                navigate.TitleArray = DentalTitleArray
                                navigate.AddressArray = DentalAddressArray
                                navigate.FirstNumberArray = DentalFirstNumberArray
                                navigate.secondTitleArray = DentalsecondTitleArray
                                navigate.SecondNumberArray = DentalSecondNumberArray
                                navigate.ConditionString = "Dental Services"
                                self.navigationController?.pushViewController(navigate, animated: true)
                            }
                            
                            if indexPath.row == 6{
                                let navigate:HoursViewController = self.storyboard?.instantiateViewController(withIdentifier: "HoursViewController") as! HoursViewController
                                navigate.WeekArray = WeekArray
                                navigate.Timearray = Timearray
                                navigate.CallArray = CallArray
                                navigate.ClinicArray = ClinicArray
                                navigate.NumberArray = NumberArray
                                navigate.TitleTopBar = "Hours"
                                self.navigationController?.pushViewController(navigate, animated: true)
                            }
                        @unknown default:
                        break
                    }
                    } else {
                        print("Location services are not enabled")
                }
               
            }else {
                
                let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                    //Redirect to Settings app
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })

                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                alertController.addAction(cancelAction)

                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
                
                
             }
        }else{
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
    }
    
    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
    
}
