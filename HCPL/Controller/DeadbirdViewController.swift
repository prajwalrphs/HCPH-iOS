
import UIKit
import MBProgressHUD
import SwiftyJSON
import Alamofire
import CoreLocation


struct DeadbirdClass: Codable {
    let reportNo, collectionID: String

    enum CodingKeys: String, CodingKey {
        case reportNo = "ReportNo"
        case collectionID = "CollectionId"
    }
}

class DeadbirdViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate,UITextFieldDelegate {

    var images: [Image] = []
    
    var arrayimage = [String]()
    
    @IBOutlet weak var birdcollection: UICollectionView!
    @IBOutlet weak var addimageview: UIView!
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var contacttext: UITextField!
    
    @IBOutlet var viewone: UIView!
    @IBOutlet var viewtwo: UIView!
    
    @IBOutlet var lblisbird: UILabel!
    @IBOutlet var lblHasthebird: UILabel!
    @IBOutlet var lblArethereany: UILabel!
    @IBOutlet var lblDosethebird: UILabel!
    @IBOutlet var lbladdimages: UILabel!
    @IBOutlet var lblifthebird: UILabel!
    @IBOutlet var lblbysubmit: UILabel!
    
    
    var birdheadattachedText:String!
    var BirdbeendeadlessText:String!
    var maggotsorantsText:String!
    var birdappeartobeillorinjuredText:String!
    
    
    var birdheadattachedBool:String!
    var BirdbeendeadlessBool:String!
    var maggotsorantsBool:String!
    var birdappeartobeillorinjuredBool:String!
        
    var LatitudeString:String!
    var LongitudeString:String!
  
    var hud: MBProgressHUD = MBProgressHUD()
    let locationManager = CLLocationManager()
    
    var DeadbirdStruct:DeadbirdClass?
    
    let currentDateTime = Date()
    let formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        self.contacttext.delegate = self
        
        self.addimageview.layer.cornerRadius = 5
        self.addimageview.layer.borderWidth = 1
        self.addimageview.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.addimageview.clipsToBounds = true
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            
            self.addimageview.layer.cornerRadius = 5
            self.addimageview.layer.borderWidth = 1
            self.addimageview.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            self.addimageview.clipsToBounds = true
            
            self.lblisbird.textColor = AppConstant.LabelWhiteColor
            self.lblHasthebird.textColor = AppConstant.LabelWhiteColor
            self.lblArethereany.textColor = AppConstant.LabelWhiteColor
            self.lblDosethebird.textColor = AppConstant.LabelWhiteColor
            self.lbladdimages.textColor = AppConstant.LabelWhiteColor
            self.lblifthebird.textColor = AppConstant.LabelWhiteColor
            self.lblbysubmit.textColor = AppConstant.LabelWhiteColor
        
            self.viewone.backgroundColor = AppConstant.LabelWhiteColor
            self.viewtwo.backgroundColor = AppConstant.LabelWhiteColor
       
            
            emailtext.attributedPlaceholder = NSAttributedString(string: "Email of person reporting*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
            contacttext.attributedPlaceholder = NSAttributedString(string: "Contact of person reporting*",attributes: [NSAttributedString.Key.foregroundColor: AppConstant.LabelWhiteColor])
            
        }else if onoff == "off"{
            
        }else{
            
        }
       
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        let StringDate = formatter.string(from: currentDateTime)
        print("StringDate====>\(StringDate)")
        
        UserDefaults.standard.set(StringDate, forKey: AppConstant.DATE)
                
        
        let CURRENTLAT = UserDefaults.standard.string(forKey: AppConstant.CURRENTLAT)
        let CURRENTLONG = UserDefaults.standard.string(forKey: AppConstant.CURRENTLONG)
        print("CURRENTLAT==>\(CURRENTLAT ?? "")")
        print("CURRENTLONG==>\(CURRENTLONG ?? "")")
        
        LatitudeString = CURRENTLAT
        LongitudeString = CURRENTLONG
        
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
        
