
import UIKit
import AMTabView
import SideMenu
import CoreLocation

class HomeViewController: UIViewController,TabItem,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource, CLLocationManagerDelegate {

    var tabImage: UIImage? {
      return UIImage(named: "home")
    }
    
    @IBOutlet weak var slidercollectionview: UICollectionView!
    @IBOutlet weak var mypagecontrol: UIPageControl!
    @IBOutlet weak var Cornerview: UIView!
    @IBOutlet weak var servicetable: UITableView!
    @IBOutlet weak var Programscollection: UICollectionView!
    
    let locationManager = CLLocationManager()

    let flowLayout = ZoomAndSnapFlowLayout()
    
    var Sliderimagearr = [#imageLiteral(resourceName: "pic10"),#imageLiteral(resourceName: "pic10-1"),#imageLiteral(resourceName: "pic6"),#imageLiteral(resourceName: "pic1"),#imageLiteral(resourceName: "pic2"),#imageLiteral(resourceName: "pic4")]
    var SliderLabelarr = ["  COVID-19 Resources","  COVID-19 Screening tool","  Mosquito Concerns","  Environmental","  Animal Services","  Food Services"]
    
    var ServicesPrograms = ["Clinical Services","Animal Services","Mosquito Concerns","Environmental","Food Services"]
    
    var ClinicServicesArr = ["Medical Clinics","Refugee Clinics","Dental Clinics","WIC","Mobile Clinics"]
    var AnimalServiceArr = ["Shelter Animals","Report Animal Cruelty","VPH Maps","Events Calendar","Wish List","Visit Our Website"]
    var MosquitoConcernsArr = ["Dead Bird","Mosquito Breeding Site","Disease Activity","Spray Area","Visit Our Website"]
    var EnvironmentalArr = ["Built Environment","Pools","Drinking Water","Neighborhood Nuisance","Lead Abatement","Visit Our Website"]
    var FoodServicesArr = ["Search Establishments","Permit Renewals","New Customer","Events and Markets","FAQ","Nutrition & Healthy Living"]
    
    var MedicalClinicsArr = ["Locations","Hours","Dental"]
    var MedicalClinicsLabel = "Health and Wellness Clinic Services"
    
    var RefugeeClinicsArr = ["Locations","Hours"]
    var RefugeeClinicsLabel = "Refugee Health Screening Program"
    
    var DentalClinicsArr = ["Locations","Hours"]
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
    var currentcellindexScroll : Int!
    
    var FoodSafetyArray = ["Food Made Me Sick","Unclean Preparation","Something in My Food"]
    var Foodids = [1,2,3,4]
    var FoodTitle = "Food Safety"
    
    var CountCheck = 0
    
    var settings = SideMenuSettings()
    

    override func viewWillAppear(_ animated: Bool) {
       print("sbhcjkadsd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .dark
             }
        }else if onoff == "off"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }
        
        if selectedRows.count > 0
        {
                selectedRows.removeAll()
        }
        let indexpath = IndexPath(row: 0, section: 0)
        self.selectedRows.append(indexpath)
        
        TableArr = ClinicServicesArr
        
        selectedList.removeAll()
        setupSideMenu()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(slidetoNext), userInfo: nil, repeats: true)
        mypagecontrol.numberOfPages = Sliderimagearr.count
        
        viewConfigrations()
        
        Programscollection.allowsMultipleSelection = false
        
        selectedList = [Bool](repeating:false, count:SliderLabelarr.count)
    }
    
    @IBAction func changePage(_ sender: UIPageControl) {
      
        
        let Indexget = sender.currentPage
        
        mypagecontrol.currentPage = Indexget
        slidercollectionview.scrollToItem(at: IndexPath(item: Indexget, section: 0), at: .right, animated: true)
          
      }

    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("currentcellindexScroll==>\(currentcellindexScroll ?? 0)")
