
import UIKit
import iOSDropDown
import MBProgressHUD
import SwiftyJSON
import Alamofire
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import CoreLocation
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class CommercialPoolsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,CLLocationManagerDelegate {
  

    var images: [Image] = []
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    var CommercialPools:CommercialPoolsWelcome?
    
    var BackgroundPools:BackgroundApicall?
    
    //var ZIPCode:String?
    
    let imagePicker = UIImagePickerController()
    var establishmentNumber:String?
    
    var CheckMB = [Int]()
    
    @IBOutlet weak var Statetxt: UITextField!
    @IBOutlet weak var mainDropDown: DropDown!
    @IBOutlet weak var txtnameaddress: UITextField!
    @IBOutlet weak var txtemailaddress: UITextField!
    @IBOutlet weak var txtfirstname: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var txtcontactnumber: UITextField!
    @IBOutlet weak var viewdescription: UIView!
    @IBOutlet weak var LimitLabel: UILabel!
    
    @IBOutlet var viewone: UIView!
    @IBOutlet var viewtwo: UIView!
    @IBOutlet var viewthree: UIView!
    @IBOutlet var viewfour: UIView!
    @IBOutlet var viewfive: UIView!
    
    
    @IBOutlet var yourImageView: UIImageView!
    
    @IBOutlet weak var txtdescription: UITextView!
    @IBOutlet weak var viewaddimage: UIView!
    @IBOutlet weak var imagecollection: UICollectionView!
    @IBOutlet weak var addimage: UIButton!
    @IBOutlet weak var submitoutlate: UIButton!
    @IBOutlet weak var lbltitle: UILabel!
    
    
    var ImageBytesone = String()
    var ImageBytestwo = String()
    var ImageBytesthree = String()
    var ImageBytesfour = String()
    var ImageBytesfive = String()
    
    var bytes = Array<UInt8>()
    
    var CommercialArray = [String]()
    var arrayimage = [String]()
    var ids = [Int]()
    var Title:String!
    var PlaceholderGet:String!
    
//    var LatitudeString:String!
//    var LongitudeString:String!
    let locationManager = CLLocationManager()
    
    var currentlat = UserDefaults.standard.string(forKey: AppConstant.CURRENTLAT)
    var currentlong = UserDefaults.standard.string(forKey: AppConstant.CURRENTLONG)
    var zipcodetwo = UserDefaults.standard.string(forKey: AppConstant.ZIPCODETWO)
    
    var latti:String!
    var Longi:String!
    var postal:String!
    
    //var Establishmentnumber:String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latti = currentlat
        Longi = currentlong
        postal = zipcodetwo
        
//        if Reachability.isConnectedToNetwork(){
//            self.BackgroundApiCallApicall(Find: postal)
//        }else{
//            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
//        }
        
        CheckMB.removeAll()
        arrayimage.removeAll()
        
        self.viewaddimage.layer.cornerRadius = 5
        self.viewaddimage.layer.borderWidth = 1
        self.viewaddimage.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.viewaddimage.clipsToBounds = true

        self.viewdescription.layer.cornerRadius = 5
        self.viewdescription.layer.borderWidth = 1
        self.viewdescription.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.viewdescription.clipsToBounds = true
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{

            mainDropDown.rowBackgroundColor = AppConstant.ViewColor
            
            self.viewaddimage.layer.cornerRadius = 5
            self.viewaddimage.layer.borderWidth = 1
            self.viewaddimage.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            self.viewaddimage.clipsToBounds = true
            
            self.viewdescription.layer.cornerRadius = 5
            self.viewdescription.layer.borderWidth = 1
            self.viewdescription.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            self.viewdescription.clipsToBounds = true
            
            self.viewone.backgroundColor = AppConstant.LabelWhiteColor
            self.viewtwo.backgroundColor = AppConstant.LabelWhiteColor
            self.viewthree.backgroundColor = AppConstant.LabelWhiteColor
            self.viewfour.backgroundColor = AppConstant.LabelWhiteColor
            self.viewfive.backgroundColor = AppConstant.LabelWhiteColor
            
            
            Statetxt.attributedPlaceholder = NSAttributedString(string: "Commercial Pools",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtnameaddress.attributedPlaceholder = NSAttributedString(string: "Search by Name Address or Zip*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtemailaddress.attributedPlaceholder = NSAttributedString(string: "Email Address (optional)",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtfirstname.attributedPlaceholder = NSAttributedString(string: "First Name*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtlastname.attributedPlaceholder = NSAttributedString(string: "Last Name*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtcontactnumber.attributedPlaceholder = NSAttributedString(string: "Contact Number*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            
        }else if onoff == "off"{
            
        }else{
            
        }
        
  
        txtfirstname.autocapitalizationType = .sentences
        txtfirstname.autocapitalizationType = .words
        
        txtlastname.autocapitalizationType = .sentences
        txtlastname.autocapitalizationType = .words
        
        
//        txtdescription.autocapitalizationType = .sentences
//        txtdescription.autocapitalizationType = .words
        txtdescription.text = "Please describe the complaint in as much detail as possible, including: date, time, address(if not already entered), and any other information that will help our investigation."
        txtdescription.textColor = UIColor.lightGray
        //txtdescription.autocapitalizationType = .allCharacters
        
        
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

        
        self.txtnameaddress.delegate = self
        txtcontactnumber.delegate = self
        txtemailaddress.delegate = self
        txtfirstname.delegate = self
        txtlastname.delegate = self
        self.hideKeyboardTappedAround()
        
        //self.updateCharacterCount()
        
        self.lbltitle.text = Title

        mainDropDown.selectedRowColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        mainDropDown.optionArray = CommercialArray
        mainDropDown.optionIds = ids
        mainDropDown.checkMarkEnabled = false
        
        txtdescription.delegate = self
        
        if Title == "Food Safety"{
            Statetxt.placeholder = PlaceholderGet
            let placeholder = NSMutableAttributedString(
                string: PlaceholderGet,
                attributes: [.font: UIFont(name: "Helvetica", size: 15.0)!,
                             .foregroundColor: #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
                             ])
            Statetxt.attributedPlaceholder = placeholder
            
            
            mainDropDown.didSelect{(selectedText , index , id) in
                self.Statetxt.text = selectedText
            }
        }else{
            Statetxt.text = CommercialArray[0]
            Statetxt.placeholder = PlaceholderGet
            let placeholder = NSMutableAttributedString(
                string: PlaceholderGet,
                attributes: [.font: UIFont(name: "Helvetica", size: 15.0)!,
                             .foregroundColor: #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
                             ])
            Statetxt.attributedPlaceholder = placeholder
            Statetxt.textColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            
            mainDropDown.didSelect{(selectedText , index , id) in
                self.Statetxt.text = selectedText
            }
        }
        

        
        self.submitoutlate.layer.cornerRadius = 25
        
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
       
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(locValue) { response, error in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
            } else {
                if let places = response?.results() {
                    if let place = places.first {
                       // print(place.lines)
//                        print("GEOCODE: Formatted postalCode: \(place.postalCode ?? "")")
//                        print("GEOCODE: Formatted locality: \(place.locality ?? "")")
//                        print("GEOCODE: Formatted subLocality: \(place.subLocality ?? "")")
//                        print("GEOCODE: Formatted administrativeArea: \(place.administrativeArea ?? "")")
//                        print("GEOCODE: Formatted country: \(place.country ?? "")")
//
                       
                    } else {
                        print("GEOCODE: nil first in places")
                    }
                } else {
                    print("GEOCODE: nil in places")
                }
            }
        }
        
        
    }
    
    var MAX_LENGHTPhone = 10
    func Phonelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTPhone {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTPhone))
            return
        }
    }
    
    var MAX_LENGHTEmail = 110
    func Emaillenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTEmail {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTEmail))
            return
        }
    }
    
    var MAX_LENGHTFirstname = 110
    func Firstnamelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTFirstname {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTFirstname))
            return
        }
    }
    
    var MAX_LENGHTLastname = 110
    func Lastnamelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTLastname {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTLastname))
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtcontactnumber{
            let MAX_LENGTH = 10
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtemailaddress{
            let MAX_LENGTH = 110
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtfirstname{
            let MAX_LENGTH = 110
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtlastname{
            let MAX_LENGTH = 110
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else{
            return true
        }
        
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtnameaddress {
            
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
                                let controller = storyboard?.instantiateViewController(withIdentifier: "FindLocationViewController") as! FindLocationViewController
                                controller.modalPresentationStyle = .pageSheet
                                controller.modalTransitionStyle = .coverVertical
                                present(controller, animated: true, completion: nil)
                        
//                                let autocompleteController = GMSAutocompleteViewController()
//                                   autocompleteController.delegate = self
//
//                                   // Specify the place data types to return.
//                                   let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//                                     UInt(GMSPlaceField.placeID.rawValue))!
//                                   autocompleteController.placeFields = fields
//
//                                   // Specify a filter.
//                                   let filter = GMSAutocompleteFilter()
//                                   filter.type = .address
//                                   autocompleteController.autocompleteFilter = filter
//
//                                   // Display the autocomplete view controller.
//                                   present(autocompleteController, animated: true, completion: nil)
                            @unknown default:
                            break
                        }
                        } else {
                            print("Location services are not enabled")
                    }

                }else {
                    
                    DispatchQueue.main.async {
                        self.txtnameaddress.resignFirstResponder()
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
                    
                    
                 }
            
            }else{
                
                DispatchQueue.main.async {
                    self.txtnameaddress.resignFirstResponder()
                }
                
                print("Internet Connection not Available!")
                self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
               
            }
            
            return true
        }else if textField == self.txtcontactnumber{
            self.Phonelenght(self.txtcontactnumber)
            return true
        }else if textField == self.txtemailaddress{
            self.Emaillenght(self.txtemailaddress)
            return true
        }else if textField == self.txtfirstname{
            self.Firstnamelenght(self.txtfirstname)
            return true
        }else if textField == self.txtlastname{
            self.Lastnamelenght(self.txtlastname)
            return true
        }
      
     return false
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.openPopup), name: Notification.Name("remove_View"), object: nil)
    }

    @objc func openPopup(){
        establishmentNumber = UserDefaults.standard.string(forKey: AppConstant.ESTABLISHMENTNUMBER)
        let Address = UserDefaults.standard.string(forKey: AppConstant.CURRENTADDRESS)
        print("Address==>\(Address ?? "")")
        print("establishmentNumber==>\(establishmentNumber ?? "")")
        self.txtnameaddress.text = Address ?? ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                // your code hear
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: AppConstant.CURRENTADDRESS)
        })
        

    }
    
    func updateCharacterCount() {
      
       let descriptionCount = self.txtdescription.text.count


       self.LimitLabel.text = "\((0) + descriptionCount)/1000 characters left"
    }
    
    func checkRemainingChars() {
        
        let allowedChars = 1000
        
        let charsInTextView = -txtdescription.text.count
        
        let remainingChars = allowedChars + charsInTextView
        
        
        if remainingChars <= allowedChars {
            
            LimitLabel.textColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            
        }
        
        if remainingChars <= 20 {
            
            LimitLabel.textColor = UIColor.orange
            
        }
        
        if remainingChars <= 10 {
            
            LimitLabel.textColor = UIColor.red
        }
        
        
        LimitLabel.text = String("\(remainingChars)  " + "characters left")
        
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        checkRemainingChars()
    }
    
    

