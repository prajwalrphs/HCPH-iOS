
import UIKit
import iOSDropDown
import CoreLocation
import MBProgressHUD
import SwiftyJSON
import Alamofire

class MosquitoBreedingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UITextViewDelegate {

    var images: [Image] = []
    var hud: MBProgressHUD = MBProgressHUD()
    
    var CheckMB = [Int]()
    
    @IBOutlet weak var submitoutlate: UIButton!
    @IBOutlet weak var viewmain: UIView!
    @IBOutlet weak var Mosquitocollection: UICollectionView!
    @IBOutlet weak var plusimage: UIButton!
    
    @IBOutlet weak var Timeofday: UITextField!
    @IBOutlet weak var txtemailofpersonrepoting: UITextField!
    @IBOutlet weak var txtcontactofpersonrepoting: UITextField!
    @IBOutlet var OtherText: UITextView!
    
    @IBOutlet weak var mainDropDown: DropDown!
    
    
    @IBOutlet var viewone: UIView!
    @IBOutlet var viewtwo: UIView!
    
    @IBOutlet var lblwhenare: UILabel!
    @IBOutlet var lblmaywe: UILabel!
    @IBOutlet var lblplease: UILabel!
    @IBOutlet var lblwater: UILabel!
    @IBOutlet var lblDitches: UILabel!
    @IBOutlet var lblother: UILabel!
    @IBOutlet var lbladdimages: UILabel!
    @IBOutlet var lblBulklabel: UILabel!
    
    var Switch1:String!
    var Switch2:String!
    var Switch3:String!
    var Switch4:String!

    let locationManager = CLLocationManager()
    
    var TimeofArray = ["Day","Night","Both"]
    let ids = [1,2,3]
    
    var LatitudeString:String!
    var LongitudeString:String!
    
    var arrayimage = [String]()
    var InspectionItemResult = [Any]()
    //var InspectionItemResult = [NSDictionary]()
    
    var bytes = Array<UInt8>()
    
    let imagePicker = UIImagePickerController()
    
    var TabelMosquitoBreeding:String?
    var CollectionMosquitoBreeding:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lbladdimages.frame.origin.y = 470
         self.viewmain.frame.origin.y = 495
         self.lblBulklabel.frame.origin.y = 590
        
        CheckMB.removeAll()
        arrayimage.removeAll()
                
        OtherText.delegate = self
        self.OtherText.isHidden = true
        
        OtherText.layer.borderWidth = 1
        OtherText.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        
        OtherText.autocapitalizationType = .sentences
        OtherText.autocapitalizationType = .words
        OtherText.text = "Please describe the breeding site."
        OtherText.textColor = UIColor.lightGray
        
        txtcontactofpersonrepoting.delegate = self
        txtemailofpersonrepoting.delegate = self
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        self.viewmain.layer.cornerRadius = 5
        self.viewmain.layer.borderWidth = 1
        self.viewmain.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.viewmain.clipsToBounds = true
        
        
        if onoff == "on"{
            
            mainDropDown.rowBackgroundColor = AppConstant.ViewColor
            
            self.viewmain.layer.cornerRadius = 5
            self.viewmain.layer.borderWidth = 1
            self.viewmain.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            self.viewmain.clipsToBounds = true
            
            OtherText.layer.borderWidth = 1
            OtherText.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                        
            self.lblwhenare.textColor = AppConstant.LabelWhiteColor
            self.lblmaywe.textColor = AppConstant.LabelWhiteColor
            self.lblplease.textColor = AppConstant.LabelWhiteColor
            self.lblwater.textColor = AppConstant.LabelWhiteColor
            self.lbladdimages.textColor = AppConstant.LabelWhiteColor
            self.lblDitches.textColor = AppConstant.LabelWhiteColor
            self.lblother.textColor = AppConstant.LabelWhiteColor
            self.lbladdimages.textColor = AppConstant.LabelWhiteColor
            self.lblBulklabel.textColor = AppConstant.LabelWhiteColor
        
            self.viewone.backgroundColor = AppConstant.LabelWhiteColor
            self.viewtwo.backgroundColor = AppConstant.LabelWhiteColor
       
            
            Timeofday.attributedPlaceholder = NSAttributedString(string: "Time of day",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtemailofpersonrepoting.attributedPlaceholder = NSAttributedString(string: "Email of person reporting*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtcontactofpersonrepoting.attributedPlaceholder = NSAttributedString(string: "Contact of person reporting*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
//            OtherText.attributedPlaceholder = NSAttributedString(string: "Please describe the breeding site.",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
        }else if onoff == "off"{
            
        }else{
            
        }
        
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
        

        
        self.hideKeyboardTappedAround()
                
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mainDropDown.selectedRowColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        mainDropDown.optionArray = TimeofArray
        mainDropDown.optionIds = ids
        mainDropDown.checkMarkEnabled = false
        
        mainDropDown.didSelect{(selectedText , index , id) in
            self.Timeofday.text = selectedText
        }

        self.submitoutlate.layer.cornerRadius = 25
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
       if(textView == OtherText){
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
            textView.text = "Please describe the breeding site."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.LatitudeString = "\(locValue.latitude)"
        self.LongitudeString = "\(locValue.longitude)"
        
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
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
                            if validate(){
                                MosquitoBreedingAPICall()
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
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
    }
    
    
    @IBAction func inspectionformosquitobreeding(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.Switch1 = "true"
        }
        else{
            print("off")
            self.Switch1 = "false"
        }
    }
    
    @IBAction func Waterholdingcontainers(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.Switch2 = "true"
        }
        else{
            print("off")
            self.Switch2 = "false"
        }
    }
    
    @IBAction func Ditcheswithwater(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.Switch3 = "true"
        }
        else{
            print("off")
            self.Switch3 = "false"
        }
    }
    