//        mypagecontrol.currentPage = currentcellindexScroll
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
    }
    
    private func setupSideMenu() {
        // Define the menus
        
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
                
    }
    
    @objc func slidetoNext(){
        
        if currentcellindex < Sliderimagearr.count - 1{
            currentcellindex = currentcellindex + 1
        }else{
            currentcellindex = 0
        }
        //print("currentcellindex==>\(currentcellindex)")
        mypagecontrol.currentPage = currentcellindex
        slidercollectionview.scrollToItem(at: IndexPath(item: currentcellindex, section: 0), at: .right, animated: true)
    }
    
    private func viewConfigrations() {
        
        slidercollectionview.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        slidercollectionview.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        slidercollectionview.decelerationRate = UIScrollView.DecelerationRate.normal
        //slidercollectionview.collectionViewLayout = flowLayout
        slidercollectionview.contentInsetAdjustmentBehavior = .always
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == Programscollection{
            return ServicesPrograms.count
        }else{
            return Sliderimagearr.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == Programscollection{
                
                let cell:ProgramsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramsCollectionViewCell", for: indexPath) as! ProgramsCollectionViewCell
                
                if selectedRows.contains(indexPath)
                {
                    
                    let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                    print("onoff==>\(onoff ?? "")")
                    
                    cell.viewround.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.137254902, blue: 0.2745098039, alpha: 1)
                    cell.lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    
                    if onoff == "on"{
                        cell.viewround.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.137254902, blue: 0.2745098039, alpha: 1)
                        cell.lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.viewround.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.137254902, blue: 0.2745098039, alpha: 1)
                    }else if onoff == "off"{
                        cell.viewround.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.137254902, blue: 0.2745098039, alpha: 1)
                        cell.lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.viewround.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.137254902, blue: 0.2745098039, alpha: 1)
                    }
                    

                    
                } else if indexPath.row == 0 {
                    
                    cell.viewround.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                    
                    let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                    print("onoff==>\(onoff ?? "")")
                    
                    if onoff == "on"{
                        cell.viewround.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.lbl.textColor = AppConstant.LabelWhiteColor
                        cell.viewround.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    }else if onoff == "off"{
                        cell.viewround.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                        cell.viewround.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    }

                }
                else{
                    
                    cell.viewround.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                    
                    let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                    print("onoff==>\(onoff ?? "")")
                    
                    if onoff == "on"{
                        cell.viewround.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        cell.lbl.textColor = AppConstant.LabelWhiteColor
                        cell.viewround.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    }else if onoff == "off"{
                        cell.viewround.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        cell.lbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                        cell.viewround.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    }

                }


                    cell.lbl.text = ServicesPrograms[indexPath.row]

                    cell.viewround.layer.cornerRadius = 13
                    cell.viewround.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    cell.viewround.layer.borderWidth = 0.30
                    cell.viewround.clipsToBounds = true
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
                if onoff == "on"{
                    cell.viewround.layer.cornerRadius = 13
                    cell.viewround.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.viewround.layer.borderWidth = 1
                    cell.viewround.clipsToBounds = true
                }else if onoff == "off"{
                    cell.viewround.layer.cornerRadius = 13
                    cell.viewround.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    cell.viewround.layer.borderWidth = 0.30
                    cell.viewround.clipsToBounds = true
                }

                    return cell

            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
                
                
                cell.wallpaperImageView.image = Sliderimagearr[indexPath.row]
                cell.lbl.text = SliderLabelarr[indexPath.row]
                cell.cornerview.layer.cornerRadius = 15
                cell.cornerview.clipsToBounds = true
                
//                let DotCount = indexPath.row
//
//                mypagecontrol.currentPage = DotCount - 1
                
