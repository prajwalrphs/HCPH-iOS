//
//  DeadbirdViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 09/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

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
    
    var birdheadattachedText:String!
    var BirdbeendeadlessText:String!
    var maggotsorantsText:String!
    var birdappeartobeillorinjuredText:String!
    
    var birdheadattachedBool = Bool()
    var BirdbeendeadlessBool = Bool()
    var maggotsorantsBool = Bool()
    var birdappeartobeillorinjuredBool = Bool()
        
    var LatitudeString:String!
    var LongitudeString:String!
  
    var hud: MBProgressHUD = MBProgressHUD()
    let locationManager = CLLocationManager()
    
    var DeadbirdStruct:DeadbirdClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.addimageview.layer.cornerRadius = 5
        self.addimageview.layer.borderWidth = 1
        self.addimageview.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.addimageview.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.LatitudeString = "\(locValue.latitude)"
        self.LongitudeString = "\(locValue.longitude)"
    }
    
    func validate() -> Bool {
     if self.emailtext.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Email of Person Reporting", duration: 0.3)
                return false
    }else if self.isValidEmail(testStr: emailtext.text!) == false{
        self.view.showToast(toastMessage: "Please Enter a valid Email id.", duration: 0.3)
        return false
    }else if contacttext.text!.count != 10{
      self.view.showToast(toastMessage: "Please Enter a valid number.", duration: 0.3)
                return false
    }else if self.arrayimage.isEmpty{
        self.view.showToast(toastMessage: "Choose Image", duration: 0.3)
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
        if validate(){
            DeadbirdAPICall()
        }
    }
    
    
    @IBAction func birdheadattached(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.birdheadattachedText = "Is the Bird intact ? Is the head attached to the body ?"
            self.birdheadattachedBool = true
        }
        else{
            print("off")
        }
    }
    
    @IBAction func Birdbeendeadless(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.BirdbeendeadlessText = "Has the Bird been dead less than 24 hrs ?"
            self.BirdbeendeadlessBool = true
        }
        else{
            print("off")
        }
    }
    
    @IBAction func maggotsorants(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.maggotsorantsText = "Are there any maggots or ants on the Bird ?"
            self.maggotsorantsBool = true
        }
        else{
            print("off")
        }
    }
    
    @IBAction func birdappeartobeillorinjured(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.birdappeartobeillorinjuredText = "Does the bird appear ill or injured ?"
            self.birdappeartobeillorinjuredBool = true
        }
        else{
            print("off")
        }
    }
    
    
    func DeadbirdAPICall() {

        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)

        var SecondaryarrayOfDict = [NSDictionary]()
        let dict1 = ["AddressName":"","City":"","Zip":""]
        SecondaryarrayOfDict.append(dict1 as NSDictionary)

        var Address = [NSDictionary]()
        let AddressDic = ["AddressName":"","City":"","Zip":""]
        Address.append(AddressDic as NSDictionary)

        var DeadBirdReporter = [NSDictionary]()
        let DeadBirdReporterDic = ["ReporterName":"","PrimaryPhone":contacttext.text as Any,"ReporterEmail":emailtext.text as Any] as [String : Any]
        DeadBirdReporter.append(DeadBirdReporterDic as NSDictionary)
        
        var BirdConditionList = [NSDictionary]()
        let BirdConditionListDic = ["DataAbbr": "Intact",
                                    "DataDesc": birdheadattachedText ?? "",
                                    "IsObserved": birdheadattachedBool,
                                    "$$hashKey": "object:19"] as [String : Any]
        let BirdConditionListDic2 = ["DataAbbr": "Dead < 24 hrs.",
                                     "DataDesc": BirdbeendeadlessText ?? "",
                                     "IsObserved": BirdbeendeadlessBool,
                                     "$$hashKey": "object:18"] as [String : Any]
        let BirdConditionListDic3 = ["DataAbbr": "Dead > 24 hrs.",
                                     "DataDesc": maggotsorantsText ?? "",
                                     "IsObserved": maggotsorantsBool,
                                     "$$hashKey": "object:20"] as [String : Any]
        let BirdConditionListDic4 = ["DataAbbr": "Sick",
                                     "DataDesc": birdappeartobeillorinjuredText ?? "",
                                     "IsObserved": birdappeartobeillorinjuredBool,
                                     "$$hashKey": "object:21"] as [String : Any]
        BirdConditionList.append(BirdConditionListDic as NSDictionary)
        BirdConditionList.append(BirdConditionListDic2 as NSDictionary)
        BirdConditionList.append(BirdConditionListDic3 as NSDictionary)
        BirdConditionList.append(BirdConditionListDic4 as NSDictionary)


        let parameters = [
            "BirdFoundDt":"01/18/2021 22:34 PM",
            "CallRecordedDt":"01/18/2021 22:34 PM",
            "CallRecordedTime":"01/18/2021 22:34 PM",
            "CallRecorderId":"0",
            "LocationType":"",
            "SecondaryAddress":SecondaryarrayOfDict,
            "Address":Address,
            "DeadBirdReporter":DeadBirdReporter,
            "Latitude":LatitudeString ?? "",
            "Longitude":LongitudeString ?? "",
            "BirdConditionList":BirdConditionList,
            "ImageList":[arrayimage]
        ] as [String : Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        let url = URL(string: "https://secure.hcphes.org/MCDWebApi/api/External/AddDeadBirdReport?SecondaryAddress=" + "etcetcetc" + "&City=" + "Texas" + "&ZipCode=" + "77510" + "&IsExternalRequest=true")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Accept", forHTTPHeaderField: "application/json")
        request.addValue("Connection", forHTTPHeaderField: "Keep-Alive")
        request.addValue("User-Agent", forHTTPHeaderField: "Pigeon")
        
        print("parameters==>\(parameters)")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 
                 guard let data = data else { return }
                 do{
                     let json = try JSON(data:data)
                     print("DeadbirdAPICall==> \(json)")
                    
                    let decoder = JSONDecoder()
                    self.DeadbirdStruct = try decoder.decode(DeadbirdClass.self, from: data)
                       
              DispatchQueue.main.async {
                
                    self.hud.hide(animated: true)
            
                        
                }
                     
                 }catch{
                     print(error.localizedDescription)
                 }
                 
                 }

        task.resume()

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
            remove(index: indexPath.row)
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
