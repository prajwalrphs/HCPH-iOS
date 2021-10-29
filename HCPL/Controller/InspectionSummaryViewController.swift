
import UIKit
import ArcGIS
import CoreLocation
import MapKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import MBProgressHUD
import SwiftyJSON
import Alamofire
import iOSDropDown

class InspectionSummaryViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate {

    
    @IBOutlet var viewdarkone: UIView!
    @IBOutlet var viewdarktwo: UIView!
    
    
    @IBOutlet var viewAddress: UIView!
    
    @IBOutlet weak var CustomMapView: GMSMapView!
    @IBOutlet var lbladdressTitle: UILabel!
    @IBOutlet var lbladdress: UILabel!
    @IBOutlet var reportanissueview: UIView!
    
    @IBOutlet var ScoreHistoryview: UIView!
    @IBOutlet var ViewReportview: UIView!
    @IBOutlet var ScoreHistoryoutlate: UIButton!
    @IBOutlet var ViewReportoutlate: UIButton!
    
    @IBOutlet var inspectionstatusoutlate: UIButton!
    @IBOutlet var currentstatusoutlate: UIButton!
    
    @IBOutlet var inspectioncurrentcollection: UICollectionView!
    
    @IBOutlet var txtdate: UITextField!
    @IBOutlet weak var mainDropDown: DropDown!
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    @IBOutlet var tableborder: UIView!
    
    @IBOutlet var inspectioncurrenttableview: UITableView!
    @IBOutlet var btndate: UIButton!
    @IBOutlet var imagepin: UIImageView!
    
    var cameraPosition = GMSCameraPosition()
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?
    
    var DateArray = [String]()
    let DateArray2 = [String]()
    var ids = [Int]()
    
    var lat:Double!
    var long:Double!
    var MarkerImage:UIImage!
    var MarkerImageTitle:String!
    
    var inspectionstatusarrayimage = [#imageLiteral(resourceName: "certifiedmanageronsite66x66_opacity"),#imageLiteral(resourceName: "citationissues66x66_opacity"),#imageLiteral(resourceName: "correctedonsite66x66_opacity"),#imageLiteral(resourceName: "complaintbased66x66_opacity"),#imageLiteral(resourceName: "foodborneillnessinvestigation66x66_opacity"),#imageLiteral(resourceName: "fooddestroyed66x66_opacity")]
    var currentstatusarrayimage = [#imageLiteral(resourceName: "closure66x66_opacity"),#imageLiteral(resourceName: "redtagissued66x66_opacity"),#imageLiteral(resourceName: "foodsafetyaward66x66_opacity"),#imageLiteral(resourceName: "redtagremoved66x66_opacity"),#imageLiteral(resourceName: "foodconferenceparticipant66x66_opacity")]
    
    var inspectionstatusarraylabel = ["Certified Manager on Site","Citation Issued","Corrected On Site","Complaint Based","Foodborne Illness Investigation","Food Destroyed"]
    var currentstatusarraylabel = ["Closure","Red Tag Issued","Food Safety Award","Red Tag Removed","Food Conference Participant"]
    
    var TitleAddress:String!
    var addressString:String!
    var demeritsString:String!
    var establishmentNumberApi:String!
    var InspectionGet:Inspection?
    var ViolationsGet:Violations?
    
//    var multipleimage = [UIImage]()
//    var multiplelabel = [String]()
    
    var inspectionstatusimagearray = [UIImage]()
    var inspectionstatuslabelarray = [String]()
    
    var currentstatusimagearray = [UIImage]()
    var currentstatuslabelarray = [String]()
    
    var CitationsIssued:String!
    var CertifiedManagers:String!
    var CorrectedOnSite:String!
    var ComplaintDriven:String!
    var FoodborneIllnesInvestigation:String!
    var Pounds_of_food_destroyed:String!
    
    var Closure:String!
    var RedTagsIssued:String!
    var FoodSafetyAward:String!
    var RedTagRemoved:String!
    var FoodConferenceParticipant:String!
        
    var CheckStatusBtn:String!
    
    var inspectionNumberLink:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CheckStatusBtn = "inspection"
        
        ShowLocation(lath: lat, Longh: long)

        
        lbladdressTitle.text = TitleAddress
        lbladdress.text = addressString
                
        inspectionstatusimagearray = inspectionstatusarrayimage
        inspectionstatuslabelarray = inspectionstatusarraylabel
        
        let origImage = #imageLiteral(resourceName: "calendar")
        let tintedImage = origImage.withRenderingMode(.alwaysTemplate)
        btndate.setImage(tintedImage, for: .normal)
        btndate.tintColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        
        imagepin.image = imagepin.image?.withRenderingMode(.alwaysTemplate)
        imagepin.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
        
        reportanissueview.layer.borderWidth = 1
        reportanissueview.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        
        ScoreHistoryview.layer.borderWidth = 1
        ScoreHistoryview.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        
        ViewReportview.layer.borderWidth = 1
        ViewReportview.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        
        tableborder.layer.borderWidth = 1
        tableborder.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        
        if Reachability.isConnectedToNetwork(){
            InspectionApicall()
        }else{
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
        
        startLocation()
        

        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
    
        if onoff == "on"{
            
            mainDropDown.rowBackgroundColor = AppConstant.ViewColor
            viewAddress.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lbladdress.textColor = AppConstant.LabelColor
            viewdarkone.backgroundColor = AppConstant.ViewColor
            viewdarktwo.backgroundColor = AppConstant.ViewColor
            
            inspectionstatusoutlate.layer.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            currentstatusoutlate.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            inspectionstatusoutlate.layer.borderWidth = 1
            inspectionstatusoutlate.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            
            currentstatusoutlate.layer.borderWidth = 1
            currentstatusoutlate.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
  
        }else if onoff == "off"{
            inspectionstatusoutlate.layer.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            currentstatusoutlate.layer.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            currentstatusoutlate.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            inspectionstatusoutlate.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }else{
            
        }
        
    }
        
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations updates = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)

    }
    
