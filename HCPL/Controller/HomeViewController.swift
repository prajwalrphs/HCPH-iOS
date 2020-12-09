//
//  HomeViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 26/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import AMTabView
import SideMenu
import CoreLocation

class HomeViewController: UIViewController,TabItem,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {

    var tabImage: UIImage? {
      return UIImage(named: "home")
    }
    
    @IBOutlet weak var slidercollectionview: UICollectionView!
    @IBOutlet weak var mypagecontrol: UIPageControl!
    @IBOutlet weak var Cornerview: UIView!
    @IBOutlet weak var servicetable: UITableView!
    @IBOutlet weak var Programscollection: UICollectionView!
    
    let locationManager = CLLocationManager()

    
    var arrimage = [#imageLiteral(resourceName: "pic10"),#imageLiteral(resourceName: "pic11"),#imageLiteral(resourceName: "pic6"),#imageLiteral(resourceName: "pic1"),#imageLiteral(resourceName: "pic2"),#imageLiteral(resourceName: "pic4")]
    var arrlable = ["  Covide - 19","  Covide-19 Screening","  Mosquito Concerns","  Environmental","  Animal Services","  Food Services"]
    
    var ServicesPrograms = ["Clinic Service","Animal Service","Mosquito Concerns","Environmental","Food Service"]
    
    var ClinicServicesArr = ["Medical Clinics","Refugee Clinics","Dental Clinics","WIC","Eligibility"]
    var AnimalServiceArr = ["Shelter Animal","report Animal Cruelty","VPH maps","Events Calender","Wish List"]
    var MosquitoConcernsArr = ["Dead Bird","Mosquito Breeding Site","Disease Activity","Spray Area","Visit Our Website"]
    var EnvironmentalArr = ["Built Environmental","Pools","Drinking Water","Neighbourhood Nuisance","Lead Abatement"]
    var FoodServicesArr = ["Search establishments","Permit renewals","New Customer","Events and Marjets","FAQ"]
    
    var MedicalClinicsArr = ["Location","Hours","Dental"]
    var MedicalClinicsLabel = "Health and Wellness Clinic Services"
    
    var RefugeeClinicsArr = ["Location","Hours"]
    var RefugeeClinicsLabel = "Refugee Helth Screeing Program"
    
    var DentalClinicsArr = ["Location","Hours"]
    var DentalClinicsLabel = "Dental Services"
    
    var WICArr = ["Location","Hours"]
    var WICLabel = "Women, infants and Children (WIC)"
    
    
    
    var TableArr = [String]()
        
    var arrSelectedIndex = [IndexPath]()
    var arrSelectedData = [String]()

    var selectedList:[Bool] = [Bool]()
    
    var selectedRows = [IndexPath]()
    
    var timer:Timer?
    var currentcellindex = 0
    
    
    var settings = SideMenuSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if selectedRows.count > 0
        {
                selectedRows.removeAll()
        }
        let indexpath = IndexPath(row: 0, section: 0)
        self.selectedRows.append(indexpath)
        
        TableArr = ClinicServicesArr
        
        selectedList.removeAll()
        setupSideMenu()
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(slidetoNext), userInfo: nil, repeats: true)
        mypagecontrol.numberOfPages = arrimage.count
        viewConfigrations()
        
        Programscollection.allowsMultipleSelection = false
        
