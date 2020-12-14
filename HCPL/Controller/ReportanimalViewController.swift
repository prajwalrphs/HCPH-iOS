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

class ReportanimalViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var Statetxt: UITextField!
    @IBOutlet weak var mainDropDown: DropDown!
    @IBOutlet weak var check: UICheckbox!
    @IBOutlet weak var addimageview: UIView!
    @IBOutlet weak var addvideoview: UIView!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var addimagescollection: UICollectionView!
    @IBOutlet weak var addvideoscollection: UICollectionView!
    
    var images: [Image] = []
    
    
    var VideosongUrl : String!
    
    var arrOfFiles = [URL]()
    var arrOfFilesNames = [String]()
    var arrFiles = [URL]()
    var theItems = [URL]()
    var documentsUrl:URL!
    
    var videoURL : NSURL?
    
    var randomnumber:String!
    
    let countries = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","ldaho","illinois","lowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode island","south Carolina","south Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    let ids = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearAllFile()
 
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
    
    @IBAction func Going(_ sender: UIButton) {
        check.onSelectStateChanged = { (checkbox, selected) in
            debugPrint("Clicked - \(selected)")
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            let image = Image(imageData: selectedImage.pngData()!)
            print("image get video==>\(image)")
            images.append(image)
            Image.saveImages(images)
            dismiss(animated: true, completion: nil)
            self.addimagescollection.reloadData()
    }
        
        
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
                print("videourl: ", videoUrl)
                //trying compression of video
            
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
        
    
//        let asset = AVAsset(url: path)
//
//        let duration = asset.duration
//        let durationTime = CMTimeGetSeconds(duration)
//        print("durationTime==>\(durationTime)")
//
//        if durationTime >= 5.00{
//            print("jksbdjks")
//            //Alert
//        }else{
//             print("jksbdjkshkjbdkjbwedjkbeqwd")
//        }
        
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
