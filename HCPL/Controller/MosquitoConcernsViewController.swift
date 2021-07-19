
import UIKit
import CoreLocation

class MosquitoConcernsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {

    var arrofname = ["Dead Birds","Mosquito Breeding","Disease Activity","Spray Area","Visit Our Website"]
    
    var imagearray = [#imageLiteral(resourceName: "mosq1"),#imageLiteral(resourceName: "mosq2"),#imageLiteral(resourceName: "mosq3"),#imageLiteral(resourceName: "mosq4"),#imageLiteral(resourceName: "pic6")]

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
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MosquitoConcernsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MosquitoConcernsTableViewCell", for: indexPath) as! MosquitoConcernsTableViewCell
        
        cell.lbl.text = arrofname[indexPath.row]
        cell.mainview.layer.borderWidth = 0.6
        cell.mainview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.mainview.layer.cornerRadius = 10
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            cell.mainview.backgroundColor = AppConstant.ViewColor
            cell.lbl.textColor = AppConstant.NormalTextColor
            cell.ArrowRight.tintColor = AppConstant.LabelColor
            cell.mainview.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)

        }else if onoff == "off"{
            
        }else{
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 4{
            self.naviGetTo(url: "http://publichealth.harriscountytx.gov/About/Organization-Offices/Mosquito-and-Vector-Control", title: "Website")
        }else{
            
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
                                if indexPath.row == 0{
                                    let navigate:DeadbirdViewController = self.storyboard?.instantiateViewController(identifier: "DeadbirdViewController") as! DeadbirdViewController
                                    navigate.CollectionDeadbird = "CollectionDeadbird"
                                    self.navigationController?.pushViewController(navigate, animated: true)
                                }
                                if indexPath.row == 1{
                                    let navigate:MosquitoBreedingViewController = self.storyboard?.instantiateViewController(identifier: "MosquitoBreedingViewController") as! MosquitoBreedingViewController
                                    navigate.CollectionMosquitoBreeding = "CollectionMosquitoBreeding"
                                    self.navigationController?.pushViewController(navigate, animated: true)
                                }
                                if indexPath.row == 2{
                                    let naviagte:MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                                    naviagte.TitleHead = "Disease Activity"
                                    self.navigationController?.pushViewController(naviagte, animated: true)
                                }
                                if indexPath.row == 3{
                                    let naviagte:MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                                    naviagte.TitleHead = "Spray Area"
                                    self.navigationController?.pushViewController(naviagte, animated: true)
                                }
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
             
                let alertController = UIAlertController(title: "Internet Connection", message: "Please turn on your device internet connection to continue.", preferredStyle: UIAlertController.Style.alert)
                let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
              
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
