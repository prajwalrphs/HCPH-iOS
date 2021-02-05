//
//  CommercialPoolsViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 24/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import iOSDropDown
import MBProgressHUD
import SwiftyJSON
import Alamofire

class CommercialPoolsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate {


    var images: [Image] = []
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    var CommercialPools:CommercialPoolsWelcome?
    
    
    @IBOutlet weak var Statetxt: UITextField!
    @IBOutlet weak var mainDropDown: DropDown!
    @IBOutlet weak var txtnameaddress: UITextField!
    @IBOutlet weak var txtemailaddress: UITextField!
    @IBOutlet weak var txtfirstname: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var txtcontactnumber: UITextField!
    @IBOutlet weak var viewdescription: UIView!
    //@IBOutlet weak var txtdescription: UITextField!
    @IBOutlet weak var LimitLabel: UILabel!
    
    @IBOutlet weak var txtdescription: UITextView!
    @IBOutlet weak var viewaddimage: UIView!
    @IBOutlet weak var imagecollection: UICollectionView!
    @IBOutlet weak var addimage: UIButton!
    @IBOutlet weak var submitoutlate: UIButton!
    @IBOutlet weak var lbltitle: UILabel!
    
    var CommercialArray = [String]()
    var arrayimage = [String]()
    var ids = [Int]()
    var Title:String!
    var PlaceholderGet:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.hideKeyboardTappedAround()
        
        self.updateCharacterCount()
        
        self.lbltitle.text = Title

        mainDropDown.optionArray = CommercialArray
        mainDropDown.optionIds = ids
        mainDropDown.checkMarkEnabled = false
        
        txtdescription.delegate = self
        
        Statetxt.placeholder = PlaceholderGet
        let placeholder = NSMutableAttributedString(
            string: PlaceholderGet,
            attributes: [.font: UIFont(name: "Helvetica", size: 15.0)!,
                         .foregroundColor: UIColor.gray
                         ])
        Statetxt.attributedPlaceholder = placeholder
        
        mainDropDown.didSelect{(selectedText , index , id) in
            self.Statetxt.text = selectedText
        }
        
        self.submitoutlate.layer.cornerRadius = 20
        
        self.viewaddimage.layer.cornerRadius = 5
        self.viewaddimage.layer.borderWidth = 1
        self.viewaddimage.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.viewaddimage.clipsToBounds = true
        
        self.viewdescription.layer.cornerRadius = 5
        self.viewdescription.layer.borderWidth = 1
        self.viewdescription.layer.borderColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
        self.viewdescription.clipsToBounds = true
        
    }
    
    func updateCharacterCount() {
      
       let descriptionCount = self.txtdescription.text.count


       self.LimitLabel.text = "\((0) + descriptionCount)/1000 characters left"
    }

    func textViewDidChange(_ textView: UITextView) {
       self.updateCharacterCount()
    }


    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
       if(textView == txtdescription){
        return textView.text.count +  (text.count - range.length) <= 1000
       }
       return false
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Description*" {
            txtdescription.text = ""
            txtdescription.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)

        }
        textView.becomeFirstResponder()
    }

    public func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text == "" {
            txtdescription.text = "Description*"
            txtdescription.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        }
        textView.resignFirstResponder()
    }
    
    func headers() -> HTTPHeaders {
        let headers:HTTPHeaders = ["Content-Type": "application/json"]
        return headers
    }
    
    func validate() -> Bool {
     if self.Statetxt.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Choose CommercialPools", duration: 0.3)
                return false
    }else if self.txtnameaddress.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Name Address or Zip", duration: 0.3)
                return false
    }else if self.txtemailaddress.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Email Address", duration: 0.3)
                return false
    }else if self.isValidEmail(testStr: txtemailaddress.text!) == false{
        self.view.showToast(toastMessage: "Please Enter a valid Email id.", duration: 0.3)
        return false
    }else if self.txtfirstname.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter First Name", duration: 0.3)
                return false
    }else if self.txtlastname.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Last Name", duration: 0.3)
                return false
    }else if self.txtcontactnumber.text!.count != 10{
        self.view.showToast(toastMessage: "Please Enter a valid number.", duration: 0.3)
                  return false
      }else if self.txtdescription.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Enter Description", duration: 0.3)
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
    
    func CommercialPoolsApicall() {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
  
        let parameters = [
            "ContactNumber":txtcontactnumber.text ?? "",
            "Description":txtdescription.text ?? "",
            "Email":txtemailaddress.text ?? "",
            "EstablishmentNumber":"0",
            "FirstName":txtfirstname.text ?? "",
            "LastName":txtlastname.text ?? "",
            "Place":"hchcgchchx",
            "ReceivedDevice":"1",
            "Section":"0",
            "Subject":Statetxt.text ?? "",
            "ImageList":["values":arrayimage]
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
                     print("PlaceorderApicall==> \(json)")
                    
                    let decoder = JSONDecoder()
                    self.CommercialPools = try decoder.decode(CommercialPoolsWelcome.self, from: data)
                       
              DispatchQueue.main.async {
                
                    self.hud.hide(animated: true)
                
                let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                navigate.selectdtab = 4
                self.navigationController?.pushViewController(navigate, animated: true)
                        
                }
                     
                 }catch{
                     print(error.localizedDescription)
                 }
                 
                 }

        task.resume()

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            let image = Image(imageData: selectedImage.pngData()!)
            images.append(image)
            
//            let imageData:NSData = selectedImage.pngData()! as NSData
//            let imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//            print("imageStr==>\(imageStr)")
            
            Image.saveImages(images)
            dismiss(animated: true, completion: nil)
            self.imagecollection.reloadData()
            
            let imageData: Data? = selectedImage.jpegData(compressionQuality: 0.4)
            let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
            print("imageStr====>\(imageStr)")
            self.arrayimage.append(imageStr)
    }
        
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddimageAction(_ sender: UIButton) {
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
    
    @IBAction func submitaction(_ sender: UIButton) {
        if validate(){
            CommercialPoolsApicall()
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
            remove(index: indexPath.row)
    }
    
    func remove(index: Int) {
        images.remove(at: index)
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
             
    textField.resignFirstResponder()
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


