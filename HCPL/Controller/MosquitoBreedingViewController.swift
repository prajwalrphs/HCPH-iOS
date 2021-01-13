//
//  MosquitoBreedingViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 23/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import iOSDropDown

class MosquitoBreedingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var images: [Image] = []
    
    @IBOutlet weak var submitoutlate: UIButton!
    @IBOutlet weak var viewmain: UIView!
    @IBOutlet weak var Mosquitocollection: UICollectionView!
    @IBOutlet weak var plusimage: UIButton!
    
    @IBOutlet weak var Timeofday: UITextField!
    @IBOutlet weak var mainDropDown: DropDown!
    
    var TimeofArray = ["Day","Night","Both"]
    let ids = [1,2,3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    
}
