//
//  ReportanimalViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 04/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import iOSDropDown
import UICheckbox_Swift
import MobileCoreServices
import AVKit
import MBProgressHUD
import SwiftyJSON
import Alamofire

class ReportanimalViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{

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
    @IBOutlet weak var txtdescription: UITextField!
    @IBOutlet weak var txtagency: UITextField!
    @IBOutlet weak var txtfirstname: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtphone: UITextField!
    
    
    //var FirsttoolBar = UIToolbar()
    var FirstdatePicker : UIDatePicker!
    
    //var LasttoolBar = UIToolbar()
    var LastdatePicker : UIDatePicker!
    
    var Reportanimal:CommercialPoolsWelcome?
 
    var images: [Image] = []

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
    
    var randomnumber:String!
    
    var maxLen:Int = 20;
    
    let countries = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","ldaho","illinois","lowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode island","south Carolina","south Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    let ids = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.hideKeyboardTappedAround()
        clearAllFile()
        txtfirstdate.delegate = self
        txtlastdate.delegate = self
        checkboxstring = ""
        checkboxBool = ""
        checkboxongoingBool = ""
        ImagevideoUrl = ""
        
        mainDropDown.optionArray = countries
        mainDropDown.optionIds = ids
        mainDropDown.checkMarkEnabled = false
        
        mainDropDown.didSelect{(selectedText , index , id) in
            self.Statetxt.text = selectedText
        }
        
        self.submit.layer.cornerRadius = 20
        
        self.addimageview.layer.cornerRadius = 5
        self.addimageview.layer.borderWidth = 1
        self.addimageview.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.addimageview.clipsToBounds = true
        