//    func textViewDidChange(_ textView: UITextView) {
//       self.updateCharacterCount()
//    }


    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
       if(textView == txtdescription){
        return textView.text.count -  (text.count - range.length) <= 1000
       }
       return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
        }else{
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
            

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please describe the complaint in as much detail as possible, including: date, time, address(if not already entered), and any other information that will help our investigation."
            textView.textColor = UIColor.lightGray
        }
    }


    func headers() -> HTTPHeaders {
        let headers:HTTPHeaders = ["Content-Type": "application/json"]
        return headers
    }
    
    //txtnameaddress
    func validate() -> Bool {
     if self.txtnameaddress.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please select location.", duration: 0.3)
                return false
    }else if self.txtfirstname.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please enter the first name.", duration: 0.3)
                return false
    }else if self.txtlastname.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please enter the last name.", duration: 0.3)
                return false
    }else if self.txtcontactnumber.text!.count != 10{
        self.view.showToast(toastMessage: "Please enter the valid contact number.", duration: 0.3)
                  return false
    }
      return true
    }
    
    func validateFoodSafety() -> Bool {
        
//        if self.Statetxt.text?.isEmpty ?? true {
//            self.view.showToast(toastMessage: "Please choose subject", duration: 0.3)
//                    return false
//        }else
        
     if self.txtnameaddress.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please select location.", duration: 0.3)
                return false
    }else if self.txtfirstname.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please enter the first name.", duration: 0.3)
                return false
    }else if self.txtlastname.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please enter the last name.", duration: 0.3)
                return false
    }else if self.txtcontactnumber.text!.count != 10{
        self.view.showToast(toastMessage: "Please enter the valid contact number.", duration: 0.3)
                  return false
    }
      return true
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    var checksuccess:Bool?
    
