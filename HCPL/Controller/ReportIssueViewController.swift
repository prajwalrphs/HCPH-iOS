
import UIKit
import AMTabView
import CoreLocation
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class ReportIssueViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TabItem,CLLocationManagerDelegate {

    var tabImage: UIImage? {
      return UIImage(named: "alarm")
    }
    
    @IBOutlet weak var reporttable: UITableView!
    
    var Arrofname = ["Commercial Pools","Dead Bird","Drinking Water","Mosquito Breeding Site","Neighborhood Nuisance","Report Animal Cruelty"]
    
    var CommercialArray = ["Commercial Pools"]
    var ids = [1]
    var CommercialTitle = "Commercial Pools"
    
    var FoodSafetyArray = ["Food Made Me Sick","Unclean Preparation","Something in My Food"]
    var Foodids = [1,2,3,4]
    var FoodTitle = "Food Safety"
    
    var NeighbourArray = ["Neighborhood Nuisance"]
    var Neighbourids = [1]
    var NeighbourTitle = "Neighborhood Nuisance"
    
    var DrinkingWater = ["Public Drinking Water"]
    var DrinkingWaterids = [1]
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()

               // For use in foreground
               self.locationManager.requestWhenInUseAuthorization()

               if CLLocationManager.locationServicesEnabled() {
                   locationManager.delegate = self
                   locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                   locationManager.startUpdatingLocation()
               }
        
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
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(locValue) { response, error in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
            } else {
                if let places = response?.results() {
                    if let place = places.first {
                        UserDefaults.standard.set(place.postalCode ?? "", forKey: AppConstant.ZIPCODETWO)
                        
                    } else {
                        print("GEOCODE: nil first in places")
                    }
                } else {
                    print("GEOCODE: nil in places")
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arrofname.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RepostissueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RepostissueTableViewCell", for: indexPath) as! RepostissueTableViewCell
        
        cell.lblname.text = Arrofname[indexPath.row]
        cell.borderview.layer.borderWidth = 0.6
        cell.borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.borderview.layer.cornerRadius = 7
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            
            cell.borderview.backgroundColor = AppConstant.ViewColor
            cell.lblname.textColor = AppConstant.NormalTextColor
            cell.ArrowRight.tintColor = AppConstant.LabelColor
            cell.borderview.layer.borderColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1)
        }else if onoff == "off"{
            
        }else{
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0{
            
            if CLLocationManager.locationServicesEnabled() == true {
                if CLLocationManager.locationServicesEnabled() {
                    
                    switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        //self.locationManager.requestAlwaysAuthorization()
                        let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
                        navigate.CommercialArray = CommercialArray
                        navigate.ids = ids
                        navigate.Title = CommercialTitle
                        navigate.PlaceholderGet = "Commercial Pools"
                        self.navigationController?.pushViewController(navigate, animated: true)
                        self.locationManager.requestWhenInUseAuthorization()
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
                            let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
                            navigate.CommercialArray = CommercialArray
                            navigate.ids = ids
                            navigate.Title = CommercialTitle
                            navigate.PlaceholderGet = "Commercial Pools"
                            self.navigationController?.pushViewController(navigate, animated: true)
                            locationManager.delegate = self
                            locationManager.startUpdatingLocation()
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
            
            
        }else if indexPath.row == 1{
            
            if CLLocationManager.locationServicesEnabled() == true {
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        //self.locationManager.requestAlwaysAuthorization()
                        let navigate:DeadbirdViewController = self.storyboard?.instantiateViewController(identifier: "DeadbirdViewController") as! DeadbirdViewController
                        self.navigationController?.pushViewController(navigate, animated: true)
                        self.locationManager.requestWhenInUseAuthorization()
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
                            let navigate:DeadbirdViewController = self.storyboard?.instantiateViewController(identifier: "DeadbirdViewController") as! DeadbirdViewController
                            self.navigationController?.pushViewController(navigate, animated: true)
                            locationManager.delegate = self
                            locationManager.startUpdatingLocation()
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

            
        }else if indexPath.row == 2{
            
            if CLLocationManager.locationServicesEnabled() == true {
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        //self.locationManager.requestAlwaysAuthorization()
                        let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
                        navigate.CommercialArray = DrinkingWater
                        navigate.ids = DrinkingWaterids
                        navigate.PlaceholderGet = "Public Drinking Water"
                        navigate.Title = "Drinking Water"
                        self.navigationController?.pushViewController(navigate, animated: true)
                        self.locationManager.requestWhenInUseAuthorization()
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
                            let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
                            navigate.CommercialArray = DrinkingWater
                            navigate.ids = DrinkingWaterids
                            navigate.PlaceholderGet = "Public Drinking Water"
                            navigate.Title = "Drinking Water"
                            self.navigationController?.pushViewController(navigate, animated: true)
                            locationManager.delegate = self
                            locationManager.startUpdatingLocation()
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
            
        }

        else if indexPath.row == 3{
            
            
            if CLLocationManager.locationServicesEnabled() == true {
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        //self.locationManager.requestAlwaysAuthorization()
                        let navigate:MosquitoBreedingViewController = self.storyboard?.instantiateViewController(identifier: "MosquitoBreedingViewController") as! MosquitoBreedingViewController
                        self.navigationController?.pushViewController(navigate, animated: true)
                        self.locationManager.requestWhenInUseAuthorization()
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
                            let navigate:MosquitoBreedingViewController = self.storyboard?.instantiateViewController(identifier: "MosquitoBreedingViewController") as! MosquitoBreedingViewController
                            self.navigationController?.pushViewController(navigate, animated: true)
                            locationManager.delegate = self
                            locationManager.startUpdatingLocation()
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
            
    
            
        }else if indexPath.row == 4{
            
            
            if CLLocationManager.locationServicesEnabled() == true {
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        //self.locationManager.requestAlwaysAuthorization()
                        let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
                        navigate.CommercialArray = NeighbourArray
                        navigate.ids = Neighbourids
                        navigate.Title = NeighbourTitle
                        navigate.PlaceholderGet = "Neighborhood Nuisance"
                        self.navigationController?.pushViewController(navigate, animated: true)
                        self.locationManager.requestWhenInUseAuthorization()
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
                            let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
                            navigate.CommercialArray = NeighbourArray
                            navigate.ids = Neighbourids
                            navigate.Title = NeighbourTitle
                            navigate.PlaceholderGet = "Neighborhood Nuisance"
                            self.navigationController?.pushViewController(navigate, animated: true)
                            locationManager.delegate = self
                            locationManager.startUpdatingLocation()
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
                            let navigate:ReportanimalViewController = self.storyboard?.instantiateViewController(identifier: "ReportanimalViewController") as! ReportanimalViewController
                            self.navigationController?.pushViewController(navigate, animated: true)
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
        }
    }
    
}
