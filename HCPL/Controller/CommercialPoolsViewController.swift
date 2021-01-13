//
//  CommercialPoolsViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 24/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import iOSDropDown

class CommercialPoolsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    var images: [Image] = []
    
    @IBOutlet weak var Statetxt: UITextField!
    @IBOutlet weak var mainDropDown: DropDown!
    @IBOutlet weak var txtnameaddress: UITextField!
    @IBOutlet weak var txtemailaddress: UITextField!
    @IBOutlet weak var txtfirstname: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var txtcontactnumber: UITextField!
    @IBOutlet weak var viewdescription: UIView!
    @IBOutlet weak var txtdescription: UITextField!
    @IBOutlet weak var viewaddimage: UIView!
    @IBOutlet weak var imagecollection: UICollectionView!
    @IBOutlet weak var addimage: UIButton!
    @IBOutlet weak var submitoutlate: UIButton!
    @IBOutlet weak var lbltitle: UILabel!
    
    var CommercialArray = [String]()
    var ids = [Int]()
    var Title:String!
    var PlaceholderGet:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lbltitle.text = title

        mainDropDown.optionArray = CommercialArray
        mainDropDown.optionIds = ids
        mainDropDown.checkMarkEnabled = false
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            let image = Image(imageData: selectedImage.pngData()!)
            print("image get video==>\(image)")
            images.append(image)
            Image.saveImages(images)
            dismiss(animated: true, completion: nil)
            self.imagecollection.reloadData()
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

        let indexPath = IndexPath(row: index, section: 0)
        imagecollection.performBatchUpdates({
            self.imagecollection.deleteItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
            self.imagecollection.reloadItems(at: self.imagecollection.indexPathsForVisibleItems)
        })
        
        print("images==>\(images)")
    }
    
}