//
//    func BackgroundApiCallApicall(Find:String) {
//
//        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
//        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
//        hud.show(animated: true)
//
//
////        let string = postal
////        let first4 = "\(string?.prefix(3) ?? "0")"
////        print("first4==>\(first4)")
//
//        let StringURL = "https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + latti + "&lon=" + Longi + "&text=770" + "&max=1"
//
////        let StringURL = "https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + LatitudeString + "&lon=" + LongitudeString + "&distance=1&error=0.1"
//
//
//
//        let url = URL(string: StringURL)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//                 guard let data = data else { return }
//                 do{
//                     let json = try JSON(data:data)
//                     print("BackgroundApiCallApicall==> \(json)")
//
//                    let statusisSuccess = json["isSuccess"]
//                    let messageTost = json["message"]
//
//                    let gettost = "\(messageTost)"
//
//                    print("statusisSuccess==>\(statusisSuccess)")
//                    print("gettost==>\(gettost)")
//
//                    self.checksuccess = Bool(statusisSuccess.boolValue)
//                    print("checksuccess==>\(self.checksuccess ?? true)")
//
//                    if statusisSuccess == false{
//
//                        DispatchQueue.main.async {
//                            self.hud.hide(animated: true)
//                            //self.view.showToast(toastMessage: gettost, duration: 0.3)
//
//                        }
//
//                    }else{
//                        let decoder = JSONDecoder()
//                        self.BackgroundPools = try decoder.decode(BackgroundApicall.self, from: data)
//                        self.Establishmentnumber = self.BackgroundPools?.data[0].establishmentNumber
//                        DispatchQueue.main.async {
//                            self.hud.hide(animated: true)
//                        }
//                    }
//
//
//
//                 }catch{
//                     print(error.localizedDescription)
//                    DispatchQueue.main.async {
//                        self.hud.hide(animated: true)
//                    }
//                 }
//
//                 }
//
//        task.resume()
//
//    }
    
