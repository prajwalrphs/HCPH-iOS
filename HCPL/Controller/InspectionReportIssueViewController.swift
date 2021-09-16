
import UIKit
import CoreLocation
import MapKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import MBProgressHUD
import SwiftyJSON
import Alamofire
import iOSDropDown

extension UITextField{
    
    func setBottomBordar(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
}

class InspectionReportIssueViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var CustomMapView: GMSMapView!
    @IBOutlet var viewbordermap: UIView!
    @IBOutlet var lbltitle: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblDemerit: UILabel!
    @IBOutlet var txtsubject: UITextField!
    @IBOutlet weak var mainDropDown: DropDown!
    @IBOutlet var viewAddress: UIView!
    
    @IBOutlet var viewemail: UIView!
    @IBOutlet var viewname: UIView!
    @IBOutlet var viewlastname: UIView!
    @IBOutlet var viewcontect: UIView!
    
    @IBOutlet var txtaddress: UITextField!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtContectNumber: UITextField!
    
    
    @IBOutlet var viewcamera1: UIView!
    @IBOutlet var viewcamera2: UIView!
    @IBOutlet var viewcamera3: UIView!
    @IBOutlet var viewcamera4: UIView!
    @IBOutlet var viewcamera5: UIView!
    
    @IBOutlet var img1: UIImageView!
    @IBOutlet var img2: UIImageView!
    @IBOutlet var img3: UIImageView!
    @IBOutlet var img4: UIImageView!
    @IBOutlet var img5: UIImageView!
    
    
    @IBOutlet var imagebuttonoutlate1: UIButton!
    @IBOutlet var imagebuttonoutlate2: UIButton!
    @IBOutlet var imagebuttonoutlate3: UIButton!
    @IBOutlet var imagebuttonoutlate4: UIButton!
    @IBOutlet var imagebuttonoutlate5: UIButton!
    
    @IBOutlet var txtdescription: UITextView!
    
    @IBOutlet var viewtextdescription: UIView!
    @IBOutlet var lbllimit: UILabel!
    @IBOutlet var lblHeding: UILabel!
    
    @IBOutlet var btnissue: UIButton!
    
    var ImageBytesone = String()
    var ImageBytestwo = String()
    var ImageBytesthree = String()
    var ImageBytesfour = String()
    var ImageBytesfive = String()
    
    var LatitudeString:String!
    var LongitudeString:String!
    let locationManager = CLLocationManager()
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    var CommercialPools:CommercialPoolsWelcome?
    
    var CommercialArray = ["Food Made Me Sick","Unclean Preparation","Something in My Food"]
    var ids = [1,2,3,4]
    
    var arrayimage = [String]()
    
    var lat:Double!
    var long:Double!
    var MarkerImage:UIImage!
    var TitleAddress:String!
    var addressString:String!
    var demeritsString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        ShowLocation(lath: lat, Longh: long)
        
        
        lbltitle.text = TitleAddress
        lblAddress.text = addressString
        lblDemerit.text = "Demerits: \(demeritsString ?? "")"
        
        viewbordermap.layer.cornerRadius = 3
        viewbordermap.layer.borderWidth = 1
        viewbordermap.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
 
        txtFirstName.setBottomBordar()
        txtaddress.setBottomBordar()
        txtLastName.setBottomBordar()
        txtContectNumber.setBottomBordar()
        
        viewcamera1.layer.cornerRadius = 3
        viewcamera1.layer.borderWidth = 1
        viewcamera1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        viewcamera2.layer.cornerRadius = 3
        viewcamera2.layer.borderWidth = 1
        viewcamera2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        viewcamera3.layer.cornerRadius = 3
        viewcamera3.layer.borderWidth = 1
        viewcamera3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        viewcamera4.layer.cornerRadius = 3
        viewcamera4.layer.borderWidth = 1
        viewcamera4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        viewcamera5.layer.cornerRadius = 3
        viewcamera5.layer.borderWidth = 1
        viewcamera5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        viewtextdescription.layer.cornerRadius = 3
        viewtextdescription.layer.borderWidth = 1
        viewtextdescription.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        btnissue.layer.cornerRadius = 25
        btnissue.layer.borderColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        btnissue.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        
        txtdescription.autocapitalizationType = .sentences
        txtdescription.autocapitalizationType = .words
        txtdescription.text = "Please describe the complaint in as much detail as possible, including: date, time, address(if not already entered), and any other information that will help our investigation."
        txtdescription.textColor = UIColor.lightGray
        
        txtsubject.placeholder = "Choose Subject"
        let placeholder = NSMutableAttributedString(
            string: "Choose Subject",
            attributes: [.font: UIFont(name: "Helvetica", size: 15.0)!,
                         .foregroundColor: #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
                         ])
        txtsubject.attributedPlaceholder = placeholder
        
