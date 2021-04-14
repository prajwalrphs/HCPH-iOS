
import UIKit
import CoreLocation
import MapKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import MBProgressHUD
import SwiftyJSON
import Alamofire

class SearchEstablishmentsViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,DropSwitch,GMSMapViewDelegate,CLLocationManagerDelegate,reportanissue,UITextFieldDelegate{

    
    @IBOutlet weak var titletext: UILabel!
    @IBOutlet weak var CustomMapView: GMSMapView!
    @IBOutlet var dropdownview: UIView!
    @IBOutlet var droptable: UITableView!
    @IBOutlet var SearchList: UITableView!
    @IBOutlet var Searchlistviewfilter: UIView!
    @IBOutlet var Searchimage: UIImageView!
    @IBOutlet var Filterimage: UIImageView!
    @IBOutlet var Listimage: UIImageView!
    @IBOutlet var txtzipnamesearch: UITextField!
    @IBOutlet var establishmentNameimagesort: UIImageView!
    @IBOutlet var milesAwayimagesort: UIImageView!
    @IBOutlet var demeritsimagesort: UIImageView!
    @IBOutlet var VPAutoDropTable: UITableView!
    @IBOutlet var bottomviewmap: UIView!
    @IBOutlet var lblmaptitle: UILabel!
    @IBOutlet var lblmapaddress: UILabel!
    @IBOutlet var lblmapmiles: UILabel!
    @IBOutlet var lblmapDemerits: UILabel!
    @IBOutlet var lblmapdate: UILabel!
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    
    @IBOutlet var GPSLocationoutlate: UIButton!
    
    var sortedArray: [String] = []
    
    var MapLat:String!
    var MapLong:String!
    var MapMarkerImage:UIImage?
    
    var parksList: Array<NSMutableDictionary>? //List of all establishments to display
    var filteredParksList: Array<NSMutableDictionary>?
    
    var currentSort = "namedown"
    var currentSort2 = "namedown"
    var currentSort3 = "namedown"
    
    var SwitchCheckon:String!
    var SwitchCheckoff:String!
    
    var CheckPlusminus = 1
    
    var SwitchTag:String!
    var hud: MBProgressHUD = MBProgressHUD()
    
    var MapModel:Maponcreate?
    var SearchGet:SearchModel?
    
    var SearchGettwo:SearchModeltwo?
    
    var ArrDropLabel = ["Assisted Living","Bakery","Bar","Caterer","Commissary","Convenience store","Daycare","Farmer's Market","Grocery Store","Hospital","Mobile Unit","Restaurant","School","Snow cone stand"]
    var ArrDropImage = [#imageLiteral(resourceName: "daycare-icon22x22"),#imageLiteral(resourceName: "bakery-icon22x22"),#imageLiteral(resourceName: "bar-icon22x22"),#imageLiteral(resourceName: "catering-icon22x22"),#imageLiteral(resourceName: "commissary-icon22x22"),#imageLiteral(resourceName: "convienent-store-icon22x22"),#imageLiteral(resourceName: "daycare-icon22x22"),#imageLiteral(resourceName: "farmers-market-icon22x22"),#imageLiteral(resourceName: "grocery-store-icon22x22"),#imageLiteral(resourceName: "hospital-icon22x22"),#imageLiteral(resourceName: "mobile-unit-icon22x22"),#imageLiteral(resourceName: "restaurant-icon22x22"),#imageLiteral(resourceName: "school-icon22x22"),#imageLiteral(resourceName: "snow-cone-icon22x22")]
        
    var TitleHead:String!
        
    let CURRENTLAT = UserDefaults.standard.double(forKey: AppConstant.CURRENTLAT)
    let CURRENTLONG = UserDefaults.standard.double(forKey: AppConstant.CURRENTLONG)
    
    let Lat = UserDefaults.standard.string(forKey: AppConstant.CURRENTLAT)
    let Lon = UserDefaults.standard.string(forKey: AppConstant.CURRENTLONG)

    var countButton = 0
    
    var establishmentNameimagesortcount = 0
    var milesAwayimagesortcount = 0
    var demeritsimagesortcount = 0
    
    var cameraPosition = GMSCameraPosition()
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?
    
    var EstablishmentNameArray = [String]()
    var StreetNumberSArray = [String]()
    var StreetAddressArray = [String]()
    var ZipCodeSArray = [String]()
    var ADDRESSARRAY = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.parksList?.removeAll()
        
        bottomviewmap.isHidden = true
        bottomviewmap.layer.cornerRadius = 3
        bottomviewmap.layer.borderWidth = 1
        bottomviewmap.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        VPAutoDropTable.isHidden = true
        establishmentNameimagesort.isHidden = true
        //milesAwayimagesort.isHidden = true
        demeritsimagesort.isHidden = true
        
        txtzipnamesearch.delegate = self
        
        txtzipnamesearch.autocapitalizationType = .sentences
        txtzipnamesearch.autocapitalizationType = .words
        
        if Reachability.isConnectedToNetwork(){
            MapOncreateApicall()
        }else{
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
        
        
        Searchimage.image = Searchimage.image?.withRenderingMode(.alwaysTemplate)
        Searchimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
        
        Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
        Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
        
        Listimage.image = Listimage.image?.withRenderingMode(.alwaysTemplate)
        Listimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
        
        dropdownview.isHidden = true
        Searchlistviewfilter.isHidden = true
        CustomMapView.delegate = self
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            self.view1.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
            self.view2.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            self.view3.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
            
            let image = UIImage(named: "gps")?.withRenderingMode(.alwaysTemplate)
            GPSLocationoutlate.setImage(image, for: .normal)
            GPSLocationoutlate.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            GPSLocationoutlate.layer.cornerRadius = 0.5 * GPSLocationoutlate.bounds.size.width
            GPSLocationoutlate.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            GPSLocationoutlate.clipsToBounds = true
            
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .dark
             }
        }else if onoff == "off"{
            let image = UIImage(named: "gps")?.withRenderingMode(.alwaysTemplate)
            GPSLocationoutlate.setImage(image, for: .normal)
            GPSLocationoutlate.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            GPSLocationoutlate.layer.cornerRadius = 0.5 * GPSLocationoutlate.bounds.size.width
            GPSLocationoutlate.clipsToBounds = true
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }else{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }
        