//    func BackgroundApiCallApicall2(Find:String) {
//
//
//        let StringURL = "https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + latti + "&lon=" + Longi + "&text=" + postal + "&max=1"
//
////        let StringURL = "https://apps.harriscountytx.gov/PublicHealthPortal/api/EstablishmentLocationByDistance/lat=" + LatitudeString + "&lon=" + LongitudeString + "&distance=1&error=0.1"
//
//
//        let url = URL(string: StringURL)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//                 guard let data = data else { return }
//                 do{
//                     let json = try JSON(data:data)
//                     print("BackgroundApiCallApicall==> \(json)")
//
//                    let statusisSuccess = json["isSuccess"]
//                    let messageTost = json["message"]
//
//                    let gettost = "\(messageTost)"
//
//                    print("statusisSuccess==>\(statusisSuccess)")
//                    print("gettost==>\(gettost)")
//
//                    self.checksuccess = Bool(statusisSuccess.boolValue)
//                    print("checksuccess==>\(self.checksuccess ?? true)")
//
//                    if statusisSuccess == false{
//
//                        DispatchQueue.main.async {
//                            self.hud.hide(animated: true)
//                            //self.view.showToast(toastMessage: gettost, duration: 0.3)
//                            self.CommercialPoolsApicall()
//                        }
//
//
//                    }else{
//                        let decoder = JSONDecoder()
//                        self.BackgroundPools = try decoder.decode(BackgroundApicall.self, from: data)
//                        self.Establishmentnumber = self.BackgroundPools?.data[0].establishmentName
//
//                        DispatchQueue.main.async {
//                            self.hud.hide(animated: true)
//                            //self.view.showToast(toastMessage: gettost, duration: 0.3)
//                            self.CommercialPoolsApicall()
//                        }
//
//                    }
//
//
//
//                 }catch{
//                     print(error.localizedDescription)
//                    DispatchQueue.main.async {
//                        self.hud.hide(animated: true)
//                        //self.view.showToast(toastMessage: gettost, duration: 0.3)
//
//                    }
//                 }
//
//                 }
//
//        task.resume()
//
//    }
    
    func CommercialPoolsApicall() {
            
            
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
            hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
            hud.show(animated: true)
            
            if txtdescription.text == "Please describe the complaint in as much detail as possible, including: date, time, address(if not already entered), and any other information that will help our investigation."{
                let parameters = [
                    "ContactNumber":txtcontactnumber.text ?? "",
                    "Description":"",
                    "Email":txtemailaddress.text ?? "",
                    "EstablishmentNumber": establishmentNumber ?? "0",
                    "FirstName":txtfirstname.text ?? "",
                    "LastName":txtlastname.text ?? "",
                    "Place":txtnameaddress.text ?? "",
                    "ReceivedDevice":"1",
                    "Section":"Report Issue",
                    "Subject":Statetxt.text ?? "",
                    "GPSX":latti ?? "",
                    "GPSY":Longi ?? "",
                    "ImageBytes":ImageBytesone,
                    "ImageBytes2":ImageBytestwo,
                    "ImageBytes3":ImageBytesthree,
                    "ImageBytes4":ImageBytesfour,
                    "ImageBytes5":ImageBytesfive,
                ] as [String : Any]
                
                let jsonData = try? JSONSerialization.data(withJSONObject: parameters)

                let url = URL(string: "https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/UploadServiceRequest")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                         
                         guard let data = data else { return }
                         do{
                             let json = try JSON(data:data)
                             print("CommercialPoolsApicall==> \(json)")
                                                
                            let statusisSuccess = json["isSuccess"]
                            let messageTost = json["message"]
                            
                            let gettost = "\(messageTost)"
                            
                            print("statusisSuccess==>\(statusisSuccess)")
                            print("gettost==>\(gettost)")
                            
                            if statusisSuccess == "false"{

                                DispatchQueue.main.async {
                                    self.hud.hide(animated: true)
                                    self.view.showToast(toastMessage: gettost, duration: 0.3)
                                    
                                }
                        
                            }else{
                                let decoder = JSONDecoder()
                                self.CommercialPools = try decoder.decode(CommercialPoolsWelcome.self, from: data)
                                   
                          DispatchQueue.main.async {
                            
                                self.hud.hide(animated: true)
                            
                            self.view.showToast(toastMessage: "Form Successfully Submitted", duration: 0.3)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                // your code here
                                let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                navigate.selectdtab = 4
                                self.navigationController?.pushViewController(navigate, animated: true)
                            }
                            

                                    
                            }
                            }
                            

                             
                         }catch{
                             print(error.localizedDescription)
                         }
                         
                         }

                task.resume()

            }else{
                let parameters = [
                    "ContactNumber":txtcontactnumber.text ?? "",
                    "Description":txtdescription.text ?? "",
                    "Email":txtemailaddress.text ?? "",
                    "EstablishmentNumber":establishmentNumber ?? "0",
                    "FirstName":txtfirstname.text ?? "",
                    "LastName":txtlastname.text ?? "",
                    "Place":txtnameaddress.text ?? "",
                    "ReceivedDevice":"1",
                    "Section":"Report Issue",
                    "Subject":Statetxt.text ?? "",
                    "GPSX":latti ?? "",
                    "GPSY":Longi ?? "",
                    "ImageBytes":ImageBytesone,
                    "ImageBytes2":ImageBytestwo,
                    "ImageBytes3":ImageBytesthree,
                    "ImageBytes4":ImageBytesfour,
                    "ImageBytes5":ImageBytesfive,
                ] as [String : Any]
                
                let jsonData = try? JSONSerialization.data(withJSONObject: parameters)

                let url = URL(string: "https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/UploadServiceRequest")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("500000", forHTTPHeaderField: "Content-Length")
                
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                         
                         guard let data = data else { return }
                         do{
                             let json = try JSON(data:data)
                             print("CommercialPoolsApicall==> \(json)")
                                                
                            let statusisSuccess = json["isSuccess"]
                            let messageTost = json["message"]
                            
                            let gettost = "\(messageTost)"
                            
                            print("statusisSuccess==>\(statusisSuccess)")
                            print("gettost==>\(gettost)")
                            
                            if statusisSuccess == "false"{

                                DispatchQueue.main.async {
                                    self.hud.hide(animated: true)
                                    self.view.showToast(toastMessage: gettost, duration: 0.3)
                                    
                                }
                        
                            }else{
                                let decoder = JSONDecoder()
                                self.CommercialPools = try decoder.decode(CommercialPoolsWelcome.self, from: data)
                                   
                          DispatchQueue.main.async {
                            
                                self.hud.hide(animated: true)
                            

                            
                            self.view.showToast(toastMessage: "Form Successfully Submitted", duration: 0.3)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                // your code here
                                let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                navigate.selectdtab = 4
                                self.navigationController?.pushViewController(navigate, animated: true)
                            }
                            

                                    
                            }
                            }
                            

                             
                         }catch{
                             print(error.localizedDescription)
                         }
                         
                         }

                task.resume()
            }
      
        }
    
    var textLog = TextLog()
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let image = Image(imageData: selectedImage.pngData()!)
            images.append(image)
            