        mainDropDown.selectedRowColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        mainDropDown.optionArray = CommercialArray
        mainDropDown.optionIds = ids
        mainDropDown.checkMarkEnabled = false
        
        txtdescription.delegate = self
        
        mainDropDown.didSelect{(selectedText , index , id) in
            self.txtsubject.text = selectedText
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        

        
    
        if onoff == "on"{
            
            btnissue.layer.cornerRadius = 25
            btnissue.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            
            txtFirstName.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            txtaddress.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            txtLastName.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            txtContectNumber.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        
            txtFirstName.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            txtaddress.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            txtLastName.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            txtContectNumber.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            txtFirstName.attributedPlaceholder = NSAttributedString(string: "First Name",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtaddress.attributedPlaceholder = NSAttributedString(string: "Email Address (optional)",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtLastName.attributedPlaceholder = NSAttributedString(string: "Last Name",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtContectNumber.attributedPlaceholder = NSAttributedString(string: "Contact Number",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            

            mainDropDown.rowBackgroundColor = AppConstant.ViewColor
            viewAddress.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblAddress.textColor = AppConstant.LabelWhiteColor
            lblDemerit.textColor = AppConstant.LabelWhiteColor
            
            lbllimit.textColor = AppConstant.LabelWhiteColor
            
  
        }else if onoff == "off"{
            
        }else{
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.LatitudeString = "\(locValue.latitude)"
        self.LongitudeString = "\(locValue.longitude)"
        
        print("LatitudeString==>\(LatitudeString ?? "")")
        print("LongitudeString==>\(LongitudeString ?? "")")
    }
    
    var MAX_LENGHTPhone = 10
    func Phonelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTPhone {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTPhone))
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtContectNumber{
            let MAX_LENGTH = 10
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else{
            return true
        }
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       if textField == self.txtContectNumber{
            self.Phonelenght(self.txtContectNumber)
            return true
        }
      
     return false
    }
    
    func updateCharacterCount() {
      
       let descriptionCount = self.txtdescription.text.count


       self.lbllimit.text = "\((0) + descriptionCount)/1000 characters left"
    }
    
    func checkRemainingChars() {
        
        let allowedChars = 1000
        
        let charsInTextView = -txtdescription.text.count
        
        let remainingChars = allowedChars + charsInTextView
        
        
        if remainingChars <= allowedChars {
            
            lbllimit.textColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            
        }
        
        if remainingChars <= 20 {
            
            lbllimit.textColor = UIColor.orange
            
        }
        
        if remainingChars <= 10 {
            
            lbllimit.textColor = UIColor.red
        }
        
        
        lbllimit.text = String("\(remainingChars)  " + "characters left")
        
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        checkRemainingChars()
    }
    
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
 
    func ShowLocation(lath:Double,Longh:Double){
        
            let camera = GMSCameraPosition.camera(withLatitude: lath, longitude: Longh, zoom: 10.0)
                CustomMapView.animate(to: camera)
            
            let sourceMarker = GMSMarker()
            
            sourceMarker.map = nil
            sourceMarker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lath), longitude: CLLocationDegrees(Longh))
            sourceMarker.icon = MarkerImage
            sourceMarker.map = self.CustomMapView
        
    }
    
    func validateFoodSafety() -> Bool {
        
    if self.txtsubject.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Please choose subject", duration: 0.3)
                return false
    }else if self.txtaddress.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please enter the email address", duration: 0.3)
                return false
    }else if self.txtFirstName.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please enter the first name.", duration: 0.3)
                return false
    }else if self.txtLastName.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please enter the last name.", duration: 0.3)
                return false
    }else if self.txtContectNumber.text!.count != 10{
        self.view.showToast(toastMessage: "Please enter the valid contact number.", duration: 0.3)
                  return false
    }
      return true
    }
    
    @IBAction func submit(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork(){
            if validateFoodSafety(){
                InspectionReportIssueApicall()
            }
        }else{
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
        

        
    }
    
    func InspectionReportIssueApicall() {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
  
        let parameters = [
            "ContactNumber":txtContectNumber.text ?? "",
            "Description":txtdescription.text ?? "",
            "Email":txtaddress.text ?? "",
            "EstablishmentNumber":"0",
            "FirstName":txtFirstName.text ?? "",
            "LastName":txtLastName.text ?? "",
            "Place":txtaddress.text ?? "",
            "ReceivedDevice":"1",
            "Section":"0",
            "Subject":txtsubject.text ?? "",
            "GPSX":LatitudeString ?? "",
            "GPSY":LongitudeString ?? "",
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
                     print("InspectionReportIssueApicall==> \(json)")
                                        
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
                        self.navigationController?.popViewController(animated: true)
                    }
                       
                    }
                    }
                    

                     
                 }catch{
                     print(error.localizedDescription)
                 }
                 
                 }

        task.resume()

    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func camera1action(_ sender: UIButton) {
        if arrayimage.count == 5{
            print("Count 5 Done!")
            let alertController = UIAlertController(title: "HCPH", message: "You can attach maximum five images.", preferredStyle: UIAlertController.Style.alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)


            self.present(alertController, animated: true, completion: nil)
        }else{
            let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    
                    let alertViewController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                            imagePicker.sourceType = .photoLibrary
                            self.present(imagePicker, animated: true, completion: nil)
                        })
                        let CameraLibraryAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                            //self.galleryVideo()
                            imagePicker.sourceType = .camera
                            self.present(imagePicker, animated: true, completion: nil)
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
    
    @IBAction func camera2action(_ sender: UIButton) {
        if arrayimage.count == 5{
            print("Count 5 Done!")
            let alertController = UIAlertController(title: "HCPH", message: "You can attach maximum five images.", preferredStyle: UIAlertController.Style.alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)


            self.present(alertController, animated: true, completion: nil)
        }else{
            let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    
                    let alertViewController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                            imagePicker.sourceType = .photoLibrary
                            self.present(imagePicker, animated: true, completion: nil)
                        })
                        let CameraLibraryAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                            //self.galleryVideo()
                            imagePicker.sourceType = .camera
                            self.present(imagePicker, animated: true, completion: nil)
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
    
    @IBAction func camera3action(_ sender: UIButton) {
        if arrayimage.count == 5{
            print("Count 5 Done!")
            let alertController = UIAlertController(title: "HCPH", message: "You can attach maximum five images.", preferredStyle: UIAlertController.Style.alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)


            self.present(alertController, animated: true, completion: nil)
        }else{
            let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    
                    let alertViewController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                            imagePicker.sourceType = .photoLibrary
                            self.present(imagePicker, animated: true, completion: nil)
                        })
                        let CameraLibraryAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                            //self.galleryVideo()
                            imagePicker.sourceType = .camera
                            self.present(imagePicker, animated: true, completion: nil)
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
    
    @IBAction func camera4action(_ sender: UIButton) {
        if arrayimage.count == 5{
            print("Count 5 Done!")
            let alertController = UIAlertController(title: "HCPH", message: "You can attach maximum five images.", preferredStyle: UIAlertController.Style.alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)


            self.present(alertController, animated: true, completion: nil)
        }else{
            let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    
                    let alertViewController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                            imagePicker.sourceType = .photoLibrary
                            self.present(imagePicker, animated: true, completion: nil)
                        })
                        let CameraLibraryAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                            //self.galleryVideo()
                            imagePicker.sourceType = .camera
                            self.present(imagePicker, animated: true, completion: nil)
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
    
    @IBAction func camera5action(_ sender: UIButton) {
        if arrayimage.count == 5{
            print("Count 5 Done!")
            let alertController = UIAlertController(title: "HCPH", message: "You can attach maximum five images.", preferredStyle: UIAlertController.Style.alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)


            self.present(alertController, animated: true, completion: nil)
        }else{
            let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    
                    let alertViewController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                            imagePicker.sourceType = .photoLibrary
                            self.present(imagePicker, animated: true, completion: nil)
                        })
                        let CameraLibraryAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                            //self.galleryVideo()
                            imagePicker.sourceType = .camera
                            self.present(imagePicker, animated: true, completion: nil)
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            
            let imageData: Data? = selectedImage.jpegData(compressionQuality: 0.4)
            let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
            //print("imageStr====>\(imageStr)")
            self.arrayimage.append(imageStr)
            
            if arrayimage.count == 1{
                print("Count 1")
                self.img1.image = selectedImage
                imagebuttonoutlate1.setBackgroundImage(nil, for: .normal)
                ImageBytesone = imageStr
            }else if arrayimage.count == 2{
                print("Count 2")
                self.img2.image = selectedImage
                imagebuttonoutlate2.setBackgroundImage(nil, for: .normal)
                ImageBytestwo = imageStr
            }else if arrayimage.count == 3{
                print("Count 3")
                self.img3.image = selectedImage
                imagebuttonoutlate3.setBackgroundImage(nil, for: .normal)
                ImageBytesthree = imageStr
            }else if arrayimage.count == 4{
                print("Count 4")
                self.img4.image = selectedImage
                imagebuttonoutlate4.setBackgroundImage(nil, for: .normal)
                ImageBytesfour = imageStr
            }else if arrayimage.count == 5{
                print("Count 5")
                self.img5.image = selectedImage
                imagebuttonoutlate5.setBackgroundImage(nil, for: .normal)
                ImageBytesfive = imageStr
            }
            
            dismiss(animated: true, completion: nil)
         
    }
        
    }
    
    
}