        self.titletext.text = TitleHead
    
        CustomMapView.isMyLocationEnabled = true
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
        
    func MapOncreateApicall() {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
        
        
//        let url = URL(string: "https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(Lat ?? "")" + "&lon=" + "\(Lon ?? "")" + "&distance=3&error=0.01")!
        
        let url = URL(string: "https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(Lat ?? "")" + "&lon=" + "\(Lon ?? "")" + "&distance=3&error=0.01")!
        
            
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 
                 guard let data = data else { return }
                 do{
                     let json = try JSON(data:data)
                     print("MapOnCreateApicall==> \(json)")
                    
                    let statusisSuccess = json["isSuccess"]
                    let messageTost = json["message"]
                    
                    let gettost = "\(messageTost)"
                    
                    print("statusisSuccess==>\(statusisSuccess)")
                    print("gettost==>\(gettost)")
                    
                    if statusisSuccess == "false"{

                        DispatchQueue.main.async {
                            self.view.showToast(toastMessage: gettost, duration: 0.3)
                            self.hud.hide(animated: true)
                        }
                
                    }else{
                        let decoder = JSONDecoder()
                        self.MapModel = try decoder.decode(Maponcreate.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtzipnamesearch{
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                    case .notDetermined, .restricted, .denied:
                        print("No access")
                        DispatchQueue.main.async {
                            self.txtzipnamesearch.resignFirstResponder()
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
                                    
                        let count = self.txtzipnamesearch.text?.count ?? 0 + string.count
                        
                                     if count >= 2{
                                        //VPAutoDropTable.isHidden = false
                                        let when = DispatchTime.now() + 2
                                        DispatchQueue.main.asyncAfter(deadline: when){
                                            if Reachability.isConnectedToNetwork(){
                                                self.SearchApicalltwo(Find: self.txtzipnamesearch.text ?? "")
                                                print("LastPin==>\(self.txtzipnamesearch.text ?? "")")
                                            }else{
                                                self.VPAutoDropTable.isHidden = true
                                                self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
                                            }
                                            
                                        }
                                     }else if count <= 1{
                                        VPAutoDropTable.isHidden = true
                                        print("LastPin1==>")
                                        return true
                                     }else{
                                        VPAutoDropTable.isHidden = true
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
        }
    
    func SearchApicalltwo(Find:String) {
        
//        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
//        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
//        hud.show(animated: true)
        
//        let url = URL(string:"https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(Lat ?? "")" + "&lon=" + "\(Lon ?? "")" + "&text=" + "\(Find)" + "&max=25")
        
        let url = URL(string:"https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(Lat ?? "")" + "&lon=" + "\(Lon ?? "")" + "&text=" + "\(Find)" + "&max=25")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 
                 guard let data = data else { return }
                 do{
                     let json = try JSON(data:data)
                    
                    print("json==>\(json)")
                                        
                    self.EstablishmentNameArray.removeAll()
                    self.StreetNumberSArray.removeAll()
                    self.StreetAddressArray.removeAll()
                    self.ZipCodeSArray.removeAll()
                    self.ADDRESSARRAY.removeAll()
                    
                    
                    let statusisSuccess = json["isSuccess"]
                    let messageTost = json["message"]
                    
                    let gettost = "\(messageTost)"
                    
                    if statusisSuccess == "false"{

                        DispatchQueue.main.async {
                            self.view.showToast(toastMessage: gettost, duration: 0.3)
                            //self.hud.hide(animated: true)
                        }
                
                    }else{
                        let decoder = JSONDecoder()
                        self.SearchGettwo = try decoder.decode(SearchModeltwo.self, from: data)
                        DispatchQueue.main.async {
                            self.VPAutoDropTable.isHidden = false
                            self.VPAutoDropTable.reloadData()
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
    
    func SearchApicall(Find:String) {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
        
//        let url = URL(string:"https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(Lat ?? "")" + "&lon=" + "\(Lon ?? "")" + "&text=" + "\(Find)" + "&max=25")
        let url = URL(string:"https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(Lat ?? "")" + "&lon=" + "\(Lon ?? "")" + "&text=" + "\(Find)" + "&max=25")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 
                 guard let data = data else { return }
                 do{
                     let json = try JSON(data:data)
                     print("SearchApicall==> \(json)")
                    
                    let statusisSuccess = json["isSuccess"]
                    let messageTost = json["message"]
                    
                    let gettost = "\(messageTost)"
                    
                    print("statusisSuccess==>\(statusisSuccess)")
                    print("gettost==>\(gettost)")
                    
                    if statusisSuccess == "false"{

                        DispatchQueue.main.async {
                            self.view.showToast(toastMessage: gettost, duration: 0.3)
                            self.hud.hide(animated: true)
                        }
                
                    }else{
                        let decoder = JSONDecoder()
                        self.SearchGet = try decoder.decode(SearchModel.self, from: data)
                        
//                        if self.sortedArray.isEmpty{
//                            print("sortedArray is empty")
//                            self.sortedArray.append("IOS Test")
//                        }else{
//                            print("sortedArray is not empty")
//                        }
                        
                    
                        DispatchQueue.main.async {
                            for i in self.SearchGet!.data{
                                if i.facilityType == "Convenience store"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "convienent-store-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Farmer's Market"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "farmers-market-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Mobile Unit"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "mobile-unit-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Hospital"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "hospital-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Bar"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "bar-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Caterer"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "catering-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Commissary"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "commissary-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Daycare Facility"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "daycare-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Restaurant"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "restaurant-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Retail with food prep"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "bar-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "Snow cone stand"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "snow-cone-icon22x22"), Miles: i.establishmentName)
                                }else if i.facilityType == "School"{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "school-icon22x22"), Miles: i.establishmentName)
                                }else{
                                    self.ShowLocationtwo(lat: Double("\(i.lat)")!, long: Double("\(i.lon)")!, MarkerImage: #imageLiteral(resourceName: "Assisted-Living-icon22x22"), Miles: i.establishmentName)
                                }
                                
                            }
                        }
                        
//                        if ((self.parksList?.isEmpty) != nil){
//                            DispatchQueue.main.async {
//                                self.hud.hide(animated: true)
//                              }
//                        }else{
                            
//                            let data: Data = try Data.init(contentsOf: NSURL(string: "https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(self.Lat ?? "")" + "&lon=" + "\(self.Lon ?? "")" + "&text=" + "\(Find)" + "&max=25")! as URL)
                            
                            let data: Data = try Data.init(contentsOf: NSURL(string: "https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + "\(self.Lat ?? "")" + "&lon=" + "\(self.Lon ?? "")" + "&text=" + "\(Find)" + "&max=25")! as URL)
                            
                            let decodedJson = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                            self.parksList = []
                            let tempEstablishmentConversionArray = decodedJson?["data"] as! [[String: Any]]
                        
                        self.parksList?.removeAll()
                        self.filteredParksList?.removeAll()
                        
                            for temp in tempEstablishmentConversionArray
                            {
                                var temp1 = temp
                                temp1["Lat"] = temp1["lat"]
                                temp1.remove(at: temp1.index(forKey: "lat")!)
                                temp1["EstablishmentName"] = temp1["establishmentName"]
                                temp1.remove(at: temp1.index(forKey: "establishmentName")!)
                                temp1["FacilityType"] = temp1["facilityType"]
                                temp1.remove(at: temp1.index(forKey: "facilityType")!)
                                temp1["EstablishmentNumber"] = temp1["establishmentNumber"]
                                temp1.remove(at: temp1.index(forKey: "establishmentNumber")!)
                                temp1["StreetNumber"] = temp1["streetNumber"]
                                temp1.remove(at: temp1.index(forKey: "streetNumber")!)
                                temp1["StreetAddress"] = temp1["streetAddress"]
                                temp1.remove(at: temp1.index(forKey: "streetAddress")!)
                                temp1["City"] = temp1["city"]
                                temp1.remove(at: temp1.index(forKey: "city")!)
                                temp1["ZipCode"] = temp1["zipCode"]
                                temp1.remove(at: temp1.index(forKey: "zipCode")!)
                                temp1["Lon"] = temp1["lon"]
                                temp1.remove(at: temp1.index(forKey: "lon")!)
                                temp1["Demerits"] = temp1["demerits"]
                                temp1.remove(at: temp1.index(forKey: "demerits")!)
                                temp1["LastInspection"] = temp1["lastInspection"]
                                temp1.remove(at: temp1.index(forKey: "lastInspection")!)
                                temp1["PermitExpireDate"] = temp1["permitExpireDate"]
                                temp1.remove(at: temp1.index(forKey: "permitExpireDate")!)
                                temp1["MilesAway"] = temp1["milesAway"]
                                temp1.remove(at: temp1.index(forKey: "milesAway")!)
                                temp1["Count"] = temp1["count"]
                                temp1.remove(at: temp1.index(forKey: "count")!)
                                for temp2 in temp1
                                {
                                    if(temp2.value is NSNull)
                                    {
                                        temp1[temp2.key] = ""
                                    }
                                }
                                
                                
                                self.parksList?.append(NSMutableDictionary(dictionary: temp1))
                                self.filteredParksList = self.parksList
                            }
                        //}
                   
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.SearchList.reloadData()
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
    
    @IBAction func ReportMapview(_ sender: UIButton) {
        let navigate:InspectionReportIssueViewController = self.storyboard?.instantiateViewController(withIdentifier: "InspectionReportIssueViewController") as! InspectionReportIssueViewController
                
        navigate.lat = Double("\(MapLat ?? "")")
        navigate.long = Double("\(MapLong ?? "")")
        navigate.MarkerImage = MapMarkerImage
        navigate.TitleAddress = lblmaptitle.text
        navigate.addressString = lblmapaddress.text
        navigate.demeritsString = lblmapDemerits.text
        self.navigationController?.pushViewController(navigate, animated: true)
    }
    
    
    @IBAction func Close(_ sender: UIButton) {
        
 
        if countButton == 1{
            dropdownview.isHidden = true
            Searchlistviewfilter.isHidden = false
 
            if SwitchCheckon == "Assisted Living ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Bakery ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Bar ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Caterer ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Commissary ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Convenience store ON"{
                Filterimage.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                //Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Daycare ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Farmer's Market ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Grocery Store ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Hospital ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Mobile Unit ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Restaurant ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "School ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if SwitchCheckon == "Snow cone stand ON"{
                Filterimage.image = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else{
                Filterimage.image = #imageLiteral(resourceName: "filter")
                Filterimage.image = Filterimage.image?.withRenderingMode(.alwaysTemplate)
                Filterimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }
            
        }else{
            dropdownview.isHidden = true
        }
        
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func GPSopen(_ sender: UIButton) {
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
                            locationManager.delegate = self
                            locationManager.startUpdatingLocation()
                            CustomMapView.isMyLocationEnabled = true
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
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
    }
    
    @IBAction func searchbutton(_ sender: UIButton) {
        
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
                            if txtzipnamesearch.text?.isEmpty == true{
                                self.view.showToast(toastMessage: "Please enter search value", duration: 0.3)
                            }else{
                                self.VPAutoDropTable.isHidden = true
                                DispatchQueue.main.async {
                                    self.txtzipnamesearch.resignFirstResponder()
                                }
                                SearchApicall(Find: txtzipnamesearch.text ?? "")
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
    
    @IBAction func filter(_ sender: UIButton) {
        bottomviewmap.isHidden = true
        dropdownview.isHidden = false 
    }
    
    @IBAction func Listviewbutton(_ sender: UIButton) {

        bottomviewmap.isHidden = true
        if countButton == 0{
            Listimage.image = #imageLiteral(resourceName: "pin")
            Listimage.image = Listimage.image?.withRenderingMode(.alwaysTemplate)
            Listimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            Searchlistviewfilter.isHidden = false
            countButton = 1
        }else if countButton == 1{
            Listimage.image = #imageLiteral(resourceName: "listviewicon")
            Listimage.image = Listimage.image?.withRenderingMode(.alwaysTemplate)
            Listimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            Searchlistviewfilter.isHidden = true
            VPAutoDropTable.isHidden = true
            countButton = 0
            
        }
  
    }

    @IBAction func establishmentNameSort(_ sender: UIButton) {
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
            
        if(currentSort == "namedown")
        {
            if onoff == "on"{
                self.view1.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                self.view2.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
                self.view3.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
            }else if onoff == "off"{
                
            }
            
            establishmentNameimagesort.isHidden = false
            milesAwayimagesort.isHidden = true
            demeritsimagesort.isHidden = true
            let image1 = UIImage(systemName: "chevron.up")
            establishmentNameimagesort.image = image1
            currentSort = "nameup"
            
            filteredParksList?.sort(){
                item1, item2 in
                let date1 = item1["EstablishmentName"] as! String
                let date2 = item2["EstablishmentName"] as! String

                return date1.lowercased() > date2.lowercased()

            }

            DispatchQueue.main.async {
                self.SearchList.reloadData()
            }
            
        }
        else
        {
            if onoff == "on"{
                self.view1.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                self.view2.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
                self.view3.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
            }else if onoff == "off"{
                
            }
            
            let image1 = UIImage(systemName: "chevron.down")
            establishmentNameimagesort.image = image1
            currentSort = "namedown"
            
            filteredParksList?.sort(){
                item1, item2 in
                let date1 = item1["EstablishmentName"] as! String
                let date2 = item2["EstablishmentName"] as! String

                return date1.lowercased() < date2.lowercased()

            }

            DispatchQueue.main.async {
                self.SearchList.reloadData()
            }
        }
                
    }
    
    @IBAction func milesAwaysort(_ sender: UIButton) {
                
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        
        if(currentSort2 == "namedown")
        {
            if onoff == "on"{
                self.view1.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
                self.view2.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                self.view3.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
            }else if onoff == "off"{
                
            }
            
            establishmentNameimagesort.isHidden = true
            milesAwayimagesort.isHidden = false
            demeritsimagesort.isHidden = true
            let image1 = UIImage(systemName: "chevron.up")
            milesAwayimagesort.image = image1
            currentSort2 = "nameup"
            
            filteredParksList?.sort(){
                item1, item2 in
                let date1 = item1["MilesAway"] as! String
                let date2 = item2["MilesAway"] as! String

                return date1.lowercased() > date2.lowercased()

            }

            DispatchQueue.main.async {
                self.SearchList.reloadData()
            }
        }
        else
        {
            if onoff == "on"{
                self.view1.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
                self.view2.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                self.view3.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
            }else if onoff == "off"{
                
            }
            
            let image1 = UIImage(systemName: "chevron.down")
            milesAwayimagesort.image = image1
            currentSort2 = "namedown"
            
            filteredParksList?.sort(){
                item1, item2 in
                let date1 = item1["MilesAway"] as! String
                let date2 = item2["MilesAway"] as! String

                return date1.lowercased() < date2.lowercased()

            }

            DispatchQueue.main.async {
                self.SearchList.reloadData()
            }
        }
    
    }
    
    @IBAction func demeritssort(_ sender: UIButton) {
                
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        
        if(currentSort3 == "namedown")
        {
            if onoff == "on"{
                self.view1.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
                self.view2.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
                self.view3.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if onoff == "off"{
                
            }
            
            establishmentNameimagesort.isHidden = true
            milesAwayimagesort.isHidden = true
            demeritsimagesort.isHidden = false
            let image1 = UIImage(systemName: "chevron.up")
            demeritsimagesort.image = image1
            currentSort3 = "nameup"
            
            filteredParksList?.sort(){
                item1, item2 in
                let date1 = item1["Demerits"] as! NSString
                let date2 = item2["Demerits"] as! NSString

                return date1.doubleValue > date2.doubleValue

            }

            DispatchQueue.main.async {
                self.SearchList.reloadData()
            }
        }
        else
        {
            if onoff == "on"{
                self.view1.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
                self.view2.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3725490196, blue: 0.4666666667, alpha: 1)
                self.view3.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            }else if onoff == "off"{
                
            }
            
            let image1 = UIImage(systemName: "chevron.down")
            demeritsimagesort.image = image1
            currentSort3 = "namedown"
            
            filteredParksList?.sort(){
                item1, item2 in
                let date1 = item1["Demerits"] as! NSString
                let date2 = item2["Demerits"] as! NSString

                return date1.doubleValue < date2.doubleValue

            }

            DispatchQueue.main.async {
                self.SearchList.reloadData()
            }
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations updates = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
        //ShowLocationPicked(loc: locValue)
        
        currentLocation = locations[0].coordinate
        locationManager.stopUpdatingLocation()
        ShowLocation()
        locationManager.delegate = nil

    }
    
    func startLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        print("only show map")
    }
    
    func ShowLocation(){
        
        if currentLocation == nil{
            print("only show map")
        }else{
            let camera = GMSCameraPosition.camera(withLatitude: currentLocation!.latitude, longitude: currentLocation!.longitude, zoom: 15.0)
                CustomMapView.animate(to: camera)
            
            let sourceMarker = GMSMarker()
            
            sourceMarker.map = nil
            sourceMarker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(currentLocation!.latitude), longitude: CLLocationDegrees(currentLocation!.longitude))
            sourceMarker.icon = #imageLiteral(resourceName: "mappin")
            sourceMarker.map = self.CustomMapView
//            sourceMarker.snippet = "Current_Location"
//            sourceMarker.title = "Current_Location"
        
            print("only show map two")
                
        }
    
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.VPAutoDropTable.isHidden = true
        self.bottomviewmap.isHidden = true
    }
   
    func ShowLocationtwo(lat: Double,long: Double,MarkerImage: UIImage,Miles: String)  {
        
        let latDouble = lat
        let longDouble = long
        let marker = GMSMarker()
        marker.map = self.CustomMapView
        //marker.iconView?.tag = index
        marker.icon = MarkerImage
        marker.position = CLLocationCoordinate2DMake(latDouble,longDouble)
        marker.title = Miles
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        CustomMapView.animate(to: camera)
        //self.view.addSubview(self.viewMap)
        self.CustomMapView.delegate = self

   }
    
 
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("didTapmarker==>\(marker.title ?? "")")
        
        if ((marker.title?.isEmpty) != nil){
            print("isEmpty")
            for i in SearchGet!.data{
                if i.establishmentName == marker.title{
                    self.bottomviewmap.isHidden = false
                    self.lblmaptitle.text = "\(i.establishmentName)"
                    self.lblmapaddress.text = "\(i.streetNumber)" + " \(i.streetAddress)" + " \(i.city)" + ", \(i.establishmentNumber)"
                    self.lblmapmiles.text = "\(i.milesAway)" + "Miles"
                    self.lblmapDemerits.text = "\(i.demerits)"
                    self.lblmapdate.text = "\(convertToString(dateString: i.lastInspection, formatIn: "M/dd/yyyy hh:mm:ss a", formatOut: "MM/dd/yyyy"))"
                    self.MapLat = "\(i.lat)"
                    self.MapLong = "\(i.lon)"
                    
                    if i.facilityType == "Convenience store"{
                        MapMarkerImage = #imageLiteral(resourceName: "convienent-store-icon22x22")
                    }else if i.facilityType == "Farmer's Market"{
                        MapMarkerImage = #imageLiteral(resourceName: "farmers-market-icon22x22")
                    }else if i.facilityType == "Mobile Unit"{
                        MapMarkerImage = #imageLiteral(resourceName: "mobile-unit-icon22x22")
                    }else if i.facilityType == "Hospital"{
                        MapMarkerImage = #imageLiteral(resourceName: "hospital-icon22x22")
                    }else if i.facilityType == "Bar"{
                        MapMarkerImage = #imageLiteral(resourceName: "bar-icon22x22")
                    }else if i.facilityType == "Caterer"{
                        MapMarkerImage = #imageLiteral(resourceName: "catering-icon22x22")
                    }else if i.facilityType == "Commissary"{
                        MapMarkerImage = #imageLiteral(resourceName: "commissary-icon22x22")
                    }else if i.facilityType == "Daycare Facility"{
                        MapMarkerImage = #imageLiteral(resourceName: "daycare-icon22x22")
                    }else if i.facilityType == "Restaurant"{
                        MapMarkerImage = #imageLiteral(resourceName: "restaurant-icon22x22")
                    }else if i.facilityType == "Retail with food prep"{
                        MapMarkerImage = #imageLiteral(resourceName: "bar-icon22x22")
                    }else if i.facilityType == "Snow cone stand"{
                        MapMarkerImage = #imageLiteral(resourceName: "snow-cone-icon22x22")
                    }else if i.facilityType == "School"{
                        MapMarkerImage = #imageLiteral(resourceName: "school-icon22x22")
                    }else{
                        MapMarkerImage = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                    }
                    
                }else{
                    print("Not get ==>")
                }
            }
            
        }else{
            print("isEmpty not")

        }
     

            
        return true
    }
    
    func SwitchisDrop(cell: DropDownTableViewCell) {
        
        let indexPath = self.droptable.indexPath(for: cell)

        let idget = ArrDropLabel[indexPath!.row]
                    
        SwitchTag = String(idget)
                                        
        cell.OptionSwitch.tag = Int(SwitchTag.count)
               
        if cell.OptionSwitch.tag == Int(SwitchTag.count){
            
            if cell.OptionSwitch.isOn{
                
                if SwitchTag == "Assisted Living"{
                
                    self.SwitchCheckon = "Assisted Living OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Assisted Living"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Bakery"{
                    

                    self.SwitchCheckoff = "Bakery OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Bakery"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Bar"{
                    
                    self.SwitchCheckoff = "Bar OFF"
 
            
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Bar"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Caterer"{
                    

                    self.SwitchCheckon = "Caterer OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Caterer"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Commissary"{
                                        

                    self.SwitchCheckon = "Commissary OFF"
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Commissary"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Convenience store"{
                    

                    self.SwitchCheckon = "Convenience store OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Convenience store"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    

                }else if SwitchTag == "Daycare"{
                

                    self.SwitchCheckon = "Daycare OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Daycare"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Farmer's Market"{
                                        

                    self.SwitchCheckon = "Farmer's Market OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Farmer's Market"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Grocery Store"{
                                        

                    self.SwitchCheckon = "Grocery Store OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Grocery Store"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Hospital"{
                                      

                    self.SwitchCheckon = "Hospital OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Hospital"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Mobile Unit"{
            

                    self.SwitchCheckon = "Mobile Unit OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Mobile Unit"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }

                }else if SwitchTag == "Restaurant"{
                    

                    self.SwitchCheckon = "Restaurant OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Restaurant"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "School"{
                    
 
                    self.SwitchCheckon = "School OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "School"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                    
                }else if SwitchTag == "Snow cone stand"{
                    
                    self.SwitchCheckon = "Snow cone stand OFF"
                    
                    let CheckDicObject = parksList?.filter{ ($0["FacilityType"] as! String) == "Snow cone stand"}
                    
                    if CheckDicObject != nil{
                        for d in CheckDicObject!{
                            self.filteredParksList?.append(d)
                        }
                        DispatchQueue.main.async {
                            self.SearchList.reloadData()
                        }
                    }else{
                        print("is nil")
                    }
                                    
                }
            }else{
                
                if SwitchTag == "Assisted Living"{

                    self.SwitchCheckon = "Assisted Living ON"
                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Assisted Living"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Bakery"{
                    
                    //self.SwitchCheckoff = "Bakery OFF"
                    self.SwitchCheckon = "Bakery ON"
                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Bakery"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Bar"{
            
                    //self.SwitchCheckoff = "Bar OFF"
                    self.SwitchCheckon = "Bar ON"
                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Bar"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Caterer"{
                    
                    //self.SwitchCheckoff = "Caterer OFF"
                    self.SwitchCheckon = "Caterer ON"
                    
                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Caterer"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Commissary"{
                    
                    //self.SwitchCheckoff = "Commissary OFF"
                    self.SwitchCheckon = "Commissary ON"
                    
                   
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Commissary"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Convenience store"{
                    
                    //self.SwitchCheckoff = "Convenience store OFF"
                    self.SwitchCheckon = "Convenience store ON"
                    
                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Convenience store"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Daycare"{
                    
                    //self.SwitchCheckoff = "Daycare OFF"
                    self.SwitchCheckon = "Daycare ON"
                    
                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Daycare"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Farmer's Market"{
                    
                    //self.SwitchCheckoff = "Farmer's Market OFF"
                    self.SwitchCheckon = "Farmer's Market ON"
                    
                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Farmer's Market"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Grocery Store"{
                    
                    //self.SwitchCheckoff = "Grocery Store OFF"
                    self.SwitchCheckon = "Grocery Store ON"
                    
  
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Grocery Store"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Hospital"{
                    
                    //self.SwitchCheckoff = "Hospital OFF"
                    self.SwitchCheckon = "Hospital ON"
                    

                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Hospital"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Mobile Unit"{
                    
                    //self.SwitchCheckoff = "Mobile Unit OFF"
                    self.SwitchCheckon = "Mobile Unit ON"
                    
 
                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Mobile Unit"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Restaurant"{
                    
                    //self.SwitchCheckoff = "Restaurant OFF"
                    self.SwitchCheckon = "Restaurant ON"
                    

                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Restaurant"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "School"{
                    
                    //self.SwitchCheckoff = "School OFF"
                    self.SwitchCheckon = "School ON"
                    

                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "School"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }else if SwitchTag == "Snow cone stand"{
                    
                    //self.SwitchCheckoff = "Snow cone stand OFF"
                    self.SwitchCheckon = "Snow cone stand ON"
                    
                    
                    filteredParksList = filteredParksList?.filter{ ($0["FacilityType"] as! String) != "Snow cone stand"}
 
                    DispatchQueue.main.async {
                        self.SearchList.reloadData()
                    }
                    
                }
            }
        }
        
    }
    
    func btnidTappedreportanissue(cell: SearchlistingTableViewCell) {
        
        let indexPath = self.SearchList.indexPath(for: cell)
        
        let park = filteredParksList?[indexPath?.row ?? 0]
        print("indexPath==>\(indexPath?.row ?? 0)")
        
        let navigate:InspectionReportIssueViewController = self.storyboard?.instantiateViewController(withIdentifier: "InspectionReportIssueViewController") as! InspectionReportIssueViewController
                
        navigate.lat = Double("\(park?["Lat"] as! String)")
        navigate.long = Double("\(park?["Lon"] as! String)")
        navigate.TitleAddress = "\(park?["EstablishmentName"] as! String)"
        navigate.addressString = "\(park?["StreetNumber"] as! String)" + " \(park?["StreetAddress"] as! String)" + " \(park?["City"] as! String)" + ", \(park?["ZipCode"] as! String)" + " \(park?["MilesAway"] as! String)" + " miles"
        navigate.demeritsString = "\(park?["Demerits"] as! String)"
        
        if "\(park?["FacilityType"] as! String)" == "Convenience store"{
            navigate.MarkerImage = #imageLiteral(resourceName: "convienent-store-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Farmer's Market"{
            navigate.MarkerImage = #imageLiteral(resourceName: "farmers-market-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Mobile Unit"{
            navigate.MarkerImage = #imageLiteral(resourceName: "mobile-unit-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Hospital"{
            navigate.MarkerImage = #imageLiteral(resourceName: "hospital-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Bar"{
            navigate.MarkerImage = #imageLiteral(resourceName: "bar-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Caterer"{
            navigate.MarkerImage = #imageLiteral(resourceName: "catering-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Commissary"{
            navigate.MarkerImage = #imageLiteral(resourceName: "commissary-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Daycare Facility"{
            navigate.MarkerImage = #imageLiteral(resourceName: "daycare-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Restaurant"{
            navigate.MarkerImage = #imageLiteral(resourceName: "restaurant-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Retail with food prep"{
            navigate.MarkerImage = #imageLiteral(resourceName: "bar-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "Snow cone stand"{
            navigate.MarkerImage = #imageLiteral(resourceName: "snow-cone-icon22x22")
        }else if "\(park?["FacilityType"] as! String)" == "School"{
            navigate.MarkerImage = #imageLiteral(resourceName: "school-icon22x22")
        }else{
            navigate.MarkerImage = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
        }
        
        self.navigationController?.pushViewController(navigate, animated: true)

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == droptable{
            return ArrDropLabel.count
        }else if tableView == VPAutoDropTable{
            return SearchGettwo?.data.count ?? 0
        }else{
            return filteredParksList?.count ?? 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == droptable{
            let cell:DropDownTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell") as! DropDownTableViewCell
            cell.lbl.text = ArrDropLabel[indexPath.row]
            cell.img.image = ArrDropImage[indexPath.row]
            //cell.OptionSwitch.isOn = true
            cell.DropSwitchisOn = self
            SwitchTag = ArrDropLabel[indexPath.row]
            
            return cell
        }else if tableView == VPAutoDropTable{
       
            let cell:vpSearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "vpSearchTableViewCell") as! vpSearchTableViewCell
            cell.lblTitle.text = SearchGettwo?.data[indexPath.row].establishmentName
            cell.secondtitle.text = "\(SearchGettwo?.data[indexPath.row].streetNumber ?? "")" + " \(SearchGettwo?.data[indexPath.row].streetAddress ?? "")" + ", \(SearchGettwo?.data[indexPath.row].zipCode ?? "")"
            return cell
            
        }else{
                        
            let cell:SearchlistingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchlistingTableViewCell") as! SearchlistingTableViewCell
            let park = filteredParksList?[indexPath.row]
            cell.buttonimage.image = cell.buttonimage.image?.withRenderingMode(.alwaysTemplate)
            cell.buttonimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            cell.buttonview.layer.borderWidth = 1
            cell.buttonview.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            cell.delegatereportanissue = self
            
//            cell.lbltitle.text = SearchGet?.data[indexPath.row].establishmentName
//            cell.lblyork.text = "\(SearchGet?.data[indexPath.row].streetNumber ?? "")" + " \(SearchGet?.data[indexPath.row].streetAddress ?? "")"
//            cell.lblkaty.text = "\(SearchGet?.data[indexPath.row].city ?? "")" + " \(SearchGet?.data[indexPath.row].zipCode ?? "")"
//            cell.lblmiles.text = "\(SearchGet?.data[indexPath.row].milesAway ?? "")" + " miles"
//            cell.lblDemerits.text = SearchGet?.data[indexPath.row].demerits
//            cell.lbldate.text = convertToString(dateString: SearchGet?.data[indexPath.row].lastInspection ?? "", formatIn: "M/dd/yyyy hh:mm:ss a", formatOut: "MM/dd/yyyy")
            

            cell.lbltitle.text = (park?["EstablishmentName"] as! String)
            cell.lblyork.text = "\(park?["StreetNumber"] as! String)" + " \(park?["StreetAddress"] as! String)"
            cell.lblkaty.text = "\(park?["City"] as! String)" + " \(park?["ZipCode"] as! String)"
            cell.lblmiles.text = "\(park?["MilesAway"] as! String)"
            cell.lblDemerits.text = "\(park?["Demerits"] as! String)"
            cell.lbldate.text = convertToString(dateString:"\(park?["LastInspection"] as! String)", formatIn: "M/dd/yyyy hh:mm:ss a", formatOut: "MM/dd/yyyy")
            
            let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
            print("onoff==>\(onoff ?? "")")
            
            if onoff == "on"{
                
                cell.borderview.backgroundColor = AppConstant.ViewColor
               
                cell.lbltitle.textColor = AppConstant.LabelColor
                cell.lblyork.textColor = AppConstant.LabelColor
                cell.lblkaty.textColor = AppConstant.LabelColor
                cell.lblmiles.textColor = AppConstant.LabelColor
                cell.lblDemerits.textColor = AppConstant.LabelColor
                cell.lbldate.textColor = AppConstant.LabelColor
               
            }else if onoff == "off"{
                
            }
            
            return cell
        }
        
    }
    
    func convertToString (dateString: String, formatIn : String, formatOut : String) -> String {

       let dateFormater = DateFormatter()
        dateFormater.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
       dateFormater.dateFormat = formatIn
       let date = dateFormater.date(from: dateString)

       dateFormater.timeZone = NSTimeZone.system

       dateFormater.dateFormat = formatOut
       let timeStr = dateFormater.string(from: date!)
       return timeStr
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == droptable{
            print(" droptable Select==>\(indexPath.row)")
        }else if tableView == VPAutoDropTable{
 
            let navigate:InspectionSummaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "InspectionSummaryViewController") as! InspectionSummaryViewController

            navigate.TitleAddress = SearchGettwo?.data[indexPath.row].establishmentName
            navigate.addressString = "\(SearchGettwo?.data[indexPath.row].streetNumber ?? "")" + " \(SearchGettwo?.data[indexPath.row].streetAddress ?? "")" + " \(SearchGettwo?.data[indexPath.row].city ?? "")" + ", \(SearchGettwo?.data[indexPath.row].zipCode ?? "")" + "\(SearchGettwo?.data[indexPath.row].milesAway ?? "")" + " miles"
            navigate.establishmentNumberApi = SearchGettwo?.data[indexPath.row].establishmentNumber
            navigate.lat = Double("\(SearchGettwo?.data[indexPath.row].lat ?? "")")
            navigate.long = Double("\(SearchGettwo?.data[indexPath.row].lon ?? "")")
            navigate.demeritsString = SearchGettwo?.data[indexPath.row].demerits
            
                if SearchGettwo?.data[indexPath.row].facilityType == "Convenience store"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "convienent-store-icon22x22")
                    navigate.MarkerImageTitle = "Convenience store"
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Farmer's Market"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "farmers-market-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Mobile Unit"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "mobile-unit-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Hospital"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "hospital-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Bar"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "bar-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Caterer"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "catering-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Commissary"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "commissary-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Daycare Facility"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "daycare-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Restaurant"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "restaurant-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Retail with food prep"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "bar-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "Snow cone stand"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "snow-cone-icon22x22")
                }else if SearchGettwo?.data[indexPath.row].facilityType == "School"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "school-icon22x22")
                }else{
                    navigate.MarkerImage = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                }
                
            self.navigationController?.pushViewController(navigate, animated: true)
            
        }else{
            
            let park = filteredParksList?[indexPath.row]
            
            let navigate:InspectionSummaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "InspectionSummaryViewController") as! InspectionSummaryViewController

            navigate.TitleAddress = "\(park?["EstablishmentName"] as! String)"
            navigate.addressString = "\(park?["StreetNumber"] as! String)" + " \(park?["StreetAddress"] as! String)" + " \(park?["City"] as! String)" + ", \(park?["ZipCode"] as! String)" + " \(park?["MilesAway"] as! String)" + " miles"
            navigate.establishmentNumberApi = "\(park?["EstablishmentNumber"] as! String)"
            navigate.lat = Double("\(park?["Lat"] as! String)")
            navigate.long = Double("\(park?["Lon"] as! String)")
            navigate.demeritsString = "\(park?["Demerits"] as! String)"
            
    
            
                if "\(park?["FacilityType"] as! String)" == "Convenience store"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "convienent-store-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Farmer's Market"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "farmers-market-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Mobile Unit"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "mobile-unit-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Hospital"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "hospital-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Bar"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "bar-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Caterer"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "catering-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Commissary"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "commissary-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Daycare Facility"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "daycare-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Restaurant"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "restaurant-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Retail with food prep"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "bar-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "Snow cone stand"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "snow-cone-icon22x22")
                }else if "\(park?["FacilityType"] as! String)" == "School"{
                    navigate.MarkerImage = #imageLiteral(resourceName: "school-icon22x22")
                }else{
                    navigate.MarkerImage = #imageLiteral(resourceName: "Assisted-Living-icon22x22")
                }
                
            self.navigationController?.pushViewController(navigate, animated: true)
        }
    }
    
}

