//
//  FindLocationViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 11/02/21.
//  Copyright © 2021 Skywave-Mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import MBProgressHUD
import SwiftyJSON
import Alamofire

class FindLocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var searchResultsTable: UITableView!
    @IBOutlet var searchBar: UITextField!
    
    var SearchGettwo:SearchModeltwo?
    var hud: MBProgressHUD = MBProgressHUD()
    
    var currentlat = UserDefaults.standard.string(forKey: AppConstant.CURRENTLAT)
    var currentlong = UserDefaults.standard.string(forKey: AppConstant.CURRENTLONG)
    var zipcodetwo = UserDefaults.standard.string(forKey: AppConstant.ZIPCODETWO)
    
    var latti:String!
    var Longi:String!
    var postal:String!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latti = currentlat
        Longi = currentlong
        postal = zipcodetwo
        
        self.searchBar.becomeFirstResponder()
        
        searchBar.autocapitalizationType = .sentences
        searchBar.autocapitalizationType = .words
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .dark
             }
            
            searchBar.backgroundColor = AppConstant.ViewColor
            
            searchBar.attributedPlaceholder = NSAttributedString(string: "Search",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
        }else if onoff == "off"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }else{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }
        
      
       searchBar?.delegate = self
       searchResultsTable?.delegate = self
       searchResultsTable?.dataSource = self
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
           
            
            NotificationCenter.default.post(name: Notification.Name("remove_View"), object: nil)

        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        print("Serch")
        
        if textField == searchBar{
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
                                if searchBar.text?.isEmpty == true{
                                    self.view.showToast(toastMessage: "Please enter search value", duration: 0.3)
                                }else{
                                    DispatchQueue.main.async {
                                        self.searchBar.resignFirstResponder()
                                    }
                                    SearchApicalltwo(Find: searchBar.text ?? "")
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
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchBar{
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                    case .notDetermined, .restricted, .denied:
                        print("No access")
                        DispatchQueue.main.async {
                            self.searchBar.resignFirstResponder()
                        }
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
                        let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                                    
                        let count = self.searchBar.text?.count ?? 0 + string.count
                        
                                     if count >= 2{
                                        //VPAutoDropTable.isHidden = false
                                        let when = DispatchTime.now() + 1
                                        DispatchQueue.main.asyncAfter(deadline: when){
                                            if Reachability.isConnectedToNetwork(){
                                                self.SearchApicalltwo(Find: self.searchBar.text ?? "")
                                                print("LastPin==>\(self.searchBar.text ?? "")")
                                            }else{
                                                self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
                                            }
                                            
                                        }
                                        
                                        
                                     }else if count <= 1{
                                        //VPAutoDropTable.isHidden = true
                                        print("LastPin1==>")
                                        return true
                                     }else{
                                        //VPAutoDropTable.isHidden = true
                                        print("LastPin2==>")
                                        return true
                                     }
                    @unknown default:
                    break
                }
                } else {
                    print("Location services are not enabled")
            }

    
            return true
        }else{
            return true
        }
        return true
        }
    
    func SearchApicalltwo(Find:String) {
        
//        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
//        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
//        hud.show(animated: true)
        
//        let url = URL(string:"https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(Lat ?? "")" + "&lon=" + "\(Lon ?? "")" + "&text=" + "\(Find)" + "&max=25")
        
        let URLset = "https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(latti ?? "")" + "&lon=" + "\(Longi ?? "")" + "&text=" + "\(Find)" + "&max=25"
               
               let urlString = URLset.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
               print("urlString==>\(urlString ?? "")")
               
               let url = URL(string:urlString ?? "")
               var request = URLRequest(url: url!)
               request.httpMethod = "GET"
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 
                 guard let data = data else { return }
                 do{
                     let json = try JSON(data:data)
                    
                    print("response===>\(json)")
                    let statusisSuccess = json["isSuccess"]
                    let messageTost = json["message"]
                    
                    let gettost = "\(messageTost)"
                    
                    if statusisSuccess == false{

                        DispatchQueue.main.async {
                            self.view.showToast(toastMessage: gettost, duration: 0.3)
                            //self.hud.hide(animated: true)
                            DispatchQueue.main.async {
                                self.searchBar.resignFirstResponder()
                            }
                        }
                
                    }else{
                        let decoder = JSONDecoder()
                        self.SearchGettwo = try decoder.decode(SearchModeltwo.self, from: data)
                        DispatchQueue.main.async {
                            self.searchResultsTable.reloadData()
                        }
                        
                    }
                 }catch{
                     print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                      }
                 }
                 
                 }

        task.resume()

    }

    
    @IBAction func back(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchGettwo?.data.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text =  SearchGettwo?.data[indexPath.row].establishmentName
        cell.detailTextLabel?.text = "\(SearchGettwo?.data[indexPath.row].streetNumber ?? "")" + " \(SearchGettwo?.data[indexPath.row].streetAddress ?? "")" + ", \(SearchGettwo?.data[indexPath.row].zipCode ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //let establishmentName = SearchGettwo?.data[indexPath.row].establishmentName
        let address = "\(SearchGettwo?.data[indexPath.row].establishmentName ?? "")"
//        let address = "\(SearchGettwo?.data[indexPath.row].establishmentName ?? "")" + "\(SearchGettwo?.data[indexPath.row].streetNumber ?? "")" + " \(SearchGettwo?.data[indexPath.row].streetAddress ?? "")" + " \(SearchGettwo?.data[indexPath.row].city ?? "")" + ", \(SearchGettwo?.data[indexPath.row].zipCode ?? "")" + "\(SearchGettwo?.data[indexPath.row].milesAway ?? "")" + " miles"
        let establishmentNumber = SearchGettwo?.data[indexPath.row].establishmentNumber
//        navigate.lat = Double("\(SearchGettwo?.data[indexPath.row].lat ?? "")")
//        navigate.long = Double("\(SearchGettwo?.data[indexPath.row].lon ?? "")")
//        navigate.demeritsString = SearchGettwo?.data[indexPath.row].demerits
        
    
            UserDefaults.standard.set(SearchGettwo?.data[indexPath.row].lat, forKey: AppConstant.CURRENTLAT)
            UserDefaults.standard.set(SearchGettwo?.data[indexPath.row].lon, forKey: AppConstant.CURRENTLONG)
        
            UserDefaults.standard.set(establishmentNumber, forKey: AppConstant.ESTABLISHMENTNUMBER)
            UserDefaults.standard.set(address, forKey: AppConstant.CURRENTADDRESS)
            
         
            self.dismiss(animated: true, completion: nil)
            
        }
    }