        self.submit.layer.cornerRadius = 20
        

        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.LatitudeString = "\(locValue.latitude)"
        self.LongitudeString = "\(locValue.longitude)"
    }
    
    var MAX_LENGHTPhone = 10
    func Phonelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTPhone {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTPhone))
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == contacttext{
            let MAX_LENGTH = 10
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else{
            return true
        }
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         if textField == self.contacttext{
            self.Phonelenght(self.contacttext)
            return true
        }
      
     return false
    }
    
    func validate() -> Bool {
     if self.emailtext.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please provide the valid email", duration: 0.3)
                return false
    }else if self.isValidEmail(testStr: emailtext.text!) == false{
        self.view.showToast(toastMessage: "Please provide the valid email", duration: 0.3)
        return false
    }else if contacttext.text!.count != 10{
      self.view.showToast(toastMessage: "Please provide the valid number.", duration: 0.3)
                return false
    }else if self.arrayimage.isEmpty{
        self.view.showToast(toastMessage: "Image is required", duration: 0.3)
                  return false
    }
      return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func Submit(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            if validate(){
                DeadbirdAPICall()
            }
        }else{
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Network unavailable please try later", duration: 0.3)
        }
    }
    
    
    @IBAction func birdheadattached(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.birdheadattachedBool = "true"
        }
        else{
            print("off")
            self.birdheadattachedBool = "false"
        }
    }
    
    @IBAction func Birdbeendeadless(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.BirdbeendeadlessBool = "true"
        }
        else{
            print("off")
            self.BirdbeendeadlessBool = "false"
        }
    }
    
    @IBAction func maggotsorants(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.maggotsorantsBool = "true"
        }
        else{
            print("off")
            self.maggotsorantsBool = "false"
        }
    }
    
    @IBAction func birdappeartobeillorinjured(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.birdappeartobeillorinjuredBool = "true"
        }
        else{
            print("off")
            self.birdappeartobeillorinjuredBool = "false"
        }
    }
    
    func DeadbirdAPICall(){

    hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
    hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
    hud.show(animated: true)

    var SecondaryarrayOfDict = [NSDictionary]()
    let dict1 = ["addressname":"","city":"","zip":""]
    SecondaryarrayOfDict.append(dict1 as NSDictionary)

    var Address = [NSDictionary]()
    let AddressDic = ["addressname":"","city":"","zip":""]
    Address.append(AddressDic as NSDictionary)

    var DeadBirdReporter = [NSDictionary]()
    let DeadBirdReporterDic = ["reportername":"","primaryphone":contacttext.text ?? "","reporteremail":emailtext.text ?? ""] as [String : Any]
    DeadBirdReporter.append(DeadBirdReporterDic as NSDictionary)

    self.birdheadattachedText = "Is the Bird intact ? Is the head attached to the body ?"
    self.BirdbeendeadlessText = "Has the Bird been dead less than 24 hrs ?"
    self.maggotsorantsText = "Are there any maggots or ants on the Bird ?"
    self.birdappeartobeillorinjuredText = "Does the bird appear ill or injured ?"

    var BirdConditionList = [Any]()
    let testbool = true

    if birdheadattachedBool == "true"{

    let BirdConditionListDic = ["DataAbbr": "Intact",
    "DataDesc": "Is the Bird intact ? Is the head attached to the body ?",
    "IsObserved": true,
    "$$hashKey": ""] as [String : Any]

    //switch1
    // let BirdConditionListDic = ["DataAbbr": "Intact",
    // "DataDesc": "Is the Bird intact ? Is the head attached to the body ?",
    // "IsObserved": true,
    // "$$hashKey": ""] as [String : Any]
    BirdConditionList.append(BirdConditionListDic)

    }

    if BirdbeendeadlessBool == "true"{
    //switch1

    // let BirdConditionListDic2 = """
    // {"DataAbbr": "Dead < 24 hrs.","DataDesc": "Has the Bird been dead less than 24 hrs ?","IsObserved": \(testbool),"$$hashKey": ""},
    // """

    let BirdConditionListDic2 = ["DataAbbr": "Dead < 24 hrs.",
    "DataDesc": "Has the Bird been dead less than 24 hrs ?",
    "IsObserved": true,
    "$$hashKey": ""] as [String : Any]
    ////
    // let BirdConditionListDic2 = ["DataAbbr": "Dead < 24 hrs.",
    // "DataDesc": "Has the Bird been dead less than 24 hrs ?",
    // "IsObserved": true,
    // "$$hashKey": ""] as [String : Any]
    BirdConditionList.append(BirdConditionListDic2)
    }

    if maggotsorantsBool == "true"{
    //switch1
    // let BirdConditionListDic3 = """
    // {"DataAbbr": "Dead > 24 hrs.","DataDesc": "Are there any maggots or ants on the Bird ?","IsObserved": \(testbool),"$$hashKey": ""},
    // """

    let BirdConditionListDic3 = ["DataAbbr": "Dead > 24 hrs.",
    "DataDesc": "Are there any maggots or ants on the Bird ?",
    "IsObserved": true,
    "$$hashKey": ""] as [String : Any]

    // let BirdConditionListDic3 = ["DataAbbr": "Dead > 24 hrs.",
    // "DataDesc": "Are there any maggots or ants on the Bird ?",
    // "IsObserved": true,
    // "$$hashKey": ""] as [String : Any]
    BirdConditionList.append(BirdConditionListDic3)
    }

    if birdappeartobeillorinjuredBool == "true"{
    //switch1

    // let BirdConditionListDic4 = """
    // {"DataAbbr": "Sick","DataDesc": "Does the bird appear ill or injured ?","IsObserved": \(testbool),"$$hashKey": ""},
    // """

    let BirdConditionListDic4 = ["DataAbbr": "Sick",
    "DataDesc": "Does the bird appear ill or injured ?",
    "IsObserved": true,
    "$$hashKey": ""] as [String : Any]
    //
    // let BirdConditionListDic4 = ["DataAbbr": "Sick",
    // "DataDesc": "Does the bird appear ill or injured ?",
    // "IsObserved": true,
    // "$$hashKey": ""] as [String : Any]
    BirdConditionList.append(BirdConditionListDic4)
    }


    let headers: HTTPHeaders = ["Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json",
    "Connection": "Keep-Alive",
    "User-Agent": "Pigeon"]

    let CurrentDate = UserDefaults.standard.string(forKey: AppConstant.DATE)
    print("onoff==>\(CurrentDate ?? "")")


    let objParameters: Parameters = [
    "BirdFoundDt":CurrentDate ?? "",
    "CallRecordedDt":CurrentDate ?? "",
    "CallRecordedTime":CurrentDate ?? "",
    "callrecorderid":0,
    "locationtype":"",
    "secondaryaddress":dict1,
    "address":AddressDic,
    "deadbirdreporter":DeadBirdReporterDic,
    "Latitude":LatitudeString ?? "",
    "Longitude":LongitudeString ?? "",
    "BirdConditionList":BirdConditionList,
    "ImageList":arrayimage
    ]


     let url = URL(string: "http://svpphesmcweb01.hcphes.hc.hctx.net/Stage_MCDExternalApi/api/External/AddDeadBirdReport?SecondaryAddress=" + "etcetcetc" + "&City=" + "Texas" + "&ZipCode=" + "77510" + "&IsExternalRequest=true")!
     print("urlurlurl==>\(url)")

    AF.request(url,method: .post, parameters:objParameters, encoding: JSONEncoding.default
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

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            // your code here
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 4
            self.navigationController?.pushViewController(navigate, animated: true)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            let image = Image(imageData: selectedImage.pngData()!)
            images.append(image)
            Image.saveImages(images)
            
            Image.saveImages(images)
            dismiss(animated: true, completion: nil)
            self.birdcollection.reloadData()
            
            let imageData: Data? = selectedImage.jpegData(compressionQuality: 0.4)
            let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
            print("imageStr====>\(imageStr)")
            self.arrayimage.append(imageStr)
                        
      }
        
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
        
        @IBAction func back(_ sender: UIButton) {
               self.navigationController?.popViewController(animated: true)
           }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell:deadbirdCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "deadbirdCollectionViewCell", for: indexPath) as! deadbirdCollectionViewCell
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

        let indexPath = IndexPath(row: index, section: 0)
        birdcollection.performBatchUpdates({
            self.birdcollection.deleteItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
            self.birdcollection.reloadItems(at: self.birdcollection.indexPathsForVisibleItems)
        })
        
        print("images==>\(images)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             
    textField.resignFirstResponder()
    return true
   }
         
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
             
     self.view.endEditing(true)
    }
    
}

extension DeadbirdViewController{
    func hideKeyboardTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
