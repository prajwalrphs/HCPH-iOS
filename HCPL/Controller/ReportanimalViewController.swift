
import UIKit
import iOSDropDown
import UICheckbox_Swift
import MobileCoreServices
import AVKit
import MBProgressHUD
import SwiftyJSON
import Alamofire
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import CoreLocation

class ReportanimalViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var mainDropDown: DropDown!
    @IBOutlet weak var check: UICheckbox!
    @IBOutlet weak var nofood: UICheckbox!
    @IBOutlet weak var cockfighting: UICheckbox!
    @IBOutlet weak var needsmedicalcare: UICheckbox!
    @IBOutlet weak var tethering: UICheckbox!
    @IBOutlet weak var noshelter: UICheckbox!
    @IBOutlet weak var hoardinganimals: UICheckbox!
    @IBOutlet weak var cruellyconfined: UICheckbox!
    @IBOutlet weak var dumpedanimal: UICheckbox!
    @IBOutlet weak var abandoned: UICheckbox!
    @IBOutlet weak var other: UICheckbox!
    @IBOutlet weak var dogfighting: UICheckbox!
    @IBOutlet weak var previously: UICheckbox!
    
    @IBOutlet weak var addimageview: UIView!
    @IBOutlet weak var addvideoview: UIView!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var addimagescollection: UICollectionView!
    @IBOutlet weak var addvideoscollection: UICollectionView!
    
    @IBOutlet weak var txtaddress: UITextField!
    @IBOutlet weak var txtaptnumber: UITextField!
    @IBOutlet weak var txtgatcode: UITextField!
    @IBOutlet weak var txtcity: UITextField!
    @IBOutlet weak var Statetxt: UITextField!
    @IBOutlet weak var txtzip: UITextField!
    @IBOutlet weak var txtcountry: UITextField!
    @IBOutlet weak var txtneighborhood: UITextField!
    @IBOutlet weak var txtnumberofanimal: UITextField!
    @IBOutlet weak var txttypeofanimal: UITextField!
    @IBOutlet weak var txtcolorofanimal: UITextField!
    @IBOutlet weak var txtanimalslocation: UITextField!
    @IBOutlet weak var txtfirstdate: UITextField!
    @IBOutlet weak var txtlastdate: UITextField!
    @IBOutlet var txtdescription: UITextView!
    
    @IBOutlet weak var txtagency: UITextField!
    @IBOutlet weak var txtfirstname: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtphone: UITextField!
    
    @IBOutlet var lbltypeofcruelty: UILabel!
    @IBOutlet weak var LimitLabel: UILabel!

    @IBOutlet var descriptionview: UIView!
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var view5: UIView!
    @IBOutlet var view6: UIView!
    @IBOutlet var view7: UIView!
    @IBOutlet var view8: UIView!
    @IBOutlet var view9: UIView!
    @IBOutlet var view10: UIView!
    @IBOutlet var view11: UIView!
    @IBOutlet var view12: UIView!
    @IBOutlet var view13: UIView!
    @IBOutlet var view14: UIView!
    @IBOutlet var view15: UIView!
    @IBOutlet var view16: UIView!
    @IBOutlet var view17: UIView!
    @IBOutlet var view18: UIView!
    @IBOutlet var view19: UIView!
    
    @IBOutlet var agencypreviouslyview: UIView!
    @IBOutlet var reportinformationview: UIView!
    @IBOutlet var alltextview: UIView!
    @IBOutlet var addimagevideoview: UIView!
    
    @IBOutlet var viewhideshow: UIView!
    
    //var FirsttoolBar = UIToolbar()
    var FirstdatePicker : UIDatePicker!
    
    var ImageBytesone:String?
    var ImageBytestwo:String?
    var ImageBytesthree:String?
    var ImageBytesfour:String?
    var ImageBytesfive:String?
    
    var CheckMB = [Int]()
    
    //var LasttoolBar = UIToolbar()
    var LastdatePicker : UIDatePicker!
    
    var Reportanimal:CommercialPoolsWelcome?
 
    var images: [Image] = []
    
    var arrayimage = [String]()

    var VideosongUrl : String!
    
    var arrOfFiles = [URL]()
    var arrOfFilesNames = [String]()
    var arrFiles = [URL]()
    var theItems = [URL]()
    var documentsUrl:URL!
    
    var videoURL : NSURL?
    
    var checkboxstring:String?
    var checkboxBool:String?
    var checkboxongoingBool:String?
    var ImagevideoUrl:String?
    var VideoBase64Url:String?
    
    var randomnumber:String!
    
    let imagePicker = UIImagePickerController()
        
    let countries = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","ldaho","illinois","lowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode island","south Carolina","south Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    let ids = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    var bytes = Array<UInt8>()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        CheckMB.removeAll()
        arrayimage.removeAll()
        
        self.addimageview.layer.cornerRadius = 5
        self.addimageview.layer.borderWidth = 1
        self.addimageview.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.addimageview.clipsToBounds = true
        
        self.addvideoview.layer.cornerRadius = 5
        self.addvideoview.layer.borderWidth = 1
        self.addvideoview.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.addvideoview.clipsToBounds = true
        
        txtaddress.autocapitalizationType = .sentences
        txtaddress.autocapitalizationType = .words
        
        txtaptnumber.autocapitalizationType = .sentences
        txtaptnumber.autocapitalizationType = .words
        
        txtgatcode.autocapitalizationType = .sentences
        txtgatcode.autocapitalizationType = .words
        
        txtcity.autocapitalizationType = .sentences
        txtcity.autocapitalizationType = .words
        
        txtcountry.autocapitalizationType = .sentences
        txtcountry.autocapitalizationType = .words
        
        txtneighborhood.autocapitalizationType = .sentences
        txtneighborhood.autocapitalizationType = .words
        
        txttypeofanimal.autocapitalizationType = .sentences
        txttypeofanimal.autocapitalizationType = .words
        
        txtcolorofanimal.autocapitalizationType = .sentences
        txtcolorofanimal.autocapitalizationType = .words
        
        txtanimalslocation.autocapitalizationType = .sentences
        txtanimalslocation.autocapitalizationType = .words
        
        txtfirstname.autocapitalizationType = .sentences
        txtfirstname.autocapitalizationType = .words
        
        txtlastname.autocapitalizationType = .sentences
        txtlastname.autocapitalizationType = .words
                
        txtdescription.autocapitalizationType = .sentences
        txtdescription.autocapitalizationType = .words
        //txtdescription.autocapitalizationType = .allCharacters
        txtdescription.text = "Description of Cruelty (Please fill out information in this field)"
        txtdescription.textColor = UIColor.lightGray

        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        
        if onoff == "on"{
            
            mainDropDown.rowBackgroundColor = AppConstant.ViewColor
            
            
            self.addimageview.layer.cornerRadius = 5
            self.addimageview.layer.borderWidth = 1
            self.addimageview.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            self.addimageview.clipsToBounds = true
            
            self.addvideoview.layer.cornerRadius = 5
            self.addvideoview.layer.borderWidth = 1
            self.addvideoview.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            self.addvideoview.clipsToBounds = true

        
            self.view1.backgroundColor = AppConstant.LabelWhiteColor
            self.view2.backgroundColor = AppConstant.LabelWhiteColor
            self.view3.backgroundColor = AppConstant.LabelWhiteColor
            self.view4.backgroundColor = AppConstant.LabelWhiteColor
            self.view5.backgroundColor = AppConstant.LabelWhiteColor
            self.view6.backgroundColor = AppConstant.LabelWhiteColor
            self.view7.backgroundColor = AppConstant.LabelWhiteColor
            self.view8.backgroundColor = AppConstant.LabelWhiteColor
            self.view9.backgroundColor = AppConstant.LabelWhiteColor
            self.view10.backgroundColor = AppConstant.LabelWhiteColor
            self.view11.backgroundColor = AppConstant.LabelWhiteColor
            self.view12.backgroundColor = AppConstant.LabelWhiteColor
            self.view13.backgroundColor = AppConstant.LabelWhiteColor
            //self.view14.backgroundColor = AppConstant.LabelWhiteColor
            self.view15.backgroundColor = AppConstant.LabelWhiteColor
            self.view16.backgroundColor = AppConstant.LabelWhiteColor
            self.view17.backgroundColor = AppConstant.LabelWhiteColor
            self.view18.backgroundColor = AppConstant.LabelWhiteColor
            self.view19.backgroundColor = AppConstant.LabelWhiteColor


            self.lbltypeofcruelty.textColor = AppConstant.LabelWhiteColor
       
            txtaddress.attributedPlaceholder = NSAttributedString(string: "Address*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtaptnumber.attributedPlaceholder = NSAttributedString(string: "Apt. Number",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtgatcode.attributedPlaceholder = NSAttributedString(string: "Gate Code",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtcity.attributedPlaceholder = NSAttributedString(string: "City",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            Statetxt.attributedPlaceholder = NSAttributedString(string: "-- State --",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtzip.attributedPlaceholder = NSAttributedString(string: "Zip",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtcountry.attributedPlaceholder = NSAttributedString(string: "County",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtneighborhood.attributedPlaceholder = NSAttributedString(string: "Neighborhood",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtnumberofanimal.attributedPlaceholder = NSAttributedString(string: "Number of Animals",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txttypeofanimal.attributedPlaceholder = NSAttributedString(string: "Types of Animals",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])

            txtcolorofanimal.attributedPlaceholder = NSAttributedString(string: "Colors of Animals",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtanimalslocation.attributedPlaceholder = NSAttributedString(string: "Where on the property is the animal(s) located?",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtfirstdate.attributedPlaceholder = NSAttributedString(string: "Date First Observed",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtlastdate.attributedPlaceholder = NSAttributedString(string: "Date Last Observed",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
//            txtdescription.attributedPlaceholder = NSAttributedString(string: "  Description of Cruelty (Please fill out information in this field)",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtagency.attributedPlaceholder = NSAttributedString(string: "Agency Previously to (if applicable).",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtfirstname.attributedPlaceholder = NSAttributedString(string: "First Name",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtlastname.attributedPlaceholder = NSAttributedString(string: "Last Name",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtemail.attributedPlaceholder = NSAttributedString(string: "Email*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            txtphone.attributedPlaceholder = NSAttributedString(string: "Phone",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
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
        clearAllFile()
        
        txtfirstdate.delegate = self
        txtlastdate.delegate = self
        txtaptnumber.delegate = self
        txtaddress.delegate = self
        txtgatcode.delegate = self
        txtcity.delegate = self
        txtzip.delegate = self
        txtcountry.delegate = self
        txtneighborhood.delegate = self
        txttypeofanimal.delegate = self
        txtcolorofanimal.delegate = self
        txtanimalslocation.delegate = self
        txtanimalslocation.delegate = self
        txtdescription.delegate = self
        txtagency.delegate = self
        txtfirstname.delegate = self
        txtlastname.delegate = self
        txtemail.delegate = self
        txtphone.delegate = self
        
        descriptionview.layer.cornerRadius = 5
        descriptionview.layer.borderWidth = 1
        descriptionview.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        checkboxstring = ""
        checkboxBool = ""
        checkboxongoingBool = ""
        ImagevideoUrl = ""
        VideoBase64Url = ""
        
        mainDropDown.selectedRowColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
        mainDropDown.optionArray = countries
        mainDropDown.optionIds = ids
        mainDropDown.checkMarkEnabled = false
        
        mainDropDown.didSelect{(selectedText , index , id) in
            self.Statetxt.text = selectedText
        }
        
        self.submit.layer.cornerRadius = 20
        

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
        
    }
    
  
    func pickUpDate(_ textField : UITextField){

           self.FirstdatePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
           self.FirstdatePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           self.FirstdatePicker.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            self.FirstdatePicker?.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
           //self.FirstdatePicker.tintColor = #colorLiteral(red: 0.1688283401, green: 0.6115575723, blue: 1, alpha: 1)

           textField.inputView = self.FirstdatePicker

           let toolBar = UIToolbar()
           toolBar.barStyle = .default
           toolBar.isTranslucent = true
           toolBar.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
            print("onoff==>\(onoff ?? "")")
            
            if onoff == "on"{
                toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                toolBar.tintColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            }

           
           toolBar.sizeToFit()

           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
           toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
           toolBar.isUserInteractionEnabled = true
           textField.inputAccessoryView = toolBar

       }
       
       @objc func doneClick() {
           let dateFormatter1 = DateFormatter()
           dateFormatter1.dateFormat = "MM/dd/yyyy"
           self.txtfirstdate.text = dateFormatter1.string(from: FirstdatePicker.date)
           txtfirstdate.resignFirstResponder()
       }
       
      @objc func cancelClick() {
        txtfirstdate.resignFirstResponder()
       }
    
    func pickUpDatelast(_ textField : UITextField){

           self.LastdatePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
           self.LastdatePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           self.LastdatePicker.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            self.LastdatePicker?.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
           //self.LastdatePicker.tintColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)

           textField.inputView = self.LastdatePicker

           let toolBar = UIToolbar()
           toolBar.barStyle = .default
           toolBar.isTranslucent = true
           toolBar.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
            print("onoff==>\(onoff ?? "")")
            
            if onoff == "on"{
                toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                toolBar.tintColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
            }
           toolBar.sizeToFit()

           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClickLast))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClickLast))
           toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
           toolBar.isUserInteractionEnabled = true
           textField.inputAccessoryView = toolBar

       }

    @objc func doneClickLast() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MM/dd/yyyy"
        self.txtlastdate.text = dateFormatter1.string(from: LastdatePicker.date)
        txtlastdate.resignFirstResponder()
    }
    
   @objc func cancelClickLast() {
     txtlastdate.resignFirstResponder()
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
            textView.text = "Description of Cruelty (Please fill out information in this field)"
            textView.textColor = UIColor.lightGray
        }
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtfirstdate {
             self.pickUpDate(self.txtfirstdate)
            return true
        }else if textField == self.txtlastdate{
            self.pickUpDatelast(self.txtlastdate)
            return true
        }else if textField == self.txtaptnumber{
            self.aptnumberlenght(self.txtaptnumber)
            return true
        }else if textField == self.txtaddress{
            self.Addresslenght(self.txtaddress)
            return true
        }else if textField == self.txtgatcode{
            self.Getcodelenght(self.txtgatcode)
            return true
        }else if textField == self.txtcity{
            self.Citylenght(self.txtgatcode)
            return true
        }else if textField == self.txtzip{
            self.Zipcodelenght(self.txtzip)
            return true
        }else if textField == self.txtcountry{
            self.Countylenght(self.txtcountry)
            return true
        }else if textField == self.txtneighborhood{
            self.Neighborhoodlenght(self.txtneighborhood)
            return true
        }else if textField == self.txttypeofanimal{
            self.Typeofanimallenght(self.txttypeofanimal)
            return true
        }else if textField == self.txtcolorofanimal{
            self.Colorofanimallenght(self.txtcolorofanimal)
            return true
        }else if textField == self.txtanimalslocation{
            self.AnimalLocationlenght(self.txtanimalslocation)
            return true
        }else if textField == self.txtagency{
            self.Agencylenght(self.txtagency)
            return true
        }else if textField == self.txtfirstname{
            self.Firstnamelenght(self.txtfirstname)
            return true
        }else if textField == self.txtlastname{
            self.Lastnamelenght(self.txtlastname)
            return true
        }else if textField == self.txtemail{
            self.Emaillenght(self.txtemail)
            return true
        }else if textField == self.txtphone{
            self.Phonelenght(self.txtphone)
            return true
        }
      
     return false
    }
    
    var MAX_LENGHT = 20
    func aptnumberlenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHT {
            textField.text = String(text.dropLast(text.count - MAX_LENGHT))
            return
        }
    }
    
    var MAX_LENGHTAddress = 100
    func Addresslenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTAddress {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTAddress))
            return
        }
    }
    
    var MAX_LENGHTGetcode = 20
    func Getcodelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTGetcode {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTGetcode))
            return
        }
    }
    
    var MAX_LENGHTCity = 50
    func Citylenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTCity {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTCity))
            return
        }
    }
    
    var MAX_LENGHTZipcode = 20
    func Zipcodelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTZipcode {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTZipcode))
            return
        }
    }
    
    var MAX_LENGHTCounty = 50
    func Countylenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTCounty {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTCounty))
            return
        }
    }
    
    var MAX_LENGHTNeighborhood = 100
    func Neighborhoodlenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTNeighborhood {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTNeighborhood))
            return
        }
    }

    var MAX_LENGHTTypeofanimal = 500
    func Typeofanimallenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTTypeofanimal {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTTypeofanimal))
            return
        }
    }
    
    
    var MAX_LENGHTColorofanimal = 500
    func Colorofanimallenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTColorofanimal {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTColorofanimal))
            return
        }
    }
    
    var MAX_LENGHTAnimalLocation = 500
    func AnimalLocationlenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTAnimalLocation {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTAnimalLocation))
            return
        }
    }
    
    var MAX_LENGHTDescription = 1000
    func Descriptionlenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTDescription {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTDescription))
            return
        }
    }
    
    var MAX_LENGHTAgency = 100
    func Agencylenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTAgency {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTAgency))
            return
        }
    }
    
    var MAX_LENGHTFirstname = 100
    func Firstnamelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTFirstname {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTFirstname))
            return
        }
    }
    
    var MAX_LENGHTLastname = 100
    func Lastnamelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTLastname {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTLastname))
            return
        }
    }
    
    var MAX_LENGHTEmail = 250
    func Emaillenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTEmail {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTEmail))
            return
        }
    }
    
    var MAX_LENGHTPhone = 10
    func Phonelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTPhone {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTPhone))
            return
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtaptnumber{
            let MAX_LENGTH = 20
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtaddress{
            let MAX_LENGTH = 100
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtgatcode{
            let MAX_LENGTH = 20
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtcity{
            let MAX_LENGTH = 50
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtzip{
            let MAX_LENGTH = 20
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtcountry{
            let MAX_LENGTH = 50
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtneighborhood{
            let MAX_LENGTH = 100
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txttypeofanimal{
            let MAX_LENGTH = 500
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtcolorofanimal{
            let MAX_LENGTH = 500
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtanimalslocation{
            let MAX_LENGTH = 500
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtdescription{
            let MAX_LENGTH = 1000
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtagency{
            let MAX_LENGTH = 100
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtfirstname{
            let MAX_LENGTH = 100
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtlastname{
            let MAX_LENGTH = 100
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtemail{
            let MAX_LENGTH = 250
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else if textField == txtphone{
            let MAX_LENGTH = 10
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else{
            return true
        }
        }
    
    func clearAllFile() {
        let fileManager = FileManager.default
        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            try fileManager.removeItem(at: myDocuments)
        } catch {
            return
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Going(_ sender: UICheckbox) {
        print("Going value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxongoingBool?.append("true")
        }else{
            print("false")
        }
    }
    
    @IBAction func nofoodbutton(_ sender: UICheckbox) {
        print("nofoodbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("No Food/Water,")
        }else{
            print("false")
        }
    }
    
    @IBAction func cockfightingbutton(_ sender: UICheckbox) {
        print("cockfightingbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("Cock Fighting,")
        }else{
            print("false")
        }
    }
    
    @IBAction func medicalcarebutton(_ sender: UICheckbox) {
        print("medicalcarebutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("Needs Medical Care,")
        }else{
            print("false")
        }
    }
    
    @IBAction func tetheringbutton(_ sender: UICheckbox) {
        print("tetheringbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("Tethering,")
        }else{
            print("false")
        }
    }
    
    @IBAction func noshelterbutton(_ sender: UICheckbox) {
        print("noshelterbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("No Shelter,")
        }else{
            print("false")
        }
    }
    
    @IBAction func hoardingbutton(_ sender: UICheckbox) {
        print("hoardingbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("Hoarding Animals,")
        }else{
            print("false")
        }
    }
    
    @IBAction func cruellybutton(_ sender: UICheckbox) {
        print("cruellybutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("Cruelly Confined,")
        }else{
            print("false")
        }
    }
    
    @IBAction func dumpedbutton(_ sender: UICheckbox) {
        print("dumpedbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("Dumped Animal,")
        }else{
            print("false")
        }
    }
    
    @IBAction func abandonedbutton(_ sender: UICheckbox) {
        print("abandonedbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("Abandoned,")
        }else{
            print("false")
        }
    }
    
    @IBAction func otherbutton(_ sender: UICheckbox) {
        print("otherbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("Other,")
        }else{
            print("false")
        }
    }
    
    @IBAction func dogfightingbutton(_ sender: UICheckbox) {
        print("dogfightingbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append("Dog Fighting,")
        }else{
            print("false")
        }
    }
    
    @IBAction func agencybutton(_ sender: UICheckbox) {
        print("agencybutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxBool = "true"
            txtagency.isHidden = false
            viewhideshow.isHidden = false
            DownView()
        }else{
            print("false")
            self.checkboxBool = "false"
            txtagency.isHidden = true
            viewhideshow.isHidden = true
            UpView()
        }
    }
    
    func UpView(){

        UIView.animate(withDuration: 1, delay: 0, options: [.beginFromCurrentState],
                          animations: {
                         
                        self.agencypreviouslyview.frame.origin.y = 1152
                        self.reportinformationview.frame.origin.y = 1151
                        self.alltextview.frame.origin.y = 1205
                        self.addimagevideoview.frame.origin.y = 1460
                        self.view.layoutIfNeeded()
           }, completion: nil)
    }
    
    func DownView(){

        UIView.animate(withDuration: 1, delay: 0, options: [.beginFromCurrentState],
                          animations: {
                         
                        self.agencypreviouslyview.frame.origin.y = 1152
                        self.reportinformationview.frame.origin.y = 1205
                        self.alltextview.frame.origin.y = 1258
                        self.addimagevideoview.frame.origin.y = 1508
                        self.view.layoutIfNeeded()
           }, completion: nil)
    }
    
    func validate() -> Bool {
     if self.txtaddress.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please enter the valid address", duration: 0.3)
                return false
    }else if self.txtemail.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Please enter the valid email", duration: 0.3)
                  return false
    }else if self.isValidEmail(testStr: txtemail.text!) == false{
        self.view.showToast(toastMessage: "Please enter the valid email", duration: 0.3)
        return false
    }
      return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func submitebutton(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            if validate(){
                
                if self.checkboxBool == "true"{
                    if self.txtagency.text?.isEmpty ?? true {
                        self.view.showToast(toastMessage: "Please provide agency previously report", duration: 0.3)
                    }else{
                        ReportAnimalApicall()
                    }
                }else{
                    ReportAnimalApicall()
                }
                
//                else if checkboxstring == "false"{
//                    print("Test")
//                    //ReportAnimalApicall()
//                }else{
//                    //ReportAnimalApicall()
//                }
              
            }else{
                print("Testtwo")
            }
        }else{
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
    }
    
    
    func ReportAnimalApicall() {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
        
        var parameters = [String : Any]()
        
        if txtdescription.text == "Description of Cruelty (Please fill out information in this field)"{
            
//            if ImageBytestwo?.isEmpty ?? true{
//                print("isEmpty true")
//            }else{
//                print("Not isEmpty")
//            }
             parameters = [
                "violatorAddress":txtaddress.text as Any,
                "violatorAptNum":txtaptnumber.text as Any,
                "ViolatorGateCode":txtgatcode.text as Any,
                "ViolatorCity":txtcity.text as Any,
                "ViolatorState":Statetxt.text as Any,
                "ViolatorZip":txtzip.text as Any,
                "ViolatorCounty":txtcountry.text as Any,
                "ViolatorNeighborhood":txtneighborhood.text as Any,
                "TypeOfAnimals":txttypeofanimal.text as Any,
                "NumberOfAnimals":txtnumberofanimal.text as Any,
                "ColorOfAnimals":txtcolorofanimal.text as Any,
                "PropertyLocation":txtanimalslocation.text as Any,
                "FirstObservationDt":txtfirstdate.text as Any,
                "LastObservationDt":txtlastdate.text as Any,
                "CrueltyOngoing":checkboxongoingBool as Any,
                "CrueltyType":checkboxstring as Any,
                "CrueltyDesc":"0",
                "PreviousReport":checkboxBool as Any,
                "PreviousAgencyDesc":txtagency.text as Any,
                "ReporterFirstName":txtfirstname.text as Any,
                "ReporterLastName":txtlastname.text as Any,
                "reporterphone":txtphone.text as Any,
                "reporteremail":txtemail.text as Any,
                "ReceivedDevice":"0",
            ] as [String : Any]
//            "ImageBytes":ImageBytesone ?? "",
//            "ImageBytes2":ImageBytestwo ?? "",
//            "ImageBytes3":ImageBytesthree ?? "",
//            "ImageBytes4":ImageBytesfour ?? "",
//            "ImageBytes5":ImageBytesfive ?? "",
            
            if ImageBytesone?.isEmpty ?? true{
                parameters.removeValue(forKey: "ImageBytes")
            }else{
                parameters.updateValue(ImageBytesone ?? "", forKey: "ImageBytes")
            }

            if ImageBytestwo?.isEmpty ?? true{
                parameters.removeValue(forKey: "ImageBytes2")
            }else{
                parameters.updateValue(ImageBytestwo ?? "", forKey: "ImageBytes2")
            }

            if ImageBytesthree?.isEmpty ?? true{
                parameters.removeValue(forKey: "ImageBytes3")
            }else{
                parameters.updateValue(ImageBytesthree ?? "", forKey: "ImageBytes3")
            }

            if ImageBytesfour?.isEmpty ?? true{
                parameters.removeValue(forKey: "ImageBytes4")
            }else{
                parameters.updateValue(ImageBytesfour ?? "", forKey: "ImageBytes4")
            }

            if ImageBytesfive?.isEmpty ?? true{
                parameters.removeValue(forKey: "ImageBytes5")
            }else{
                parameters.updateValue(ImageBytesfive ?? "", forKey: "ImageBytes5")
            }
            
            
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)


            let url = URL(string: "https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/UploadVPHComplaint")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

                     guard let data = data else { return }
                     do{
                         let json = try JSON(data:data)
                         print("ReportAnimalApicall==> \(json)")

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
                            self.Reportanimal = try decoder.decode(CommercialPoolsWelcome.self, from: data)


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
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                     }

                     }

            task.resume()
        }else{
            
            var parameters = [String : Any]()
            
            parameters = [
               "violatorAddress":txtaddress.text as Any,
               "violatorAptNum":txtaptnumber.text as Any,
               "ViolatorGateCode":txtgatcode.text as Any,
               "ViolatorCity":txtcity.text as Any,
               "ViolatorState":Statetxt.text as Any,
               "ViolatorZip":txtzip.text as Any,
               "ViolatorCounty":txtcountry.text as Any,
               "ViolatorNeighborhood":txtneighborhood.text as Any,
               "TypeOfAnimals":txttypeofanimal.text as Any,
               "NumberOfAnimals":txtnumberofanimal.text as Any,
               "ColorOfAnimals":txtcolorofanimal.text as Any,
               "PropertyLocation":txtanimalslocation.text as Any,
               "FirstObservationDt":txtfirstdate.text as Any,
               "LastObservationDt":txtlastdate.text as Any,
               "CrueltyOngoing":checkboxongoingBool as Any,
               "CrueltyType":checkboxstring as Any,
               "CrueltyDesc":txtdescription.text ?? "",
               "PreviousReport":checkboxBool as Any,
               "PreviousAgencyDesc":txtagency.text as Any,
               "ReporterFirstName":txtfirstname.text as Any,
               "ReporterLastName":txtlastname.text as Any,
               "reporterphone":txtphone.text as Any,
               "reporteremail":txtemail.text as Any,
               "ReceivedDevice":"0",
           ] as [String : Any]
//            "ImageBytes":ImageBytesone ?? "",
//            "ImageBytes2":ImageBytestwo ?? "",
//            "ImageBytes3":ImageBytesthree ?? "",
//            "ImageBytes4":ImageBytesfour ?? "",
//            "ImageBytes5":ImageBytesfive ?? "",
           
           if ImageBytesone?.isEmpty ?? true{
               parameters.removeValue(forKey: "ImageBytes")
           }else{
               parameters.updateValue(ImageBytesone ?? "", forKey: "ImageBytes")
           }

           if ImageBytestwo?.isEmpty ?? true{
               parameters.removeValue(forKey: "ImageBytes2")
           }else{
               parameters.updateValue(ImageBytestwo ?? "", forKey: "ImageBytes2")
           }

           if ImageBytesthree?.isEmpty ?? true{
               parameters.removeValue(forKey: "ImageBytes3")
           }else{
               parameters.updateValue(ImageBytesthree ?? "", forKey: "ImageBytes3")
           }

           if ImageBytesfour?.isEmpty ?? true{
               parameters.removeValue(forKey: "ImageBytes4")
           }else{
               parameters.updateValue(ImageBytesfour ?? "", forKey: "ImageBytes4")
           }

           if ImageBytesfive?.isEmpty ?? true{
               parameters.removeValue(forKey: "ImageBytes5")
           }else{
               parameters.updateValue(ImageBytesfive ?? "", forKey: "ImageBytes5")
           }
            
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)


            let url = URL(string: "https://appsqa.harriscountytx.gov/QAPublicHealthPortal/api/UploadVPHComplaint")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

                     guard let data = data else { return }
                     do{
                         let json = try JSON(data:data)
                         print("ReportAnimalApicall==> \(json)")

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
                            self.Reportanimal = try decoder.decode(CommercialPoolsWelcome.self, from: data)


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
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                     }

                     }

            task.resume()
        }
        
        

    }
    
    @IBAction func addimages(_ sender: UIButton) {
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
                            imagePicker.allowsEditing = true
                            self.present(imagePicker, animated: true, completion: nil)
                        })
                        let CameraLibraryAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                            //self.galleryVideo()
                            imagePicker.sourceType = .camera
                            imagePicker.allowsEditing = true
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

            let image = Image(imageData: selectedImage.pngData()!)
            images.append(image)
            
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
                
               
                Image.saveImages(images)
                dismiss(animated: true, completion: nil)
                self.addimagescollection.reloadData()
                
    //            let imageData: Data? = selectedImage.jpegData(compressionQuality: 0.4)
    //            let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
    //            self.ImagevideoUrl?.append(imageStr)
                
                let dataa = selectedImage.jpegData(compressionQuality: 0.4)
                
//                let options: NSDictionary = [:]
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
                    
                   
                    //let imageData2:Data =  selectedImage.pngData()!
                    let base64String2 = datos.base64EncodedString()
                    
                    self.arrayimage.append(base64String2)
                    
                    //self.ImagevideoUrl?.append(base64String2)
                    
                    if self.arrayimage.count == 1{
                        print("Count 1")
                        self.ImageBytesone = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                    }else if self.arrayimage.count == 2{
                        print("Count 2")
                        self.ImageBytestwo = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                    }else if self.arrayimage.count == 3{
                        print("Count 3")
                        self.ImageBytesthree = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                    }else if self.arrayimage.count == 4{
                        print("Count 4")
                        self.ImageBytesfour = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                    }else if self.arrayimage.count == 5{
                        print("Count 5")
                        self.ImageBytesfive = base64String2
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
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
        
        
        
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
   
            
            let asset = AVAsset(url: videoUrl as URL)

            let duration = asset.duration
            let durationTime = CMTimeGetSeconds(duration)
            print("durationTime==>\(durationTime)")

            if durationTime >= 5.00{
                
                DispatchQueue.main.async {
             
                  let alertController = UIAlertController(title: "Dear User", message: "Video is longer than 5 seconds.", preferredStyle: UIAlertController.Style.alert)
                    
            
                    let cancelAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel)
                    alertController.addAction(cancelAction)
                                        
                    self.present(alertController, animated: true, completion: nil)
                }
                
                
    
            }else{
                 
                self.VideosongUrl = "\(videoUrl)"
                
                if let base64Str = VideosongUrl.base64Encoded() {
                    print("Base64 encoded string: \"\(base64Str)\"")
                    //VideoBase64Url = base64Str
                    self.VideoBase64Url?.append(base64Str)
                    if let trs = base64Str.base64Decoded() {
                        print("Base64 decoded string: \"\(trs)\"")
                    }
                }
                
                let randomDouble = Double.random(in: 2.71828...3.14159)
                
                self.randomnumber = "\(randomDouble)"
                downloadVideo(videoImageUrl: VideosongUrl, videoname: randomnumber)
                    let data = NSData(contentsOf: videoUrl as URL)!
                    print("File size before compression: \(Double(data.length / 1048576)) mb")
                let seconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    // Put your code which should be executed with a delay here
                    self.getFiles()
                }
                
            }
            

            }
            else{
                print("Something went wrong in  video")
            }
         self.dismiss(animated: true, completion: nil)
        
        
        
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
    
    
       func showPermissionAlert(){
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    

        func getFiles() {
            
            let strExtention = "mp4"
            
         
//            let idlogin = UserDefaults.standard.string(forKey: AppConstant.KEY_USER_ID)
//             print("idlogin=>\(idlogin ?? "")")
              
              let FolderName = "\("1")" + "/VideoName"
            
            // Get the document directory url
            self.documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                
                if let dirPath          = paths.first
                {
                    
                     self.documentsUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(FolderName)

                    print("strExtention ==>\(strExtention)")

                    do {
                        theItems = try FileManager.default.contentsOfDirectory(at:  self.documentsUrl, includingPropertiesForKeys: nil)
                        print("theItems====>\(theItems)")
                        self.arrFiles = theItems.filter{ $0.pathExtension == strExtention }
                                  print("\(strExtention) urls:",arrFiles)
                                 // print("strExtention ==>\(strExtention)")
                                  print("arrFiles ==>\(arrFiles)")
                            

                        if arrFiles.count > 0 {
                                       self.arrOfFiles = arrFiles
                                       let arrFileNames = arrFiles.map{ $0.deletingPathExtension().lastPathComponent }
                                       print("\(strExtention) list:", arrFileNames)
                                     //  print("strExtentionsecond ==>\(strExtention)")
                                       print("arrFileNamessecond ==>\(arrFiles)")

                                       self.arrOfFilesNames = arrFileNames
                            self.addvideoscollection.reloadData()
                                   }
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            
        }
    
        func downloadVideo(videoImageUrl:String,videoname:String) {
            
            

            let task = DownloadManager.shared.activate().downloadTask(with: URL(string: videoImageUrl)!)
            task.resume()
                                   
            
            let trimstr = String(videoname.filter { !" \n\t\r".contains($0) })
            
            let trimstrnew = trimstr + ".mp4"
            
            print("videoImageUrl=\(videoImageUrl)")
            let sampleURL = videoImageUrl
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: sampleURL), let urlData = NSData(contentsOf: url) {
                    
                  //  let galleryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                    
//                    let idlogin = UserDefaults.standard.string(forKey: AppConstant.KEY_USER_ID)
//
//                    print("idlogin=>\(idlogin ?? "")")
                                   
                    let galleryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];

                    let filePath1 = "\(galleryPath)/"
                    let filePath = filePath1 + trimstrnew
                    
                    print("galleryPath==>\(trimstrnew)")
                    print("filePath==>\(filePath)")
                    
                    
                    //new code
                    
                    let fileManager = FileManager.default
                    if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                        
//                        let idlogin = UserDefaults.standard.string(forKey: AppConstant.KEY_USER_ID)
//                       print("idlogin=>\(idlogin ?? "")")
                        
                        let FolderName = "\("1")" + "/VideoName"
                        
                        let filePath =  tDocumentDirectory.appendingPathComponent(FolderName)
                       
                        if !fileManager.fileExists(atPath: filePath.path) {
                            do {
                                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                            } catch {
                                print("Couldn't create document directory")
                            }
                        }
                        print("Document directory is \(filePath)")
                        //SVProgressHUD.dismiss()
                        
                        DispatchQueue.main.async {

                            let videoFilename = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                                + "/" + FolderName + "/" + trimstrnew

                            print("videoFilename==>\(videoFilename)")

                            urlData.write(toFile: videoFilename, atomically: true)

                            
                        }
                    }
                    
                }
            }
        }
    
    func videoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func generateThumbnail(path: URL) -> UIImage? {
        
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 30), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            print("thumbnail==>\(thumbnail)")
            
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    @IBAction func addvideo(_ sender: UIButton) {
        
                imagePicker.delegate = self
                
                let alertViewController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let photoLibraryAction = UIAlertAction(title: "Video Library", style: .default, handler: { action in
                        //imagePicker.sourceType = .photoLibrary
                        self.videoLibrary()
                        //self.present(imagePicker, animated: true, completion: nil)
                    })
                 
                    alertViewController.addAction(photoLibraryAction)
                }
        alertViewController.addAction(cancelAction)
                present(alertViewController, animated: true, completion: nil)
                
                alertViewController.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
                    return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
                    }.first?.isActive = false
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == addimagescollection{
            return images.count
        }else{
            return arrOfFiles.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == addimagescollection{
        let cell:ReportCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportCollectionViewCell", for: indexPath) as! ReportCollectionViewCell
            cell.lazyImageView.image = UIImage(data:images[indexPath.row].imageData!)
            return cell
        }else{
            let cell:videoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCollectionViewCell", for: indexPath) as! videoCollectionViewCell
            cell.videoimage.image = generateThumbnail(path: arrOfFiles[indexPath.row])
            return cell
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == addimagescollection{
            print("index:==>\(indexPath.row)")
            showDeleteWarningimage(for: indexPath)
        }else{
            print("index:==>\(indexPath.row)")
            showDeleteWarningvideo(for: indexPath)
            
        }

    }
    
    
    func showDeleteWarningvideo(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "HCPH", message: "Are you sure want to delete this video?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let deleteAction = UIAlertAction(title: "OK", style: .destructive) { _ in
            DispatchQueue.main.async {
                self.removevideos(index: indexPath.row, urlmain: self.arrOfFiles[indexPath.row].absoluteURL)
            }
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        present(alert, animated: true, completion: nil)
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
        addimagescollection.performBatchUpdates({
            self.addimagescollection.deleteItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
            self.addimagescollection.reloadItems(at: self.addimagescollection.indexPathsForVisibleItems)
        })
        
        print("images==>\(images)")
    }
    
    func removevideos(index: Int, urlmain: URL) {
        arrOfFiles.remove(at: index)
        let lastpath = urlmain.lastPathComponent
        print("lastpath===>\(lastpath)")
        removeallvideo(fileExtension: lastpath)
        let indexPath = IndexPath(row: index, section: 0)
        addvideoscollection.performBatchUpdates({
            self.addvideoscollection.deleteItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
            self.addvideoscollection.reloadItems(at: self.addvideoscollection.indexPathsForVisibleItems)
        })
        
        print("arrOfFiles==>\(arrOfFiles)")
    }
    
    func removeallvideo(fileExtension: String) {
    let fileManager = FileManager.default
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
    guard let dirPath = paths.first else {
        return
    }
    let filePath = "\(dirPath)/\("\("1")" + "/VideoName/")/\(fileExtension)"
        print("filePathRemove===>\(filePath)")
    do {
      try fileManager.removeItem(atPath: filePath)
        print("filePathRemove===>\(filePath)")
    } catch let error as NSError {
      print(error.debugDescription)
    }}
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            if textField == txtaddress {
                txtaptnumber.becomeFirstResponder()
            } else if textField == txtaptnumber {
                txtgatcode.becomeFirstResponder()
            } else if textField == txtgatcode {
                txtcity.becomeFirstResponder()
            } else if textField == txtcity {
                Statetxt.becomeFirstResponder()
            } else if textField == Statetxt {
                txtzip.becomeFirstResponder()
            } else if textField == txtzip {
                txtcountry.becomeFirstResponder()
            }else if textField == txtcountry{
                txtneighborhood.becomeFirstResponder()
            }else if textField == txtneighborhood{
                txtnumberofanimal.becomeFirstResponder()
            }else if textField == txtnumberofanimal{
                txttypeofanimal.becomeFirstResponder()
            }else if textField == txttypeofanimal{
                txtcolorofanimal.becomeFirstResponder()
            }else if textField == txtcolorofanimal{
                txtanimalslocation.becomeFirstResponder()
            }else if textField == txtanimalslocation{
                txtanimalslocation.resignFirstResponder()
            }else if textField == txtfirstname{
                txtlastname.becomeFirstResponder()
            }else if textField == txtlastname{
                txtemail.becomeFirstResponder()
            }else if textField == txtemail{
                txtphone.becomeFirstResponder()
            }else{
                txtphone.resignFirstResponder()
            }
            return true
        }
         
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
             
     self.view.endEditing(true)
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
    
}

class Image: Codable {
    var imageData: Data?
    
    init(imageData: Data) {
        self.imageData = imageData
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Image").appendingPathExtension("plist")
    
    
    static func loadImages() -> [Image]? {
        guard let codedImages = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        print("DocumentsDirectory==>\(DocumentsDirectory)")
        print("ArchiveURL==>\(ArchiveURL)")
        return try? propertyListDecoder.decode(Array<Image>.self, from: codedImages)

    }
    
    static func loadSampleImages() -> [Image] {
        return []
    }
    
    static func saveImages(_ images: [Image]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedImages = try? propertyListEncoder.encode(images)
        try? codedImages?.write(to: ArchiveURL, options: .noFileProtection)
        print("DocumentsDirectory==>\(DocumentsDirectory)")
        print("ArchiveURL==>\(ArchiveURL)")
    }
    
    
}

extension ReportanimalViewController{
    func hideKeyboardTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension String {
//: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

//: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}