        selectedList = [Bool](repeating:false, count:arrlable.count)
    }
    
    
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
     
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
                
    }
    
    @objc func slidetoNext(){
        
        if currentcellindex < arrimage.count - 1{
            currentcellindex = currentcellindex + 1
        }else{
            currentcellindex = 0
        }
        mypagecontrol.currentPage = currentcellindex
        slidercollectionview.scrollToItem(at: IndexPath(item: currentcellindex, section: 0), at: .right, animated: true)
    }
    
    private func viewConfigrations() {
        
        slidercollectionview.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        slidercollectionview.contentInset = UIEdgeInsets.init(top: 0, left: 40, bottom: 0, right: 40)
        slidercollectionview.decelerationRate = UIScrollView.DecelerationRate.fast
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == Programscollection{
            return ServicesPrograms.count
        }else{
            return arrimage.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == Programscollection{
                
                let cell:ProgramsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramsCollectionViewCell", for: indexPath) as! ProgramsCollectionViewCell
                
                if selectedRows.contains(indexPath)
                {
                    
                    cell.viewround.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.137254902, blue: 0.2745098039, alpha: 1)
                    cell.lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    
                } else if indexPath.row == 0 {
                    
                    cell.viewround.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)

                }
                else{
                    cell.viewround.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)

                }


                    cell.lbl.text = ServicesPrograms[indexPath.row]

                    cell.viewround.layer.cornerRadius = 6
                     cell.viewround.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    cell.viewround.layer.borderWidth = 0.30
                    cell.viewround.clipsToBounds = true

                    return cell

            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
               cell.wallpaperImageView.image = arrimage[indexPath.row]
                cell.lbl.text = arrlable[indexPath.row]
                cell.lbl.layer.cornerRadius = 10
                cell.lbl.clipsToBounds = true
                cell.wallpaperImageView.layer.cornerRadius = 10
                cell.wallpaperImageView.clipsToBounds = true
               return cell
            }
            
          

        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize: CGSize = collectionView.bounds.size
        
        cellSize.width -= collectionView.contentInset.left
        cellSize.width -= collectionView.contentInset.right
        cellSize.height = cellSize.width
        
        return cellSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == Programscollection{
            
            let cell = collectionView.cellForItem(at: indexPath) as! ProgramsCollectionViewCell


            if indexPath.row == 0{
                TableArr = ClinicServicesArr
                servicetable.reloadData()
                if selectedRows.count > 0
                {
                    selectedRows.removeAll()
                }
                self.selectedRows.append(indexPath)
                collectionView.reloadData()
            }else if indexPath.row == 1{
                TableArr = AnimalServiceArr
                servicetable.reloadData()
                if selectedRows.count > 0
                {
                    selectedRows.removeAll()
                }
                self.selectedRows.append(indexPath)
                collectionView.reloadData()
            }else if indexPath.row == 2{
                TableArr = MosquitoConcernsArr
                servicetable.reloadData()
                if selectedRows.count > 0
                {
                    selectedRows.removeAll()
                }
                self.selectedRows.append(indexPath)
                collectionView.reloadData()
            }else if indexPath.row == 3{
                TableArr = EnvironmentalArr
                servicetable.reloadData()
                if selectedRows.count > 0
                {
                    selectedRows.removeAll()
                }
                self.selectedRows.append(indexPath)
                collectionView.reloadData()
            }else if indexPath.row == 4{
                TableArr = FoodServicesArr
                servicetable.reloadData()
                if selectedRows.count > 0
                {
                    selectedRows.removeAll()
                }
                self.selectedRows.append(indexPath)
                collectionView.reloadData()
            }
            
        }else{
            
        }
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ServicesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ServicesTableViewCell", for: indexPath) as! ServicesTableViewCell
        
        cell.lbl.text = TableArr[indexPath.row]
        cell.viewlayout.layer.cornerRadius = 10
        
        cell.viewlayout.backgroundColor = UIColor.white
        cell.viewlayout.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.viewlayout.layer.shadowOpacity = 2
        cell.viewlayout.layer.shadowOffset = CGSize.zero
        cell.viewlayout.layer.shadowRadius = 2

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if CLLocationManager.locationServicesEnabled() == true {
         
            if indexPath.row == 0{
                
                let naviagte:AllTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllTableViewController") as! AllTableViewController
                
                naviagte.TableArr = MedicalClinicsArr
                naviagte.TitleName = MedicalClinicsLabel
                
                self.navigationController?.pushViewController(naviagte, animated: true)
                
            }else if indexPath.row == 1{
                
            }else if indexPath.row == 2{
                
            }else if indexPath.row == 3{
                
            }
            
            
         } else {
         
            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disable. do you want to enable", preferredStyle: UIAlertController.Style.alert)

            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)

            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)
            
            
         }
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
}

extension UILabel {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}

extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

