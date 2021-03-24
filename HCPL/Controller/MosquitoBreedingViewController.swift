
import UIKit
import iOSDropDown
import CoreLocation
import MBProgressHUD
import SwiftyJSON
import Alamofire

class MosquitoBreedingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UITextViewDelegate {

    var images: [Image] = []
    var hud: MBProgressHUD = MBProgressHUD()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OtherText.delegate = self
        self.OtherText.isHidden = true
        
        OtherText.layer.borderWidth = 1
        OtherText.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        
        OtherText.autocapitalizationType = .sentences
        OtherText.autocapitalizationType = .words
        OtherText.text = "Please describe the breeding site."
        OtherText.textColor = UIColor.lightGray
        
        txtcontactofpersonrepoting.delegate = self
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
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            let image = Image(imageData: selectedImage.pngData()!)
            print("image get video==>\(image)")
            images.append(image)
            Image.saveImages(images)
            dismiss(animated: true, completion: nil)
            self.Mosquitocollection.reloadData()
            
            let imageData: Data? = selectedImage.jpegData(compressionQuality: 0.4)
            let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
            print("imageStr====>\(imageStr)")
            self.arrayimage.append(imageStr)
     }
        
    }
    
    @IBAction func submitaction(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            if validate(){
                MosquitoBreedingAPICall()
            }
        }else{
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on internet connection to continue.", duration: 0.3)
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
            self.Switch3 = "false"
        }
        else{
            print("off")
            self.Switch3 = "false"
        }
    }
    
    @IBAction func Other(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.OtherText.isHidden = false
            self.Switch4 = "false"
        }
        else{
            print("off")
            self.OtherText.isHidden = true
            self.Switch4 = "false"
        }
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtcontactofpersonrepoting{
            let MAX_LENGTH = 10
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
    let switchfour = ["CallRequestId": "0","isChecked": true,"ItemObservedDescription": OtherText.text ?? "","InspectionItemId":"93","ItemDescription": "","InspectionItemType": "","CreatedBy": "","CreatedDt": "","LastModifiedBy": "","LastModifiedDt": "","DeletedFg": "","ItemOrder": ""] as [String : Any]

    InspectionItemResult.append(switchfour)
    }

    let headers: HTTPHeaders = ["Content-Type": "application/json"]


    let CurrentDate = UserDefaults.standard.string(forKey: AppConstant.DATE)
    print("onoff==>\(CurrentDate ?? "")")


    let objParameters: Parameters = [
    "FirstName":"",
    "LastName":"",
    "RequestTypeId":1,
    "FromExternalWebSite":true,
    "MosquitoBiteTimeOfDay":Timeofday.text ?? "",
    "InspectionConduction":false,
    "RequestDt":"2018-07-20 03:03 33",
    "locationofproblem":"",
    "othersite":OtherText.text ?? "",
    "address":AddressDic,
    "requestor":RequestorDic,
    "Latitude":LatitudeString ?? "",
    "Longitude":LongitudeString ?? "",
    "InspectionItemResult":InspectionItemResult,
    "ImageList":arrayimage
    ]



    let url = URL(string: "http://svpphesmcweb01.hcphes.hc.hctx.net/Stage_MCDExternalApi/api/External/AddExtCitizenRequest?title=")!

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
    print("DeadBirdResponse==>\(response)")

    }

    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addimage(_ sender: UIButton) {
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
             
    textField.resignFirstResponder()
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