    @IBAction func Other(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            DOWNView()
            self.OtherText.isHidden = false
            self.Switch4 = "true"
        }
        else{
            print("off")
            UPView()
            self.OtherText.isHidden = true
            self.Switch4 = "false"
        }
    }
    
    func UPView(){
//        let originalX = lbladdimages.frame.origin.x
//        if(originalX < 0){
//            bringIntoFrame()
//        }
//        else{
//            lbladdimages.frame.offsetBy(dx: -50, dy: 0)
//        }
        
        UIView.animate(withDuration: 1, delay: 0, options: [.beginFromCurrentState],
                          animations: {
                           //self.lbladdimages.frame.origin.x += 300
                           self.lbladdimages.frame.origin.y = 470
                            self.viewmain.frame.origin.y = 495
                            self.lblBulklabel.frame.origin.y = 590
                           self.view.layoutIfNeeded()
           }, completion: nil)
    }
    
    func DOWNView(){
//        let originalX = lbladdimages.frame.origin.x
//        if(originalX < 0){
//            bringIntoFrame()
//        }
//        else{
//            lbladdimages.frame.offsetBy(dx: -50, dy: 0)
//        }
        
        UIView.animate(withDuration: 1, delay: 0, options: [.beginFromCurrentState],
                          animations: {
                           //self.lbladdimages.frame.origin.x += 300
                           self.lbladdimages.frame.origin.y = 550
                            self.viewmain.frame.origin.y = 571
                            self.lblBulklabel.frame.origin.y = 671
                           self.view.layoutIfNeeded()
           }, completion: nil)
    }
    
   

    func validate() -> Bool {
     if self.txtemailofpersonrepoting.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please enter the valid email", duration: 0.3)
                return false
    }else if self.isValidEmail(testStr: txtemailofpersonrepoting.text!) == false{
        self.view.showToast(toastMessage: "Please enter the valid email", duration: 0.3)
        return false
    }else if self.txtcontactofpersonrepoting.text!.count != 10{
        self.view.showToast(toastMessage: "Please enter the valid contact number.", duration: 0.3)
                  return false
    }else if self.Timeofday.text?.isEmpty ?? true{
        self.view.showToast(toastMessage: "Please Select Time of day", duration: 0.3)
                  return false
    }else if self.arrayimage.isEmpty{
        self.view.showToast(toastMessage: "Image is required", duration: 0.3)
                  return false
    }
      return true
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtcontactofpersonrepoting{
            let MAX_LENGTH = 10
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtemailofpersonrepoting{
            let MAX_LENGTH = 110
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else{
            return true
        }
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         if textField == self.txtcontactofpersonrepoting{
            self.Phonelenght(self.txtcontactofpersonrepoting)
            return true
        }else if textField == self.txtemailofpersonrepoting{
            self.Emaillenght(self.txtemailofpersonrepoting)
            return true
        }
      
     return false
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func MosquitoBreedingAPICall(){


    hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
    hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
    hud.show(animated: true)


    var Address = [NSDictionary]()
    let AddressDic = ["addressname":"","city":"","zip":""]
    Address.append(AddressDic as NSDictionary)

    var Requestor = [NSDictionary]()
    let RequestorDic = ["requestorname":"","primaryphone":txtcontactofpersonrepoting.text ?? "","secondaryphone":"","reporteremail":txtemailofpersonrepoting.text ?? ""]
    Requestor.append(RequestorDic as NSDictionary)

    if Switch1 == "true"{
    //switch1
    let switchone = ["CallRequestId": "0","isChecked": true,"ItemObservedDescription": "","InspectionItemId":"85","ItemDescription": "","InspectionItemType": "","CreatedBy": "","CreatedDt": "","LastModifiedBy": "","LastModifiedDt": "","DeletedFg": "","ItemOrder": ""] as [String : Any]

    InspectionItemResult.append(switchone)
    }

    if Switch2 == "true"{
    //switch2
    let switchtwo = ["CallRequestId": "0","isChecked": true,"ItemObservedDescription": "","InspectionItemId":"92","ItemDescription": "","InspectionItemType": "","CreatedBy": "","CreatedDt": "","LastModifiedBy": "","LastModifiedDt": "","DeletedFg": "","ItemOrder": ""] as [String : Any]

    InspectionItemResult.append(switchtwo)
    }

    if Switch3 == "true"{
    //switch3
    let switchthree = ["CallRequestId": "0","isChecked": true,"ItemObservedDescription": "","InspectionItemId":"91","ItemDescription": "","InspectionItemType": "","CreatedBy": "","CreatedDt": "","LastModifiedBy": "","LastModifiedDt": "","DeletedFg": "","ItemOrder": ""] as [String : Any]

    InspectionItemResult.append(switchthree)
    }

    if Switch4 == "true"{
    //switch4
        
        if OtherText.text == "Please describe the breeding site."{
            let switchfour = ["CallRequestId": "0","isChecked": true,"ItemObservedDescription":"","InspectionItemId":"93","ItemDescription": "","InspectionItemType": "","CreatedBy": "","CreatedDt": "","LastModifiedBy": "","LastModifiedDt": "","DeletedFg": "","ItemOrder": ""] as [String : Any]

            InspectionItemResult.append(switchfour)
        }else{
            let switchfour = ["CallRequestId": "0","isChecked": true,"ItemObservedDescription": OtherText.text ?? "","InspectionItemId":"93","ItemDescription": "","InspectionItemType": "","CreatedBy": "","CreatedDt": "","LastModifiedBy": "","LastModifiedDt": "","DeletedFg": "","ItemOrder": ""] as [String : Any]

            InspectionItemResult.append(switchfour)
        }
   
    }

    let headers: HTTPHeaders = ["Content-Type": "application/json","Content-Length":"500000"]


    let CurrentDate = UserDefaults.standard.string(forKey: AppConstant.DATE)
    print("onoff==>\(CurrentDate ?? "")")
        
        
        if OtherText.text == "Please describe the breeding site."{
            let objParameters: Parameters = [
            "FirstName":"",
            "LastName":"",
            "RequestTypeId":1,
            "FromExternalWebSite":true,
            "MosquitoBiteTimeOfDay":Timeofday.text ?? "",
            "InspectionConduction":false,
            "RequestDt":"2018-07-20 03:03 33",
            "locationofproblem":"",
            "OtherSite":"",
            "address":AddressDic,
            "requestor":RequestorDic,
            "Latitude":LatitudeString ?? "",
            "Longitude":LongitudeString ?? "",
            "InspectionItemResult":InspectionItemResult,
            "ImageList":arrayimage
            ]

                
        //    let url = URL(string: "http://svpphesmcweb01.hcphes.hc.hctx.net/Stage_MCDExternalApi/api/External/AddExtCitizenRequest?title=")!
                
                let URLset = "http://svpphesmcweb01.hcphes.hc.hctx.net/Stage_MCDExternalApi/api/External/AddExtCitizenRequest?title="

            AF.request(URLset,method: .post, parameters:objParameters, encoding: JSONEncoding.default
            , headers: headers)
            .responseJSON { response in
            print("StatusCode==>\(response.response?.statusCode ?? 0)")
            switch response.result{
            case .success(let JSON):
            print("Success with JSON: \(JSON)")

            if response.response?.statusCode == 200{
            DispatchQueue.main.async {

            self.hud.hide(animated: true)
            self.view.showToast(toastMessage: "Form Successfully Submitted", duration: 0.3)
                
                if self.TabelMosquitoBreeding == "TabelMosquitoBreeding"{
                    self.navigationController?.popViewController(animated: true)
                }else if self.CollectionMosquitoBreeding == "CollectionMosquitoBreeding"{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    navigate.selectdtab = 4
                    self.navigationController?.pushViewController(navigate, animated: true)
                    }
                }
              }
            }

            case .failure(let error):
            print(error.localizedDescription)
            DispatchQueue.main.async {
            self.hud.hide(animated: true)
            self.view.showToast(toastMessage: "Fail", duration: 0.5)
            }
            }
            print("DeadBirdResponse==>\(response)")

            }
        }else{
            let objParameters: Parameters = [
            "FirstName":"",
            "LastName":"",
            "RequestTypeId":1,
            "FromExternalWebSite":true,
            "MosquitoBiteTimeOfDay":Timeofday.text ?? "",
            "InspectionConduction":false,
            "RequestDt":"2018-07-20 03:03 33",
            "locationofproblem":"",
            "OtherSite":OtherText.text ?? "",
            "address":AddressDic,
            "requestor":RequestorDic,
            "Latitude":LatitudeString ?? "",
            "Longitude":LongitudeString ?? "",
            "InspectionItemResult":InspectionItemResult,
            "ImageList":arrayimage
            ]

                
        //    let url = URL(string: "http://svpphesmcweb01.hcphes.hc.hctx.net/Stage_MCDExternalApi/api/External/AddExtCitizenRequest?title=")!
                
                let URLset = "http://svpphesmcweb01.hcphes.hc.hctx.net/Stage_MCDExternalApi/api/External/AddExtCitizenRequest?title="

            AF.request(URLset,method: .post, parameters:objParameters, encoding: JSONEncoding.default
            , headers: headers)
            .responseJSON { response in
            print("StatusCode==>\(response.response?.statusCode ?? 0)")
            switch response.result{
            case .success(let JSON):
            print("Success with JSON: \(JSON)")

            if response.response?.statusCode == 200{
            DispatchQueue.main.async {

            self.hud.hide(animated: true)
            self.view.showToast(toastMessage: "Form Successfully Submitted", duration: 0.3)

                if self.TabelMosquitoBreeding == "TabelMosquitoBreeding"{
                    self.navigationController?.popViewController(animated: true)
                }else if self.CollectionMosquitoBreeding == "CollectionMosquitoBreeding"{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    navigate.selectdtab = 4
                    self.navigationController?.pushViewController(navigate, animated: true)
                    }
                }
                
            }
            }

            case .failure(let error):
            print(error.localizedDescription)
            DispatchQueue.main.async {
            self.hud.hide(animated: true)
            self.view.showToast(toastMessage: "Fail", duration: 0.5)
            }
            }
            print("DeadBirdResponse==>\(response)")

            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

//            if let data = selectedImage.pngData() {
//            //print("There were \(data.count) bytes")
//            let bcf = ByteCountFormatter()
//            bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
//            bcf.countStyle = .file
//            let string = bcf.string(fromByteCount: Int64(data.count))
//                print("formatted result: \(string)")
//
//                let myInt3 = (string as NSString).integerValue
//                CheckMB.append(myInt3)
//            }
            
            let image = Image(imageData: selectedImage.pngData()!)
            images.append(image)
            
            if let data = selectedImage.jpegData(compressionQuality: 0.1){
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
   
                
                Image.saveImages(images)
                dismiss(animated: true, completion: nil)
                self.Mosquitocollection.reloadData()
                
//                let dataa = selectedImage.pngData()
//                bytes = getArrayOfBytesFromImage(imageData: dataa! as NSData)
//                let datos: NSData = NSData(bytes: bytes, length: bytes.count)
                
                let dataa = selectedImage.jpegData(compressionQuality: 0.1)
                
//                let options: NSDictionary =     [:]
//                let convertToBmp = selectedImage.toData(options: options, type: .bmp)
//                guard convertToBmp != nil else {
//                    print("😡 ERROR: could not convert image to a bitmap bmpData var.")
//                    return
//                }
                
                dismiss(animated: true, completion: nil)
                imagePicker.dismiss(animated: true, completion: nil)
                
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                    self.bytes = self.getArrayOfBytesFromImage(imageData: dataa! as NSData)
                    let datos: NSData = NSData(bytes: self.bytes, length: self.bytes.count)
                    
    //                let imageData: Data? = selectedImage.jpegData(compressionQuality: 0.4)
    //                let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
    //                self.arrayimage.append(imageStr)
                    
                    //let imageData2:Data =  selectedImage.pngData()!
                    let base64String2 = datos.base64EncodedString()
                    
                    self.arrayimage.append(base64String2)
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
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
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addimage(_ sender: UIButton) {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell:MosquitoBreedingCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MosquitoBreedingCollectionViewCell", for: indexPath) as! MosquitoBreedingCollectionViewCell
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
    
    func remove(index: Int) {
        images.remove(at: index)
        self.arrayimage.remove(at: index)
        CheckMB.remove(at: index)

        let indexPath = IndexPath(row: index, section: 0)
        Mosquitocollection.performBatchUpdates({
            self.Mosquitocollection.deleteItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
            self.Mosquitocollection.reloadItems(at: self.Mosquitocollection.indexPathsForVisibleItems)
        })
        
        print("images==>\(images)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             
        if textField == txtemailofpersonrepoting {
            txtcontactofpersonrepoting.becomeFirstResponder()
        } else if textField == txtcontactofpersonrepoting {
            txtcontactofpersonrepoting.resignFirstResponder()
        }else{
            txtcontactofpersonrepoting.resignFirstResponder()
        }
        return true
   }
         
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
             
     self.view.endEditing(true)
    }
    
}

extension MosquitoBreedingViewController{
    func hideKeyboardTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
