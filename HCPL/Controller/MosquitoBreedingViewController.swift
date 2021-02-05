//
//  MosquitoBreedingViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 23/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import iOSDropDown
import CoreLocation
import MBProgressHUD
import SwiftyJSON
import Alamofire

class MosquitoBreedingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate,UITextFieldDelegate {

    var images: [Image] = []
    var hud: MBProgressHUD = MBProgressHUD()
    
    @IBOutlet weak var submitoutlate: UIButton!
    @IBOutlet weak var viewmain: UIView!
    @IBOutlet weak var Mosquitocollection: UICollectionView!
    @IBOutlet weak var plusimage: UIButton!
    
    @IBOutlet weak var Timeofday: UITextField!
    @IBOutlet weak var txtemailofpersonrepoting: UITextField!
    @IBOutlet weak var txtcontactofpersonrepoting: UITextField!
    @IBOutlet weak var OtherText: UITextField!
    
    @IBOutlet weak var mainDropDown: DropDown!
    
    
    let locationManager = CLLocationManager()
    
    var TimeofArray = ["Day","Night","Both"]
    let ids = [1,2,3]
    
    var LatitudeString:String!
    var LongitudeString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.OtherText.isHidden = true
        
        self.hideKeyboardTappedAround()
        
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mainDropDown.optionArray = TimeofArray
        mainDropDown.optionIds = ids
        mainDropDown.checkMarkEnabled = false
        
        mainDropDown.didSelect{(selectedText , index , id) in
            self.Timeofday.text = selectedText
        }

        self.submitoutlate.layer.cornerRadius = 20
        
        self.viewmain.layer.cornerRadius = 5
        self.viewmain.layer.borderWidth = 1
        self.viewmain.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.viewmain.clipsToBounds = true

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
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
     }
        
    }
    
    @IBAction func submitaction(_ sender: UIButton) {
        if validate(){
            MosquitoBreedingAPICall()
        }
    }
    
    
    @IBAction func inspectionformosquitobreeding(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
        }
        else{
            print("off")
        }
    }
    
    @IBAction func Waterholdingcontainers(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
        }
        else{
            print("off")
        }
    }
    
    @IBAction func Ditcheswithwater(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
        }
        else{
            print("off")
        }
    }
    
    @IBAction func Other(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("on")
            self.OtherText.isHidden = false
        }
        else{
            print("off")
            self.OtherText.isHidden = true
        }
    }

    func validate() -> Bool {
     if self.txtemailofpersonrepoting.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Email of Person Reporting", duration: 0.3)
                return false
    }else if self.isValidEmail(testStr: txtemailofpersonrepoting.text!) == false{
        self.view.showToast(toastMessage: "Please Enter a valid Email id.", duration: 0.3)
        return false
    }else if self.txtcontactofpersonrepoting.text!.count != 10{
        self.view.showToast(toastMessage: "Please Enter a valid number.", duration: 0.3)
                  return false
      }
      return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func MosquitoBreedingAPICall() {

        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)


        var Address = [NSDictionary]()
        let AddressDic = ["AddressName":"","City":"","Zip":""]
        Address.append(AddressDic as NSDictionary)
        
        var Requestor = [NSDictionary]()
        let RequestorDic = ["RequestorName":"","PrimaryPhone":"","SecondaryPhone":txtcontactofpersonrepoting.text ?? "","ReporterEmail":txtemailofpersonrepoting.text ?? ""]
        Requestor.append(RequestorDic as NSDictionary)
        
        var InspectionItemResult = [NSDictionary]()
        let InspectionItemResultDic = ["CallRequestId": "0","isChecked": "true","ItemObservedDescription": "","InspectionItemId": "85","ItemDescription": "","InspectionItemType": "","CreatedBy": "","CreatedDt": "","LastModifiedBy": "","LastModifiedDt": "","DeletedFg": "","ItemOrder": ""]
        let InspectionItemResultDicTwo = ["CallRequestId": "0","isChecked": "true","ItemObservedDescription": "","InspectionItemId": "92","ItemDescription": "","InspectionItemType": "","CreatedBy": "","CreatedDt": "","LastModifiedBy": "","LastModifiedDt": "","DeletedFg": "","ItemOrder": ""]
        InspectionItemResult.append(InspectionItemResultDic as NSDictionary)
        InspectionItemResult.append(InspectionItemResultDicTwo as NSDictionary)
    
        let parameters = [
            "FirstName":"",
            "LastName":"",
            "RequestTypeId":1,
            "FromExternalWebSite":true,
            "MosquitoBiteTimeOfDay":Timeofday.text ?? "",
            "InspectionConduction":false,
            "RequestDt":"2018-07-20 03:03 33",
            "LocationOfProblem":"",
            "OtherSite":"",
            "Address":Address,
            "Requestor":Requestor,
            "Latitude":LatitudeString ?? "",
            "Longitude":LongitudeString ?? "",
            "InspectionItemResult":InspectionItemResult,
            "ImageList":"[bsjkdbjkdb]"
        ] as [String : Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        let url = URL(string: "https://secure.hcphes.org/MCDWebApi/api/External/AddExtCitizenRequest?title=")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
//        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        request.addValue("Accept", forHTTPHeaderField: "application/json")
//        request.addValue("Connection", forHTTPHeaderField: "Keep-Alive")
//        request.addValue("User-Agent", forHTTPHeaderField: "Pigeon")
        

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 
                 guard let data = data else { return }
                 do{
                     let json = try JSON(data:data)
                     print("MosquitoBreedingAPICall==> \(json)")
                    
                       
              DispatchQueue.main.async {
                
                    self.hud.hide(animated: true)
            
                        
                }
                     
                 }catch{
                     print(error.localizedDescription)
                 }
                 
                 }

        task.resume()

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
            remove(index: indexPath.row)
    }
    
    func remove(index: Int) {
        images.remove(at: index)

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
