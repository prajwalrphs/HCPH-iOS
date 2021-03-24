
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
    
    var inspectionstatusarraylabel = ["Certifield Manage on Site","Citation Issued","Corrected On Site","Complaint Based","Foodborne Illness Investigation","Food Destroyed"]
    var currentstatusarraylabel = ["Closure","Red Tag Issued","Food Safety Award","Red Tag Removed","Food Conference Participant"]
    
    var TitleAddress:String!
    var addressString:String!
    var demeritsString:String!
    var establishmentNumberApi:String!
    var InspectionGet:Inspection?
    var ViolationsGet:Violations?
    
    var multipleimage = [UIImage]()
    var multiplelabel = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShowLocation(lath: lat, Longh: long)

        
        lbladdressTitle.text = TitleAddress
        lbladdress.text = addressString
                
        multipleimage = inspectionstatusarrayimage
        multiplelabel = inspectionstatusarraylabel
        
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
        
        InspectionApicall()
        startLocation()
        
    }
        
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations updates = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
        //ShowLocationPicked(loc: locValue)
        
//        currentLocation = locations[0].coordinate
//        locationManager.stopUpdatingLocation()
//        ShowLocation()
//        locationManager.delegate = nil

    }
    
    func startLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        print("only show map")
    }
    
    func ShowLocation(lath:Double,Longh:Double){
        
       
            let camera = GMSCameraPosition.camera(withLatitude: lath, longitude: Longh, zoom: 32.0)
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
        
        let url = URL(string:"https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/InspectionsWebCitations/id=" + "\(establishmentNumberApi ?? "")")
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
                    
                    print("statusisSuccess==>\(statusisSuccess)")
                    print("gettost==>\(gettost)")
                    
                    if statusisSuccess == "false"{

                        DispatchQueue.main.async {
                            self.view.showToast(toastMessage: gettost, duration: 0.3)
                            self.hud.hide(animated: true)
                        }
                
                    }else{
                        let decoder = JSONDecoder()
                        self.InspectionGet = try decoder.decode(Inspection.self, from: data)
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.ViolationsApicall(inspectionNumber: self.InspectionGet?.data[0].inspectionNumber ?? "")
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
                                self.ViolationsApicall(inspectionNumber: "\(id)")
                                DispatchQueue.main.async {
                                    self.inspectioncurrenttableview.reloadData()
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
        
        let url = URL(string:"https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/InspectionsWeb/id=" + "\(inspectionNumber)")
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
                    
                    if statusisSuccess == "false"{

                        DispatchQueue.main.async {
                            self.view.showToast(toastMessage: gettost, duration: 0.3)
                            self.hud.hide(animated: true)
                        }
                
                    }else{
                        let decoder = JSONDecoder()
                        self.ViolationsGet = try decoder.decode(Violations.self, from: data)
                        
                        DispatchQueue.main.async {
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
    
//    func StatusApicall(inspectionNumber:String) {
//
//        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
//        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
//        hud.show(animated: true)
//
//        let url = URL(string:"https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/EstablishmentCurrentStatus/id=" + "\(inspectionNumber)")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            print("StatusApicallresponse==> \(response)")
//                 guard let data = data else { return }
//                 do{
//                     let json = try JSON(data:data)
//                     print("StatusApicall==> \(json)")
//
//                 }catch{
//                     print(error.localizedDescription)
//                    DispatchQueue.main.async {
//                        self.hud.hide(animated: true)
//                      }
//                 }
//
//                 }
//
//        task.resume()
//
//    }
    
    
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
    }
    
    @IBAction func ViewReportaction(_ sender: UIButton) {
    }
    
    @IBAction func InspectionAction(_ sender: UIButton) {

        multipleimage = inspectionstatusarrayimage
        multiplelabel = inspectionstatusarraylabel
        inspectioncurrentcollection.reloadData()
    }
    
    @IBAction func CurrentstatusAction(_ sender: UIButton) {

        multipleimage = currentstatusarrayimage
        multiplelabel = currentstatusarraylabel
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
        return multiplelabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspectionCollectionViewCell", for: indexPath) as! InspectionCollectionViewCell
    
        cell.Borderview.layer.borderWidth = 1
        cell.Borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6859012395)
        cell.img.image = multipleimage[indexPath.row]
        cell.lbltext.text = multiplelabel[indexPath.row]
        
        return cell
    }
}