//            let imageData:NSData = selectedImage.pngData()! as NSData
//            let imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//            print("imageStr==>\(imageStr)")
            
            //if let data = selectedImage.pngData()
       
            if let data = selectedImage.jpegData(compressionQuality: 0.4){
            //print("There were \(data.count) bytes")
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
            bcf.countStyle = .file
            let string = bcf.string(fromByteCount: Int64(data.count))
                print("formatted result: \(string)")
                let myInt3 = (string as NSString).integerValue
                CheckMB.append(myInt3)
                
                hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
                hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
                hud.show(animated: true)
                
                
            }
            
            let total = CheckMB.reduce(0, +)
            
            
            if total < 20{
                print("less")
                Image.saveImages(images)
                dismiss(animated: true, completion: nil)
                self.imagecollection.reloadData()
                
                
                //let dataa = selectedImage.pngData()
                //let dataa = selectedImage.jpegData(compressionQuality: 0.4)
                
                let options: NSDictionary = [:]
                
                //let dataimages = selectedImage.pngData()
                
                //let convertToBmp = selectedImage.toData(options: options, type: .bmp)
//                guard convertToBmp != nil else {
//                    print("😡 ERROR: could not convert image to a bitmap bmpData var.")
//                    return
//                }
                let dataa = selectedImage.jpegData(compressionQuality: 0.4)
                
                dismiss(animated: true, completion: nil)
                imagePicker.dismiss(animated: true, completion: nil)
                
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                  // your code with delay
                    
                    self.bytes = self.getArrayOfBytesFromImage(imageData: dataa! as NSData)
                    let datos: NSData = NSData(bytes: self.bytes, length: self.bytes.count)
                    
                    //let imageData2:Data =  selectedImage.pngData()!
                    let base64String2 = datos.base64EncodedString()
                    //print("base64String2===>\(base64String2)")
                    
                    
                    //let imageData: Data? = selectedImage.jpegData(compressionQuality: 0.4)
                    //let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
                    
                    self.arrayimage.append(base64String2)
                    
                    if self.arrayimage.count == 1{
                        print("Count 1")
                        self.ImageBytesone = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                     
                   
    //                    let dataDecoded:NSData = NSData(base64Encoded: base64String2, options: NSData.Base64DecodingOptions(rawValue: 0))!
    //                    let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
    //                    //print(decodedimage)
    //                    yourImageView.image = decodedimage
    //
    //                    saveImageToDocumentDirectory(image: yourImageView.image!)
    //
    //                    textLog.write(base64String2)
                        
                    }else if self.arrayimage.count == 2{
                        print("Count 2")
                        self.ImageBytestwo = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                      
    //                    let dataDecoded:NSData = NSData(base64Encoded: base64String2, options: NSData.Base64DecodingOptions(rawValue: 0))!
    //                    let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
    //                    //print(decodedimage)
    //                    yourImageView.image = decodedimage
    //
    //                    saveImageToDocumentDirectory(image: yourImageView.image!)
                        
                    }else if self.arrayimage.count == 3{
                        print("Count 3")
                        self.ImageBytesthree = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                        
    //                    let dataDecoded:NSData = NSData(base64Encoded: base64String2, options: NSData.Base64DecodingOptions(rawValue: 0))!
    //                    let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
    //                    //print(decodedimage)
    //                    yourImageView.image = decodedimage
    //
    //                    saveImageToDocumentDirectory(image: yourImageView.image!)
                    }else if self.arrayimage.count == 4{
                        print("Count 4")
                        self.ImageBytesfour = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                        
    //                    let dataDecoded:NSData = NSData(base64Encoded: base64String2, options: NSData.Base64DecodingOptions(rawValue: 0))!
    //                    let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
    //                    //print(decodedimage)
    //                    yourImageView.image = decodedimage
    //
    //                    saveImageToDocumentDirectory(image: yourImageView.image!)
                    }else if self.arrayimage.count == 5{
                        print("Count 5")
                        self.ImageBytesfive = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                        
    //                    let dataDecoded:NSData = NSData(base64Encoded: base64String2, options: NSData.Base64DecodingOptions(rawValue: 0))!
    //                    let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
    //                    //print(decodedimage)
    //                    yourImageView.image = decodedimage
    //
    //                    saveImageToDocumentDirectory(image: yourImageView.image!)
                    }
              
                }
                
               
            }else{
                dismiss(animated: true, completion: nil)
                print("less not")
                
                
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                  // your code with delay
                    
                let alertController = UIAlertController(title: "HCPH", message: "All image size must be less than 20 MB.", preferredStyle: UIAlertController.Style.alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                
                }
            }
        }
        
    }
    
    func getArrayOfBytesFromImage(imageData:NSData) -> Array<UInt8>
    {

      // the number of elements:
      let count = imageData.length / MemoryLayout<Int8>.size

      // create array of appropriate length:
      var bytes = [UInt8](repeating: 0, count: count)

      // copy bytes into array
      imageData.getBytes(&bytes, length:count * MemoryLayout<Int8>.size)

      var byteArray:Array = Array<UInt8>()

      for i in 0 ..< count {
        byteArray.append(bytes[i])
      }

      return byteArray


    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddimageAction(_ sender: UIButton) {
        
        if arrayimage.count == 5{
            print("Count 5 Done!")
            let alertController = UIAlertController(title: "HCPH", message: "You can attach maximum five images.", preferredStyle: UIAlertController.Style.alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)


            self.present(alertController, animated: true, completion: nil)
        }else{
            
                    imagePicker.delegate = self
                    
                    let alertViewController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                            self.imagePicker.sourceType = .photoLibrary
                            self.imagePicker.modalPresentationStyle = .overFullScreen
                            self.imagePicker.allowsEditing = true
                            self.present(self.imagePicker, animated: true, completion: nil)
                        })
                        let CameraLibraryAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                            //self.galleryVideo()
                            self.imagePicker.sourceType = .camera
                            self.imagePicker.allowsEditing = true
                            self.present(self.imagePicker, animated: true, completion: nil)
                        })

                        alertViewController.addAction(CameraLibraryAction)
                        alertViewController.addAction(photoLibraryAction)
                    }
                    alertViewController.addAction(cancelAction)
                    present(alertViewController, animated: true, completion: nil)
                    
                    alertViewController.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
                        return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
                        }.first?.isActive = false
        }
    }
    
    @IBAction func submitaction(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            
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
                            if Title == "Food Safety"{
                                if validateFoodSafety(){
                                    CommercialPoolsApicall()
                                }
                            }else{
                                if validate(){
                                    
//                                    if self.BackgroundPools?.data[0].establishmentNumber.isEmpty ?? true  && self.BackgroundPools?.data[0].establishmentNumber == "0"{
//                                        BackgroundApiCallApicall2(Find:postal ?? "0")
//                                    }else{
//                                        CommercialPoolsApicall()
//                                    }
                                    
//                                    if checksuccess == false{
//                                        BackgroundApiCallApicall2(Find:postal ?? "0")
//                                    }else{
                                        CommercialPoolsApicall()
                                    //}
                              
                                }
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
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CommercialPoolsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommercialPoolsCollectionViewCell", for: indexPath) as! CommercialPoolsCollectionViewCell
        cell.lazyImageView.image = UIImage(data:images[indexPath.row].imageData!)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDeleteWarningimage(for: indexPath)
    }
    
    func showDeleteWarningimage(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "HCPH", message: "Are you sure want to delete this image?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let deleteAction = UIAlertAction(title: "OK", style: .destructive) { _ in
            DispatchQueue.main.async {
                self.remove(index: indexPath.row)
            }
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        present(alert, animated: true, completion: nil)
    }
    
    func saveImageToDocumentDirectory(image: UIImage ) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "image001.png" // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image.jpegData(compressionQuality: 1.0),!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    func remove(index: Int) {
        images.remove(at: index)
        CheckMB.remove(at: index)
        self.arrayimage.remove(at: index)

        let indexPath = IndexPath(row: index, section: 0)
        imagecollection.performBatchUpdates({
            self.imagecollection.deleteItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
            self.imagecollection.reloadItems(at: self.imagecollection.indexPathsForVisibleItems)
        })
        
        print("images==>\(images)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            if textField == txtemailaddress {
                txtfirstname.becomeFirstResponder()
            } else if textField == txtfirstname {
                txtlastname.becomeFirstResponder()
            } else if textField == txtlastname {
                txtcontactnumber.becomeFirstResponder()
            } else if textField == txtcontactnumber {
                txtcontactnumber.resignFirstResponder()
            }
            return true
        }
    

    
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
             
     self.view.endEditing(true)
    }
    
}

extension CommercialPoolsViewController{
    func hideKeyboardTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}


struct TextLog: TextOutputStream {

    /// Appends the given string to the stream.
    mutating func write(_ string: String) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)
        let documentDirectoryPath = paths.first!
        let log = documentDirectoryPath.appendingPathComponent("log.txt")

        do {
            let handle = try FileHandle(forWritingTo: log)
            handle.seekToEndOfFile()
            handle.write(string.data(using: .utf8)!)
            handle.closeFile()
        } catch {
            print(error.localizedDescription)
            do {
                try string.data(using: .utf8)?.write(to: log)
            } catch {
                print(error.localizedDescription)
            }
        }

    }

}