//                cell.lbl.layer.cornerRadius = 10
//                cell.lbl.clipsToBounds = true
//                cell.wallpaperImageView.layer.cornerRadius = 10
//                cell.wallpaperImageView.clipsToBounds = true
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
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
   
            targetContentOffset.pointee = scrollView.contentOffset
            var indexes = self.slidercollectionview.indexPathsForVisibleItems
            indexes.sort()
            var index = indexes.first!
            let cell = self.slidercollectionview.cellForItem(at: index)!
            let position = self.slidercollectionview.contentOffset.x - cell.frame.origin.x
            if position > cell.frame.size.width/2{
               index.row = index.row+1
            }
            print("index==>===>\(index)")
            print("indexrow==>===>\(index.row)")
            mypagecontrol.currentPage = index.row
            self.slidercollectionview.scrollToItem(at: index, at: .right, animated: true )
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == Programscollection{
            
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
            
            if indexPath.row == 0{
                naviGetTo(url: "https://publichealth.harriscountytx.gov/Resources/2019-Novel-Coronavirus", title: "Covid-19 Resources")
            }
            if indexPath.row == 1{
                naviGetTo(url: "https://harriscounty.maps.arcgis.com/apps/opsdashboard/index.html#/c0de71f8ea484b85bb5efcb7c07c6914", title: "Covid-19 Screening tool")
            }
            if indexPath.row == 2{
                let naviagte:MosquitoConcernsViewController = self.storyboard?.instantiateViewController(withIdentifier: "MosquitoConcernsViewController") as! MosquitoConcernsViewController
                self.navigationController?.pushViewController(naviagte, animated: true)
            }
            
            if indexPath.row == 3{
                let naviagte:EnvironmentalViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnvironmentalViewController") as! EnvironmentalViewController
                naviagte.TableArrScroll = EnvironmentalArr
                naviagte.MainTitle = "Environmental"
                self.navigationController?.pushViewController(naviagte, animated: true)
            }
            
            if indexPath.row == 4{
                let naviagte:EnvironmentalViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnvironmentalViewController") as! EnvironmentalViewController
                naviagte.TableArrScroll = AnimalServiceArr
                naviagte.MainTitle = "Animal Services"
                self.navigationController?.pushViewController(naviagte, animated: true)
            }
            
            if indexPath.row == 5{
                let naviagte:EnvironmentalViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnvironmentalViewController") as! EnvironmentalViewController
                naviagte.TableArrScroll = FoodServicesArr
                naviagte.MainTitle = "Food Services"
                self.navigationController?.pushViewController(naviagte, animated: true)
            }
            
            
        }
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ServicesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ServicesTableViewCell", for: indexPath) as! ServicesTableViewCell
        
        cell.lbl.text = TableArr[indexPath.row]
        cell.viewlayout.layer.cornerRadius = 7
        
        cell.viewlayout.layer.borderWidth = 0.6
        cell.viewlayout.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            cell.viewlayout.backgroundColor = AppConstant.ViewColor
            cell.lbl.textColor = AppConstant.NormalTextColor
            cell.ArrowRight.tintColor = AppConstant.LabelColor
            cell.viewlayout.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)

        }else if onoff == "off"{
            
        }else{
            
        }
        
        
        //cell.viewlayout.backgroundColor = UIColor.white
