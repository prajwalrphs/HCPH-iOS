
import UIKit
import CoreLocation

class EnvironmentalViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {

    
    @IBOutlet weak var lbltitle: UILabel!
    
    var MainTitle:String!
    
    var ArrofEnvironment = ["Built Environment","Pools","Drinking Water","Neighborhood Nuisance","Lead Abatement","Visit Our Website"]
    var ArrofServices = ["Shelter Animals","Report Animal Cruelty","VPH Maps","Events Calendar","Wish List","Visit Our Website"]
    var ArrofFoodServices = ["Search Establishments","Permit Renewals","New Customer","Events and Markets","FAQ","Nutrition & Healthy Living"]
    
    var TableArrScroll = [String]()
    
    
//    var CommercialArray = ["CommercialPools"]
//    var ids = [1]
//    var FoodTitle = "Food Safety"
    
    var FoodSafetyArray = ["Food Made Me Sick","Unclean Preparation","Something in My Food"]
    var Foodids = [1,2,3,4]
    var FoodTitle = "Food Safety"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .dark
             }
        }else if onoff == "off"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }else{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }
        
        lbltitle.text = MainTitle
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
        
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
        cell.borderview.layer.borderWidth = 0.6
        cell.borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.borderview.layer.cornerRadius = 7
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            cell.borderview.backgroundColor = AppConstant.ViewColor
            cell.lblname.textColor = AppConstant.NormalTextColor
            cell.ArrowRight.tintColor = AppConstant.LabelColor
            cell.borderview.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)

        }else if onoff == "off"{
            
        }else{
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if TableArrScroll == ArrofEnvironment{
            if indexPath.row == 0{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Programs/Built-Environment-Program", title: "Built Environment")
            }else if indexPath.row == 1{
                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Programs/Pool-Permits-and-Water-Safety", title: "Pools")
            }else if indexPath.row == 2{
                
                if CLLocationManager.locationServicesEnabled() == true {
                    if CLLocationManager.locationServicesEnabled() {
                        switch CLLocationManager.authorizationStatus() {
                            case .notDetermined, .restricted, .denied:
                                print("No access")
                                let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

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
                                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Drinking-Water", title: "Drinking Water")
                            @unknown default:
                            break
                        }
                        } else {
                            print("Location services are not enabled")
                    }
                    
                }else{
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
                

            }else if indexPath.row == 3{
                if CLLocationManager.locationServicesEnabled() == true {
                    if CLLocationManager.locationServicesEnabled() {
                        switch CLLocationManager.authorizationStatus() {
                            case .notDetermined, .restricted, .denied:
                                print("No access")
                                let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

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
                                naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Services/NeighborhoodNuisance", title: "Neighborhood Nuisance")
                            @unknown default:
                            break
                        }
                        } else {
                            print("Location services are not enabled")
                    }
                   
                }else{
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

            }else if indexPath.row == 4{
                self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Programs/Lead-Hazard-Control", title: "Lead Abatement")
            }else{
                
                if Reachability.isConnectedToNetwork(){
                    
                    self.naviGetTo(url: "https://publichealth.harriscountytx.gov/About/Organization-Offices/Environmental-Public-Health", title: "Website")
                    
                }else{
                    
                    self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
                    
                }
                

            }
        }else if TableArrScroll == ArrofServices{
            if indexPath.row == 0{
                if let url = URL(string: "https://apps.apple.com/in/app/petharbor-mobile/id989353019") {
                    UIApplication.shared.open(url)
                }
            }else if indexPath.row == 1{
                let navigate:ReportanimalViewController = self.storyboard?.instantiateViewController(identifier: "ReportanimalViewController") as! ReportanimalViewController
                navigate.CollectionReportanimal = "CollectionReportanimal"
                self.navigationController?.pushViewController(navigate, animated: true)
            }else if indexPath.row == 2{
                
                if CLLocationManager.locationServicesEnabled() == true {
                    
                    if CLLocationManager.locationServicesEnabled() {
                        switch CLLocationManager.authorizationStatus() {
                            case .notDetermined, .restricted, .denied:
                                print("No access")
                                let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

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
                                let alert = UIAlertController(title: "",
                                    message: "",
                                    preferredStyle: .alert)
                                
                                let attribMsg = NSAttributedString(string: "What are you trying to locate?",
                                                                   attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
                 
                                alert.setValue(attribMsg, forKey: "attributedTitle")
                                
                                let action1 = UIAlertAction(title: "Vet Clinic Location", style: .default, handler: { (action) -> Void in
                                        print("ACTION 1 selected!")
                                        self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=4c596ce857ef4b50930c603f2fdef55e", title: "Vet Clinic")
                                    })
                                 
                                    let action2 = UIAlertAction(title: "Dangerous Animal's Location", style: .default, handler: { (action) -> Void in
                                        print("ACTION 2 selected!")
                                        self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=bc063b6062ec4d86a282b13a0c566a7a", title: "Dangerous Animal's")
                                    })
                                 
                                    let action3 = UIAlertAction(title: "Rabies Outbreak Location", style: .default, handler: { (action) -> Void in
                                        print("ACTION 3 selected!")
                                        self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=4c596ce857ef4b50930c603f2fdef55e", title: "Rabies Outbreak")
                                    })
                                     
                                    // Cancel button
                                    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                                
                                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                                print("onoff==>\(onoff ?? "")")
                                
                                if onoff == "on"{
                                    alert.view.tintColor = AppConstant.LabelWhiteColor
                                }else{
                                    alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                                }
                                // Restyle the view of the Alert
                                alert.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  // change background color
                                alert.view.layer.cornerRadius = 25
                                
                                alert.addAction(action1)
                                alert.addAction(action2)
                                alert.addAction(action3)
                                alert.addAction(cancel)
                                present(alert, animated: true, completion: nil)
                            @unknown default:
                            break
                        }
                        } else {
                            print("Location services are not enabled")
                    }
                   
                }else{
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

            }else if indexPath.row == 3{
                self.naviGetTo(url: "http://countypets.com/Event-Calendar", title: "Event Calendar")
            }else{
                self.naviGetTo(url: "https://www.amazon.com/hz/wishlist/ls/14I5Q47TPD5CE?&", title: "Wish List")
            }
        }else{
            if indexPath.row == 0{
                
                if Reachability.isConnectedToNetwork(){
                    
                    if CLLocationManager.locationServicesEnabled() == true {
                        if CLLocationManager.locationServicesEnabled() {
                            switch CLLocationManager.authorizationStatus() {
                                case .notDetermined, .restricted, .denied:
                                    print("No access")
                                    let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

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
                                    let naviagte:SearchEstablishmentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchEstablishmentsViewController") as! SearchEstablishmentsViewController
                                    naviagte.TitleHead = "Search Establishments"
                                    self.navigationController?.pushViewController(naviagte, animated: true)
                                @unknown default:
                                break
                            }
                            } else {
                                print("Location services are not enabled")
                        }
                     
                    }else{
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
                                
                
            }else if indexPath.row == 1{
                let alert = UIAlertController(title: "",
                    message: "",
                    preferredStyle: .alert)
                
                let attribMsg = NSAttributedString(string: "Permit Renewal",
                                                   attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
 
                alert.setValue(attribMsg, forKey: "attributedTitle")
                
                let action1 = UIAlertAction(title: "Fixed Food Establishments", style: .default, handler: { (action) -> Void in
                        print("ACTION 1 selected!")
                        self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Fixed-Food-Establishments", title: "Permit Renewal")
                    })
                 
                    let action2 = UIAlertAction(title: "Mobile Units New", style: .default, handler: { (action) -> Void in
                        print("ACTION 2 selected!")
                        self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Mobile-Units-New", title: "Permit Renewal")
                    })
                 
                    let action3 = UIAlertAction(title: "Change Of Ownership", style: .default, handler: { (action) -> Void in
                        print("ACTION 3 selected!")
                        self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Change-of-Ownership", title: "Permit Renewal")
                    })
                     
                    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
                if onoff == "on"{
                    alert.view.tintColor = AppConstant.LabelWhiteColor
                }else{
                    alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                }
                // Restyle the view of the Alert
                alert.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  // change background color
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
                        self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Fixed-Food-Establishments", title: "New Customer")
                    })
                 
                    let action2 = UIAlertAction(title: "Mobile Units New", style: .default, handler: { (action) -> Void in
                        print("ACTION 2 selected!")
                        self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Mobile-Units-New", title: "New Customer")
                    })
                 
                    let action3 = UIAlertAction(title: "Change Of Ownership", style: .default, handler: { (action) -> Void in
                        print("ACTION 3 selected!")
                        self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Change-of-Ownership", title: "New Customer")
                    })
                     
                    // Cancel button
                    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
                if onoff == "on"{
                    alert.view.tintColor = AppConstant.LabelWhiteColor
                }else{
                    alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                }
                // Restyle the view of the Alert
                alert.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  // change background color
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
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
                if onoff == "on"{
                    alert.view.tintColor = AppConstant.LabelWhiteColor
                }else{
                    alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                }
                // Restyle the view of the Alert
                alert.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  // change background color
                alert.view.layer.cornerRadius = 25
                
                alert.addAction(action1)
                alert.addAction(action2)
                alert.addAction(action3)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            }else if indexPath.row == 4{
                self.naviGetTo(url: "http://publichealth.harriscountytx.gov/About/Organization-Offices/EPH/Food-Safety", title: "FAQ")
            }else if indexPath.row == 5{
                
                if Reachability.isConnectedToNetwork(){
                    
                    self.naviGetTo(url: "https://publichealth.harriscountytx.gov/about/Organization/NCDP", title: "Nutrition & Healthy Living")
                    
                }else{
                    
                    self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
                    
                }
                
  
            }
            
//            else{
//                if CLLocationManager.locationServicesEnabled() == true {
//                    let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
//                    navigate.CommercialArray = FoodSafetyArray
//                    navigate.ids = Foodids
//                    navigate.Title = FoodTitle
//                    navigate.PlaceholderGet = "Choose Subject"
//                    self.navigationController?.pushViewController(navigate, animated: true)
//                }else{
//                    let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)
//
//                    let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
//                        //Redirect to Settings app
//                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
//                    })
//
//                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
//                    alertController.addAction(cancelAction)
//
//                    alertController.addAction(okAction)
//
//                    self.present(alertController, animated: true, completion: nil)
//                }
//
//            }
        }
        

    }
    
    
    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
    
}

//if indexPath.row == 0{
//    if let url = URL(string: "itms-apps://apple.com/app/id839686104") {
//        UIApplication.shared.open(url)
//    }
//}else if indexPath.row == 1{
//    print("one click")
//    //ReportanimalViewController
//    let naviagte:ReportanimalViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReportanimalViewController") as! ReportanimalViewController
//
//    self.navigationController?.pushViewController(naviagte, animated: true)
//}else if indexPath.row == 2{
//    let alert = UIAlertController(title: "",
//        message: "",
//        preferredStyle: .alert)
//
//    let attribMsg = NSAttributedString(string: "What are you trying to locate?",
//                                       attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
//
//    alert.setValue(attribMsg, forKey: "attributedTitle")
//
//    let action1 = UIAlertAction(title: "Vet Clinic Location", style: .default, handler: { (action) -> Void in
//            print("ACTION 1 selected!")
//            self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=4c596ce857ef4b50930c603f2fdef55e", title: "Vet Clinic")
//        })
//
//        let action2 = UIAlertAction(title: "Dangerous Animal's Location", style: .default, handler: { (action) -> Void in
//            print("ACTION 2 selected!")
//            self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=bc063b6062ec4d86a282b13a0c566a7a", title: "Dangerous Animal's")
//        })
//
//        let action3 = UIAlertAction(title: "Rabies Outbreak Location", style: .default, handler: { (action) -> Void in
//            print("ACTION 3 selected!")
//            self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=4c596ce857ef4b50930c603f2fdef55e", title: "Rabies Outbreak")
//        })
//
//        // Cancel button
//        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
//
//    // Restyle the view of the Alert
//    alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)  // change text color of the buttons
//    alert.view.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)  // change background color
//    alert.view.layer.cornerRadius = 25
//
//    alert.addAction(action1)
//    alert.addAction(action2)
//    alert.addAction(action3)
//    alert.addAction(cancel)
//    present(alert, animated: true, completion: nil)
//
//}else if indexPath.row == 3{
//    self.naviGetTo(url: "http://countypets.com/Event-Calendar", title: "Event Calendar")
//}else if indexPath.row == 4{
//    self.naviGetTo(url: "https://www.amazon.com/hz/wishlist/ls/14I5Q47TPD5CE?&", title: "Wish List")
//}else if indexPath.row == 5{
//    self.naviGetTo(url: "http://publichealth.harriscountytx.gov/About/Organization-Offices/Mosquito-and-Vector-Control", title: "Website")
//}
