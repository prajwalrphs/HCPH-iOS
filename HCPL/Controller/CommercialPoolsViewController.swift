
import UIKit
import iOSDropDown
import MBProgressHUD
import SwiftyJSON
import Alamofire
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

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
    @IBOutlet weak var LimitLabel: UILabel!
    
    @IBOutlet var viewone: UIView!
    @IBOutlet var viewtwo: UIView!
    @IBOutlet var viewthree: UIView!
    @IBOutlet var viewfour: UIView!
    @IBOutlet var viewfive: UIView!
    
    
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
        
        txtcontactnumber.delegate = self
        
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
        
  
        
        txtdescription.autocapitalizationType = .sentences
        txtdescription.autocapitalizationType = .words
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
        self.hideKeyboardTappedAround()
        
        //self.updateCharacterCount()
        
        self.lbltitle.text = Title

        mainDropDown.selectedRowColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
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
        
        self.submitoutlate.layer.cornerRadius = 25
        
    }
    
    var MAX_LENGHTPhone = 10
    func Phonelenght(_ textField : UITextField){
        if let text = textField.text, text.count >= MAX_LENGHTPhone {
            textField.text = String(text.dropLast(text.count - MAX_LENGHTPhone))
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtcontactnumber{
            let MAX_LENGTH = 10
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updatedString.count <= MAX_LENGTH
        }else{
            return true
        }
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtnameaddress {
            let controller = storyboard?.instantiateViewController(withIdentifier: "FindLocationViewController") as! FindLocationViewController
            controller.modalPresentationStyle = .pageSheet
            controller.modalTransitionStyle = .coverVertical
            present(controller, animated: true, completion: nil)
            
            return true
        }else if textField == self.txtcontactnumber{
            self.Phonelenght(self.txtcontactnumber)
            return true
        }
      
     return false
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.openPopup), name: Notification.Name("remove_View"), object: nil)
    }

    @objc func openPopup(){
        let Address = UserDefaults.standard.string(forKey: AppConstant.CURRENTADDRESS)
        print("Address==>\(Address ?? "")")
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
      self.view.showToast(toastMessage: "Please provide Location", duration: 0.3)
                return false
    }else if self.txtfirstname.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please provide the First Name", duration: 0.3)
                return false
    }else if self.txtlastname.text?.isEmpty ?? true {
      self.view.showToast(toastMessage: "Please provide the Last Name", duration: 0.3)
                return false
    }else if self.txtcontactnumber.text!.count != 10{
        self.view.showToast(toastMessage: "Please provide the valid contact number.", duration: 0.3)
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
            "Place":txtnameaddress.text ?? "",
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
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            if validate(){
                CommercialPoolsApicall()
            }
        }else{
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Network unavailable please try later", duration: 0.3)
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