//        cell.viewlayout.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        cell.viewlayout.layer.shadowOpacity = 2
//        cell.viewlayout.layer.shadowOffset = CGSize.zero
//        cell.viewlayout.layer.shadowRadius = 2
        
        return cell
    }
    
    //808
    //432
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if Reachability.isConnectedToNetwork(){
         
            if CLLocationManager.locationServicesEnabled() == true {
             
                if TableArr == ClinicServicesArr{
                    print("is Equal")
                    if indexPath.row == 0{
                        
                        let naviagte:AllTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllTableViewController") as! AllTableViewController
                        
                        naviagte.TableArr = MedicalClinicsArr
                        naviagte.TitleName = MedicalClinicsLabel
                        naviagte.Titlehead = "Medical Clinics"
                        
                        
                        self.navigationController?.pushViewController(naviagte, animated: true)
                        
                    }else if indexPath.row == 1{
                        
                        let naviagte:AllTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllTableViewController") as! AllTableViewController
                        
                        naviagte.TableArr = RefugeeClinicsArr
                        naviagte.TitleName = RefugeeClinicsLabel
                        naviagte.Titlehead = "Refugee Clinics"
                        
                        self.navigationController?.pushViewController(naviagte, animated: true)
                        
                    }else if indexPath.row == 2{
                        
                        let naviagte:AllTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllTableViewController") as! AllTableViewController
                        
                        naviagte.TableArr = DentalClinicsArr
                        naviagte.TitleName = DentalClinicsLabel
                        naviagte.Titlehead = "Dental Clinics"
                        
                        self.navigationController?.pushViewController(naviagte, animated: true)
                        
                    }else if indexPath.row == 3{
                        
                        let naviagte:AllTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllTableViewController") as! AllTableViewController
                        
                        naviagte.TableArr = WICArr
                        naviagte.TitleName = WICLabel
                        naviagte.Titlehead = "WIC"
                        
                        self.navigationController?.pushViewController(naviagte, animated: true)
                        
                    }else if indexPath.row == 4{
                        let naviagte:MobileClinicsViewController = self.storyboard?.instantiateViewController(withIdentifier: "MobileClinicsViewController") as! MobileClinicsViewController
                        
                        self.navigationController?.pushViewController(naviagte, animated: true)
                    }
                }else if TableArr == AnimalServiceArr{
                    if indexPath.row == 0{
                        openAppStore()
    //                    if let url = URL(string: "https://apps.apple.com/in/app/petharbor-mobile/id989353019") {
    //                        UIApplication.shared.open(url)
    //                    }
                    }else if indexPath.row == 1{
                        print("one click")
                        //ReportanimalViewController
                        let naviagte:ReportanimalViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReportanimalViewController") as! ReportanimalViewController
                        
                        self.navigationController?.pushViewController(naviagte, animated: true)
                    }else if indexPath.row == 2{
                        let alert = UIAlertController(title: "",
                            message: "",
                            preferredStyle: .alert)
                        
                        let attribMsg = NSAttributedString(string: "What are you trying to locate?",
                                                           attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
         
                        alert.setValue(attribMsg, forKey: "attributedTitle")
                        
                        let action1 = UIAlertAction(title: "Vet Clinic Location", style: .default, handler: { (action) -> Void in
                                print("ACTION 1 selected!")
                            
                            //Android Bhatti
                            //http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=eab1cd0f94b34f2ca8c08fec6aeacf1b
                            
//                                self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=4c596ce857ef4b50930c603f2fdef55e", title: "Vet Clinic")
                            
                            self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=eab1cd0f94b34f2ca8c08fec6aeacf1b", title: "Vet Clinic")
                            })
                         
                            let action2 = UIAlertAction(title: "Dangerous Animal's Location", style: .default, handler: { (action) -> Void in
                                print("ACTION 2 selected!")
                                self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=bc063b6062ec4d86a282b13a0c566a7a", title: "Dangerous Animal's")
                            })
                         
                            let action3 = UIAlertAction(title: "Rabies Outbreak Location", style: .default, handler: { (action) -> Void in
                                print("ACTION 3 selected!")
                                self.naviGetTo(url: "http://harriscounty.maps.arcgis.com/apps/webappviewer/index.html?id=4c596ce857ef4b50930c603f2fdef55e", title: "Rabies Outbreak")
                            })
                             
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                        
                        // Restyle the view of the Alert
                        
                        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                        print("onoff==>\(onoff ?? "")")
                        
                        if onoff == "on"{
                            alert.view.tintColor = AppConstant.LabelWhiteColor
                        }else{
                            alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                        }
                        
                        
                        alert.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        alert.view.layer.cornerRadius = 25
                        
                        alert.addAction(action1)
                        alert.addAction(action2)
                        alert.addAction(action3)
                        alert.addAction(cancel)
                        present(alert, animated: true, completion: nil)
                        
                    }else if indexPath.row == 3{
                        self.naviGetTo(url: "http://countypets.com/Event-Calendar", title: "Event Calendar")
                    }else if indexPath.row == 4{
                        //UIApplication.shared.open(URL(string: "https://www.amazon.com/hz/wishlist/ls/14I5Q47TPD5CE?&")!, options: [:], completionHandler: nil)
                        self.naviGetTo(url: "https://www.amazon.com/hz/wishlist/ls/14I5Q47TPD5CE?&", title: "Wish List")
                    }else if indexPath.row == 5{
                        self.naviGetTo(url: "https://www.countypets.com", title: "Website")
                                              
                    }
                    
                }else if TableArr == MosquitoConcernsArr{
                    if indexPath.row == 0{
                        
                        if CLLocationManager.locationServicesEnabled() == true {
                            if CLLocationManager.locationServicesEnabled() {
                                switch CLLocationManager.authorizationStatus() {
                                    case .notDetermined, .restricted, .denied:
                                        print("No access")
                                        let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                                        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                            //Redirect to Settings app
                                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                                        })

                                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                                        alertController.addAction(cancelAction)

                                        alertController.addAction(okAction)

                                        self.present(alertController, animated: true, completion: nil)
                                    case .authorizedAlways, .authorizedWhenInUse:
                                        print("Access")
                                        let naviagte:DeadbirdViewController = self.storyboard?.instantiateViewController(withIdentifier: "DeadbirdViewController") as! DeadbirdViewController
                                        self.navigationController?.pushViewController(naviagte, animated: true)
                                    @unknown default:
                                    break
                                }
                                } else {
                                    print("Location services are not enabled")
                            }

                        }else{
                            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })

                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                            alertController.addAction(cancelAction)

                            alertController.addAction(okAction)

                            self.present(alertController, animated: true, completion: nil)
                        }
                                      

                        
                    }else if indexPath.row == 1{
                        
                        
                        if CLLocationManager.locationServicesEnabled() == true {
                            if CLLocationManager.locationServicesEnabled() {
                                switch CLLocationManager.authorizationStatus() {
                                    case .notDetermined, .restricted, .denied:
                                        print("No access")
                                        let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                                        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                            //Redirect to Settings app
                                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                                        })

                                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                                        alertController.addAction(cancelAction)

                                        alertController.addAction(okAction)

                                        self.present(alertController, animated: true, completion: nil)
                                    case .authorizedAlways, .authorizedWhenInUse:
                                        print("Access")
                                        let naviagte:MosquitoBreedingViewController = self.storyboard?.instantiateViewController(withIdentifier: "MosquitoBreedingViewController") as! MosquitoBreedingViewController
                                        self.navigationController?.pushViewController(naviagte, animated: true)
                                    @unknown default:
                                    break
                                }
                                } else {
                                    print("Location services are not enabled")
                            }

                        }else{
                            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })

                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                            alertController.addAction(cancelAction)

                            alertController.addAction(okAction)

                            self.present(alertController, animated: true, completion: nil)
                        }

                           
                    }else if indexPath.row == 2{
                        
                        
                        if CLLocationManager.locationServicesEnabled() == true {
                            if CLLocationManager.locationServicesEnabled() {
                                switch CLLocationManager.authorizationStatus() {
                                    case .notDetermined, .restricted, .denied:
                                        print("No access")
                                        let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                                        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                            //Redirect to Settings app
                                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                                        })

                                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                                        alertController.addAction(cancelAction)

                                        alertController.addAction(okAction)

                                        self.present(alertController, animated: true, completion: nil)
                                    case .authorizedAlways, .authorizedWhenInUse:
                                        print("Access")
                                        let naviagte:MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                                        naviagte.TitleHead = "Disease Activity"
                                        self.navigationController?.pushViewController(naviagte, animated: true)
                                    @unknown default:
                                    break
                                }
                                } else {
                                    print("Location services are not enabled")
                            }

                        }else{
                            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })

                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                            alertController.addAction(cancelAction)

                            alertController.addAction(okAction)

                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                    
                        
                    }else if indexPath.row == 3{
                        
                        
                        
                        if CLLocationManager.locationServicesEnabled() == true {
                            if CLLocationManager.locationServicesEnabled() {
                                switch CLLocationManager.authorizationStatus() {
                                    case .notDetermined, .restricted, .denied:
                                        print("No access")
                                        let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                                        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                            //Redirect to Settings app
                                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                                        })

                                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                                        alertController.addAction(cancelAction)

                                        alertController.addAction(okAction)

                                        self.present(alertController, animated: true, completion: nil)
                                    case .authorizedAlways, .authorizedWhenInUse:
                                        print("Access")
                                        let naviagte:MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                                        naviagte.TitleHead = "Spray Area"
                                        self.navigationController?.pushViewController(naviagte, animated: true)
                                    @unknown default:
                                    break
                                }
                                } else {
                                    print("Location services are not enabled")
                            }

                        }else{
                            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })

                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                            alertController.addAction(cancelAction)

                            alertController.addAction(okAction)

                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                      
                           
                    }else if indexPath.row == 4{
                        
                        self.naviGetTo(url: "https://www.countypets.com", title: "Website")
                        
                    }else if indexPath.row == 5{
                        
               
                        let alert = UIAlertController(title: "",
                            message: "",
                            preferredStyle: .alert)
                        
                        let attribMsg = NSAttributedString(string: "What would you like to report?",
                                                           attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
         
                        alert.setValue(attribMsg, forKey: "attributedTitle")
                        
                        let action1 = UIAlertAction(title: "Dead Birds", style: .default, handler: { (action) -> Void in
                            let naviagte:DeadbirdViewController = self.storyboard?.instantiateViewController(withIdentifier: "DeadbirdViewController") as! DeadbirdViewController
                            self.navigationController?.pushViewController(naviagte, animated: true)
                            })
                         
                        let action2 = UIAlertAction(title: "Mosquito Breeding Site", style: .default, handler: { (action) -> Void in
                            let naviagte:MosquitoBreedingViewController = self.storyboard?.instantiateViewController(withIdentifier: "MosquitoBreedingViewController") as! MosquitoBreedingViewController
                            self.navigationController?.pushViewController(naviagte, animated: true)
                            })
                         
                             
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                        
                        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                        print("onoff==>\(onoff ?? "")")
                        
                        if onoff == "on"{
                            alert.view.tintColor = AppConstant.LabelWhiteColor
                        }else{
                            alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                        }
                        // Restyle the view of the Alert
                        alert.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  // change background color
                        alert.view.layer.cornerRadius = 25
                        
                        alert.addAction(action1)
                        alert.addAction(action2)
                        alert.addAction(cancel)
                        present(alert, animated: true, completion: nil)
                        
                    }
                }else if TableArr == EnvironmentalArr{
                    if indexPath.row == 0{
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Programs/Built-Environment-Program", title: "Built Environment")
                    }else if indexPath.row == 1{
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Programs/Pool-Permits-and-Water-Safety", title: "Pools")
                    }else if indexPath.row == 2{
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Drinking-Water", title: "Drinking Water")
                    }else if indexPath.row == 3{
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Services/NeighborhoodNuisance", title: "Neighborhood Nuisance")
                    }else if indexPath.row == 4{
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/Programs/Lead-Hazard-Control", title: "Lead Abatement")
                    }else{
                        self.naviGetTo(url: "https://publichealth.harriscountytx.gov/About/Organization-Offices/Environmental-Public-Health", title:"Website")
                    }
                }else if TableArr == FoodServicesArr{
                    if indexPath.row == 0{
                        
                        if CLLocationManager.locationServicesEnabled() {
                            switch CLLocationManager.authorizationStatus() {
                                case .notDetermined, .restricted, .denied:
                                    print("No access")
                                    let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                                    let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                        //Redirect to Settings app
                                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                                    })

                                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                                    alertController.addAction(cancelAction)

                                    alertController.addAction(okAction)

                                    self.present(alertController, animated: true, completion: nil)
                                case .authorizedAlways, .authorizedWhenInUse:
                                    print("Access")
                                    let naviagte:SearchEstablishmentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchEstablishmentsViewController") as! SearchEstablishmentsViewController
                                    naviagte.TitleHead = "Search Establishments"
                                    self.navigationController?.pushViewController(naviagte, animated: true)
                                @unknown default:
                                break
                            }
                            } else {
                                print("Location services are not enabled")
                        }
                        
                    }else if indexPath.row == 1{
                        let alert = UIAlertController(title: "",
                            message: "",
                            preferredStyle: .alert)
                        
                        let attribMsg = NSAttributedString(string: "Permit Renewal",
                                                           attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
         
                        alert.setValue(attribMsg, forKey: "attributedTitle")
                        
                        let action1 = UIAlertAction(title: "Fixed Food Establishments", style: .default, handler: { (action) -> Void in
                                print("ACTION 1 selected!")
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Fixed-Food-Establishments", title: "Permit Renewal")
                            })
                         
                            let action2 = UIAlertAction(title: "Mobile Units New", style: .default, handler: { (action) -> Void in
                                print("ACTION 2 selected!")
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Mobile-Units-New", title: "Permit Renewal")
                            })
                         
                            let action3 = UIAlertAction(title: "Change Of Ownership", style: .default, handler: { (action) -> Void in
                                print("ACTION 3 selected!")
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Change-of-Ownership", title: "Permit Renewal")
                            })
                             
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                        
                        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                        print("onoff==>\(onoff ?? "")")
                        
                        if onoff == "on"{
                            alert.view.tintColor = AppConstant.LabelWhiteColor
                        }else{
                            alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                        }
                        // Restyle the view of the Alert
                        alert.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  // change background color
                        alert.view.layer.cornerRadius = 25
                        
                        alert.addAction(action1)
                        alert.addAction(action2)
                        alert.addAction(action3)
                        alert.addAction(cancel)
                        present(alert, animated: true, completion: nil)
                    }else if indexPath.row == 2{
                        let alert = UIAlertController(title: "",
                            message: "",
                            preferredStyle: .alert)
                        
                        let attribMsg = NSAttributedString(string: "New Customer",
                                                           attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
         
                        alert.setValue(attribMsg, forKey: "attributedTitle")
                        
                        let action1 = UIAlertAction(title: "Fixed Food Establishments", style: .default, handler: { (action) -> Void in
                                print("ACTION 1 selected!")
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Fixed-Food-Establishments", title: "New Customer")
                            })
                         
                            let action2 = UIAlertAction(title: "Mobile Units New", style: .default, handler: { (action) -> Void in
                                print("ACTION 2 selected!")
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Mobile-Units-New", title: "New Customer")
                            })
                         
                            let action3 = UIAlertAction(title: "Change Of Ownership", style: .default, handler: { (action) -> Void in
                                print("ACTION 3 selected!")
                                self.naviGetTo(url: "https://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/New-Customers/Change-of-Ownership", title: "New Customer")
                            })
                             
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                        
                        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                        print("onoff==>\(onoff ?? "")")
                        
                        if onoff == "on"{
                            alert.view.tintColor = AppConstant.LabelWhiteColor
                        }else{
                            alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                        }
                        // Restyle the view of the Alert
                        alert.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  // change background color
                        alert.view.layer.cornerRadius = 25
                        
                        alert.addAction(action1)
                        alert.addAction(action2)
                        alert.addAction(action3)
                        alert.addAction(cancel)
                        present(alert, animated: true, completion: nil)
                    }else if indexPath.row == 3{
                        let alert = UIAlertController(title: "",
                            message: "",
                            preferredStyle: .alert)
                        
                        let attribMsg = NSAttributedString(string: "Events and Markets",
                                                           attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23.0)])
         
                        alert.setValue(attribMsg, forKey: "attributedTitle")
                        
                        let action1 = UIAlertAction(title: "Farmers Market Vendor", style: .default, handler: { (action) -> Void in
                                print("ACTION 1 selected!")
                                self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Events-and-Markets/Farmers-Market-Vendors", title: "Events and Markets")
                            })
                         
                            let action2 = UIAlertAction(title: "Food Sample Permit", style: .default, handler: { (action) -> Void in
                                print("ACTION 2 selected!")
                                self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Events-and-Markets/Food-Sample-Permit", title: "Events and Markets")
                            })
                         
                            let action3 = UIAlertAction(title: "Temporary Event Permit", style: .default, handler: { (action) -> Void in
                                print("ACTION 3 selected!")
                                self.naviGetTo(url: "http://publichealth.harriscountytx.gov/Services-Programs/All-Services/Food-Permits/Events-and-Markets/Temporary-Event", title: "Events and Markets")
                            })
                             
                            // Cancel button
                            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
                        
                        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                        print("onoff==>\(onoff ?? "")")
                        
                        if onoff == "on"{
                            alert.view.tintColor = AppConstant.LabelWhiteColor
                        }else{
                            alert.view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                        }
                        // Restyle the view of the Alert
                        alert.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  // change background color
                        alert.view.layer.cornerRadius = 25
                        
                        alert.addAction(action1)
                        alert.addAction(action2)
                        alert.addAction(action3)
                        alert.addAction(cancel)
                        present(alert, animated: true, completion: nil)
                    }else if indexPath.row == 4{
                        self.naviGetTo(url: "http://publichealth.harriscountytx.gov/About/Organization-Offices/EPH/Food-Safety", title: "FAQ")
                    }else if indexPath.row == 5{
                        self.naviGetTo(url: "https://publichealth.harriscountytx.gov/about/Organization/NCDP", title: "Nutrition & Healthy Living")
                    }
//                    else{
//                        let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
//                        navigate.CommercialArray = FoodSafetyArray
//                        navigate.ids = Foodids
//                        navigate.Title = FoodTitle
//                        navigate.PlaceholderGet = "Choose Subject"
//                        self.navigationController?.pushViewController(navigate, animated: true)
//                    }
                }
            
             } else {
             
                let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                    //Redirect to Settings app
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })

                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                alertController.addAction(cancelAction)

                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
                
                
             }
            
        }else{
     
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
        

    }
    
    func openAppStore() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/petharbor-mobile/id989353019"),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    print("App Store Opened")
                }
            }
        } else {
            print("Can't Open URL on Simulator")
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
    
    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
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


class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {

    let activeDistance: CGFloat = 100
    let zoomFactor: CGFloat = 0.3

    override init() {
        super.init()

        scrollDirection = .horizontal
        minimumLineSpacing = 20
        itemSize = CGSize(width: 100, height: 100)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)

        super.prepare()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)

        // Make the cells be zoomed when they reach the center of the screen
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = distance / activeDistance

            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }

        return rectAttributes
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }

        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    
}