    func startLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        print("only show map")
    }
    
    func ShowLocation(lath:Double,Longh:Double){
        
       
            let camera = GMSCameraPosition.camera(withLatitude: lath, longitude: Longh, zoom: 10.0)
                CustomMapView.animate(to: camera)
            
            let sourceMarker = GMSMarker()
            
            sourceMarker.map = nil
            sourceMarker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lath), longitude: CLLocationDegrees(Longh))
            sourceMarker.icon = MarkerImage
            sourceMarker.map = self.CustomMapView
        
            print("only show map two")
                
    
    }
    
    
    func InspectionApicall() {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
        
        
        let url = URL(string:"https://apps.harriscountytx.gov/PublicHealthPortal/api/InspectionsWebCitations/id=" + "\(establishmentNumberApi ?? "")")
       // let url = URL(string:"https://apps.harriscountytx.gov/PHESNotify/api/QAPublicHealthPortal/api/InspectionsWebCitations/id=" + "\(establishmentNumberApi ?? "")")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 
                 guard let data = data else { return }
                 do{
                     let json = try JSON(data:data)
                     print("InspectionApicall==> \(json)")
                    
                    let statusisSuccess = json["isSuccess"]
                    let messageTost = json["message"]
                    let gettost = "\(messageTost)"
                                        
 
                    DispatchQueue.main.async {
                        self.inspectioncurrentcollection.reloadData()
                    }
                    
                    if statusisSuccess == false{

                        DispatchQueue.main.async {
                            self.view.showToast(toastMessage: gettost, duration: 0.3)
                            self.hud.hide(animated: true)
                        }
                
                    }else{
                        let decoder = JSONDecoder()
                        self.InspectionGet = try decoder.decode(Inspection.self, from: data)
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.inspectionNumberLink = self.InspectionGet?.data[0].inspectionNumber ?? ""
                            self.ViolationsApicall(inspectionNumber: self.InspectionGet?.data[0].inspectionNumber ?? "")
                            self.StatusApicall(inspectionNumber: self.InspectionGet?.data[0].inspectionNumber ?? "")
                          }
                        
                        for i in self.InspectionGet!.data{
                            
                            DispatchQueue.main.async {
                                
                                self.DateArray.append(i.inspectionDate)
                                let idsint = i.inspectionNumber
                                let a:Int? = Int(idsint)
                                self.ids.append(a ?? 0)
                                self.mainDropDown.selectedRowColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
                                self.mainDropDown.optionArray = self.DateArray
                                self.mainDropDown.optionIds = self.ids
                                self.mainDropDown.checkMarkEnabled = false
                                self.mainDropDown.arrowColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 0.1730781909)
                                self.txtdate.text = self.DateArray[0]
                         
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.mainDropDown.didSelect{(selectedText , index , id) in
                                print("ids==>\(id)")
                                if Reachability.isConnectedToNetwork(){
                                    self.inspectionNumberLink = "\(id)"
                                    self.ViolationsApicall(inspectionNumber: "\(id)")
                                    self.StatusApicall(inspectionNumber: "\(id)")
                                    DispatchQueue.main.async {
                                        self.inspectioncurrenttableview.reloadData()
                                      }
                                }else{
                                    self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
                                }
                            }
                          }

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
    
    func ViolationsApicall(inspectionNumber:String) {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
        
        //let url = URL(string:"https://apps.harriscountytx.gov/PHESNotify/api/QAPublicHealthPortal/api/InspectionsWeb/id=" + "\(inspectionNumber)")
        let url = URL(string:"https://apps.harriscountytx.gov/PublicHealthPortal/api/InspectionsWeb/id=" + "\(inspectionNumber)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 
                 guard let data = data else { return }
                 do{
                     let json = try JSON(data:data)
                     print("ViolationsApicall==> \(json)")
                    
                    let statusisSuccess = json["isSuccess"]
                    let messageTost = json["message"]
                    
                    let gettost = "\(messageTost)"
                    
                    print("statusisSuccess==>\(statusisSuccess)")
                    print("gettost==>\(gettost)")
                    
                    if statusisSuccess == false{

                        DispatchQueue.main.async {
                            self.view.showToast(toastMessage: gettost, duration: 0.3)
                            self.hud.hide(animated: true)
                        }
                
                    }else{
                        let decoder = JSONDecoder()
                        self.ViolationsGet = try decoder.decode(Violations.self, from: data)
                        
                        for i in self.ViolationsGet!.data{
                            
                            if i.certifiedManagers == "Yes"{
                                self.CertifiedManagers = "certifiedManagers"
                            }else{
                                self.CertifiedManagers = ""
                            }
                            
                            if i.citationsIssued == "0"{
                                self.CitationsIssued = ""
                            }else{
                                self.CitationsIssued = "citationsIssued"
                            }
                            
                            if i.correctedOnSite == "No"{
                                self.CorrectedOnSite = ""
                            }else{
                                self.CorrectedOnSite = "correctedOnSite"
                            }
                            
                            if i.complaintDriven == "No"{
                                self.ComplaintDriven = ""
                            }else{
                                self.ComplaintDriven = "complaintDriven"
                            }
                            
                            if i.foodborneIllnesInvestigation == "No"{
                                self.FoodborneIllnesInvestigation = ""
                            }else{
                                self.FoodborneIllnesInvestigation = "foodborneIllnesInvestigation"
                            }
                            
                            if i.poundsOfFoodDestroyed == "0"{
                                self.FoodborneIllnesInvestigation = ""
                            }else{
                                self.FoodborneIllnesInvestigation = "pounds_of_food_destroyed"
                            }
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.inspectioncurrentcollection.reloadData()
                            self.inspectioncurrenttableview.reloadData()
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
    
   // https://apps.harriscountytx.gov/PublicHealthPortal/Charts/
    
    func StatusApicall(inspectionNumber:String) {

        //let url = URL(string:"https://apps.harriscountytx.gov/PHESNotify/api/QAPublicHealthPortal/api/EstablishmentCurrentStatus/id=" + "\(inspectionNumber)")
        let url = URL(string:"https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentCurrentStatus/id=" + "\(inspectionNumber)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode \(httpResponse.statusCode)")
                guard let data = data else { return }
                
                if data.isEmpty{
                       DispatchQueue.main.async {
                           print("is empty")
                       }
            
                }else{
                   
                        do{
                            let json = try JSON(data:data)
                            print("StatusApicall==> \(json)")
                        
                           let statusisSuccess = json["isSuccess"]
                           let messageTost = json["message"]
                           
                           let gettost = "\(messageTost)"
                            
                            let MeinData = json["data"]
                                                
                            for (key, value) in MeinData {
                            
                                for (keyy, value) in value{
                                    
                                    print("keyykeyy==>\(keyy)")
                                    print("value==>\(value)")
                                    
                                    if keyy == "closure"{
                                        self.Closure = "closure"
                                    
                                    }else if keyy == "redTagsIssued"{
                                        self.RedTagsIssued = "redTagsIssued"
                                        
                                    }else if keyy == "foodSafetyAward"{
                                        self.FoodSafetyAward = "foodSafetyAward"
                                        
                                    }else if keyy == "redTagRemoved"{
                                        self.RedTagRemoved = "redTagRemoved"
                                       
                                    }else{
                                        self.FoodConferenceParticipant = "foodConferenceParticipant"
                                        
                                    }
                                    DispatchQueue.main.async {
                                        self.inspectioncurrentcollection.reloadData()
                                    }
                                }
                            }

                           if statusisSuccess == "false"{

                               DispatchQueue.main.async {
                                   self.view.showToast(toastMessage: gettost, duration: 0.3)
                                   self.hud.hide(animated: true)
                               }
                       
                           }else{
                            
                            
                               
                           }
                }catch{
                            print(error.localizedDescription)
                        }
                 }
                
            }
         
        }

        task.resume()

    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ReportanissueActionclick(_ sender: UIButton) {
     
        let navigate:InspectionReportIssueViewController = self.storyboard?.instantiateViewController(withIdentifier: "InspectionReportIssueViewController") as! InspectionReportIssueViewController
        navigate.lat = lat
        navigate.long = long
        navigate.MarkerImage = MarkerImage
        navigate.TitleAddress = TitleAddress
        navigate.addressString = addressString
        navigate.demeritsString = demeritsString
        self.navigationController?.pushViewController(navigate, animated: true)
    }
    
    @IBAction func ScoreHistoryaction(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork(){
            
            naviGetToBottomViewopen(url: "https://apps.harriscountytx.gov/PublicHealthPortal/Charts/" + "\(establishmentNumberApi ?? "")", title: "Score History",Check: "ScoreHistory")
        
        }else{
            
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
           
        }
        
    }
    
    @IBAction func ViewReportaction(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork(){
            
           
            naviGetToBottomViewopen(url: "https://secure.hcphes.org/InspectionReport/" + "\(inspectionNumberLink ?? "")", title: "View Report", Check: "ViewReport")
        
        }else{
            
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
           
        }
        
    }
    
    @IBAction func InspectionAction(_ sender: UIButton) {
        
                
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
    
        if onoff == "on"{
            inspectionstatusoutlate.layer.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            currentstatusoutlate.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            inspectionstatusoutlate.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            inspectionstatusoutlate.layer.borderWidth = 1
            inspectionstatusoutlate.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            
            currentstatusoutlate.layer.borderWidth = 1
            currentstatusoutlate.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        }else{
            currentstatusoutlate.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            inspectionstatusoutlate.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
        
        self.CheckStatusBtn = "inspection"
        inspectionstatusimagearray = inspectionstatusarrayimage
        inspectionstatuslabelarray = inspectionstatusarraylabel
        inspectioncurrentcollection.reloadData()
    }
    
    @IBAction func CurrentstatusAction(_ sender: UIButton) {

        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
    
        if onoff == "on"{
            inspectionstatusoutlate.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            currentstatusoutlate.layer.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            currentstatusoutlate.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            inspectionstatusoutlate.layer.borderWidth = 1
            inspectionstatusoutlate.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            
            currentstatusoutlate.layer.borderWidth = 1
            currentstatusoutlate.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        }else{
            currentstatusoutlate.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            inspectionstatusoutlate.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
        

        
        self.CheckStatusBtn = "current"
        currentstatusimagearray = currentstatusarrayimage
        currentstatuslabelarray = currentstatusarraylabel
        inspectioncurrentcollection.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViolationsGet?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:InspectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InspectionTableViewCell") as! InspectionTableViewCell
        cell.violationslbl.text = ViolationsGet?.data[indexPath.row].violationNumber
        cell.descriptionlbl.text = ViolationsGet?.data[indexPath.row].violationDescription
        cell.demeritslbl.text = ViolationsGet?.data[indexPath.row].assignedDemerits
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.CheckStatusBtn == "inspection"{
            return inspectionstatuslabelarray.count
        }else if self.CheckStatusBtn == "current"{
            return currentstatuslabelarray.count
        }else{
            return inspectionstatuslabelarray.count
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspectionCollectionViewCell", for: indexPath) as! InspectionCollectionViewCell
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
    
        if onoff == "on"{
            cell.lbltext.textColor = AppConstant.LabelWhiteColor
        }else{
            
        }
        
        if self.CheckStatusBtn == "inspection"{
            if indexPath.row == 0{
                
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.CertifiedManagers == "certifiedManagers"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = AppConstant.ViewColor
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.CertifiedManagers == "certifiedManagers"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }
                
            }else if indexPath.row == 1{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.CitationsIssued == "citationsIssued"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = AppConstant.ViewColor
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.CitationsIssued == "citationsIssued"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }

            }else if indexPath.row == 2{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.CorrectedOnSite == "correctedOnSite"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = AppConstant.ViewColor
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.CorrectedOnSite == "correctedOnSite"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }
                
            }else if indexPath.row == 3{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.ComplaintDriven == "complaintDriven"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.ComplaintDriven == "complaintDriven"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }
                
            }else if indexPath.row == 4{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.FoodborneIllnesInvestigation == "foodborneIllnesInvestigation"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.FoodborneIllnesInvestigation == "foodborneIllnesInvestigation"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }
  
            }else if indexPath.row == 5{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.Pounds_of_food_destroyed == "pounds_of_food_destroyed"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.Pounds_of_food_destroyed == "pounds_of_food_destroyed"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = inspectionstatusimagearray[indexPath.row]
                        cell.lbltext.text = inspectionstatuslabelarray[indexPath.row]
                    }
                }
                
            }
        }else if self.CheckStatusBtn == "current"{
        
           
            if indexPath.row == 0{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.Closure == "closure"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        //cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.Closure == "closure"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        //cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }
                

            }else if indexPath.row == 1{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.RedTagsIssued == "redTagsIssued"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.RedTagsIssued == "redTagsIssued"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }

            }else if indexPath.row == 2{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.FoodSafetyAward == "foodSafetyAward"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.FoodSafetyAward == "foodSafetyAward"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }
                

            }else if indexPath.row == 3{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.RedTagRemoved == "redTagRemoved"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.RedTagRemoved == "redTagRemoved"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }

            }else if indexPath.row == 4{
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
            
                if onoff == "on"{
                    if self.FoodConferenceParticipant == "foodConferenceParticipant"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }else{
                    if self.FoodConferenceParticipant == "foodConferenceParticipant"{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }else{
                        cell.Borderview.layer.borderWidth = 1
                        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
                        cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.img.image = currentstatusimagearray[indexPath.row]
                        cell.lbltext.text = currentstatuslabelarray[indexPath.row]
                    }
                }

            }
            
        }else{
            cell.Borderview.layer.borderWidth = 1
            cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
            cell.Borderview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.img.image = currentstatusimagearray[indexPath.row]
            cell.lbltext.text = currentstatuslabelarray[indexPath.row]
        }
        return cell
    }
    
    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
    
    func naviGetToBottomViewopen(url:String, title:String, Check:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        navigate.CheckCondition = Check
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
}