        self.addvideoview.layer.cornerRadius = 5
        self.addvideoview.layer.borderWidth = 1
        self.addvideoview.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.addvideoview.clipsToBounds = true
    }
    
  
    func pickUpDate(_ textField : UITextField){

           self.FirstdatePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
           self.FirstdatePicker.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
           self.FirstdatePicker.datePickerMode = UIDatePicker.Mode.date
           //self.FirstdatePicker.tintColor = #colorLiteral(red: 0.1688283401, green: 0.6115575723, blue: 1, alpha: 1)

           textField.inputView = self.FirstdatePicker

           let toolBar = UIToolbar()
           toolBar.barStyle = .default
           toolBar.isTranslucent = true
           toolBar.backgroundColor = #colorLiteral(red: 0, green: 0.2156862745, blue: 0.4666666667, alpha: 1)
           toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
           self.LastdatePicker.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
           self.LastdatePicker.datePickerMode = UIDatePicker.Mode.date
           //self.LastdatePicker.tintColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)

           textField.inputView = self.LastdatePicker

           let toolBar = UIToolbar()
           toolBar.barStyle = .default
           toolBar.isTranslucent = true
           toolBar.backgroundColor = #colorLiteral(red: 0, green: 0.2156862745, blue: 0.4666666667, alpha: 1)
           toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtfirstdate {
             self.pickUpDate(self.txtfirstdate)
            return true
        }else if textField == self.txtlastdate{
            self.pickUpDatelast(self.txtlastdate)
            return true
        }
      
     return false
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
            self.checkboxstring?.append(",Cock Fighting")
        }else{
            print("false")
        }
    }
    
    @IBAction func medicalcarebutton(_ sender: UICheckbox) {
        print("medicalcarebutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append(",Needs Medical Care")
        }else{
            print("false")
        }
    }
    
    @IBAction func tetheringbutton(_ sender: UICheckbox) {
        print("tetheringbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append(",Tethering")
        }else{
            print("false")
        }
    }
    
    @IBAction func noshelterbutton(_ sender: UICheckbox) {
        print("noshelterbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append(",No Shelter")
        }else{
            print("false")
        }
    }
    
    @IBAction func hoardingbutton(_ sender: UICheckbox) {
        print("hoardingbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append(",Hoarding Animals")
        }else{
            print("false")
        }
    }
    
    @IBAction func cruellybutton(_ sender: UICheckbox) {
        print("cruellybutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append(",Cruelly Confined")
        }else{
            print("false")
        }
    }
    
    @IBAction func dumpedbutton(_ sender: UICheckbox) {
        print("dumpedbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append(",Dumped Animal")
        }else{
            print("false")
        }
    }
    
    @IBAction func abandonedbutton(_ sender: UICheckbox) {
        print("abandonedbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append(",Abandoned")
        }else{
            print("false")
        }
    }
    
    @IBAction func otherbutton(_ sender: UICheckbox) {
        print("otherbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append(",other")
        }else{
            print("false")
        }
    }
    
    @IBAction func dogfightingbutton(_ sender: UICheckbox) {
        print("dogfightingbutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxstring?.append(",Dog Fighting")
        }else{
            print("false")
        }
    }
    
    @IBAction func agencybutton(_ sender: UICheckbox) {
        print("agencybutton value change: \(sender.isSelected)")
        if sender.isSelected == true{
            self.checkboxBool?.append("true")
        }else{
            print("false")
        }
    }
    
    func validate() -> Bool {
     if self.txtaddress.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Address", duration: 0.3)
                return false
    }else if self.txtaptnumber.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Apt.Number", duration: 0.3)
                return false
    }else if self.txtgatcode.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Gate Code", duration: 0.3)
                return false
    }else if self.txtcity.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter City", duration: 0.3)
                return false
    }else if self.Statetxt.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter State", duration: 0.3)
                return false
    }else if self.txtzip.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Zip", duration: 0.3)
                return false
    }else if self.txtcountry.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter County", duration: 0.3)
                return false
    }else if self.txtneighborhood.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Neighborhood", duration: 0.3)
                return false
    }else if self.txttypeofanimal.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Types of Animals", duration: 0.3)
                return false
    }else if self.txtnumberofanimal.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter Number of Animals", duration: 0.3)
                  return false
    }else if self.txtcolorofanimal.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter Color of Animals", duration: 0.3)
                  return false
    }else if self.txtanimalslocation.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter Whare on the Property is the animal(s) located?", duration: 0.3)
                  return false
    }else if self.txtfirstdate.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter Date First Observed", duration: 0.3)
                  return false
    }else if self.txtlastdate.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter Date Last Observed", duration: 0.3)
                  return false
    }else if self.txtdescription.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter Description of Cruelty ", duration: 0.3)
                  return false
    }else if self.txtagency.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter Agency Previously to (if applicable).", duration: 0.3)
                  return false
    }else if self.txtfirstname.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter First Name", duration: 0.3)
                  return false
    }else if self.txtlastname.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter Last Name", duration: 0.3)
                  return false
    }else if txtphone.text!.count != 10{
        self.view.showToast(toastMessage: "Please Enter a valid number.", duration: 0.3)
                  return false
      }else if self.txtemail.text?.isEmpty ?? true {
        self.view.showToast(toastMessage: "Enter Email", duration: 0.3)
                  return false
    }else if self.isValidEmail(testStr: txtemail.text!) == false{
        self.view.showToast(toastMessage: "Please Enter a valid Email id.", duration: 0.3)
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
            if validate(){
                ReportAnimalApicall()
            }
    }
    
    func ReportAnimalApicall() {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
        
        let parameters = [
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
            "CrueltyDesc":txtdescription.text as Any,
            "PreviousReport":checkboxBool as Any,
            "PreviousAgencyDesc":txtagency.text as Any,
            "ReporterFirstName":txtfirstname.text as Any,
            "ReporterLastName":txtlastname.text as Any,
            "ReporterPhone":txtphone.text as Any,
            "ReporterEmail":txtemail.text as Any,
            "ReceivedDevice":"0",
            "ImageList":ImagevideoUrl as Any,
        ] as [String : Any]

        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)

        let url = URL(string: "https://apps.harriscountytx.gov/PublicHealthPortal/api/UploadVPHComplaint")!
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
                            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            navigate.selectdtab = 4
                            self.navigationController?.pushViewController(navigate, animated: true)
                      
                          }
                    }
                 }catch{
                     print(error.localizedDescription)
                 }
                 
                 }

        task.resume()

    }
    
    @IBAction func addimages(_ sender: UIButton) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            let image = Image(imageData: selectedImage.pngData()!)
            print("image get video==>\(image)")
            images.append(image)
            Image.saveImages(images)
            dismiss(animated: true, completion: nil)
            self.addimagescollection.reloadData()
            
            let imageData: Data? = selectedImage.jpegData(compressionQuality: 0.4)
            let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
            print("imageStr====>\(imageStr)")
            self.ImagevideoUrl?.append(imageStr)
            
            print("ImagevideoUrl>>====>\(ImagevideoUrl ?? "")")
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
                 print("jksbdjkshkjbdkjbwedjkbeqwd")
                self.VideosongUrl = "\(videoUrl)"
                
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
        let imagePicker = UIImagePickerController()
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
            remove(index: indexPath.row)
        }else{
            print("index:==>\(indexPath.row)")
            removevideos(index: indexPath.row, urlmain: arrOfFiles[indexPath.row].absoluteURL)
        }

    }
    

    
    func remove(index: Int) {
        images.remove(at: index)

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
             
    textField.resignFirstResponder()
    return true
   }
         
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
             
     self.view.endEditing(true)
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
