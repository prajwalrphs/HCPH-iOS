
import UIKit
import MapKit
import CoreLocation

class LocationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MyCellDelegateLocation,MyCellDelegatecall,MyCellDelegatecallsecond,CLLocationManagerDelegate {
    
    @IBOutlet weak var locationtable: UITableView!
    
    
    var TitleArray = [String]()
    var AddressArray = [String]()
    var FirstNumberArray = [String]()
    var secondTitleArray = [String]()
    var SecondNumberArray = [String]()
    
    var ConditionString:String!
    
    var LocationTag:String!
    var FirstCallTag:String!
    var SecondCallTag:String!
    
    let modelName = UIDevice.modelName
    let modelNameOrignal = UIDevice.current.name
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }else{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }
        
        print("hjshjdabskjdhbasjkd\(modelName)")
        print("Running on: \(UIDevice.modelName)")
        print("Running on current: \(modelNameOrignal)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
        
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func btnidTappedLocation(cell: LocationsTableViewCell) {
        let indexPath = self.locationtable.indexPath(for: cell)

        
        let idget = AddressArray[indexPath!.row]
                    
        LocationTag = String(idget)
                    
        print("countid=>\(idget)")
                    
        cell.btnLocation.tag = Int(LocationTag.count)
               
               if cell.btnLocation.tag == Int(LocationTag.count){
                openMaps(title: idget)
               }
    }
    
    
    
    func openMaps(title: String?) {
        let application = UIApplication.shared
        let encodedTitle = title?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let handlers = [
            ("Apple Maps", "http://maps.apple.com/?q=\(encodedTitle)"),
        ]
            .compactMap { (name, address) in URL(string: address).map { (name, $0) } }
            .filter { (_, url) in application.canOpenURL(url) }

        guard handlers.count > 1 else {
            if let (_, url) = handlers.first {
                application.open(url, options: [:])
            }
            return
        }

   
    }
   
    
    func btnidTappedcall(cell: LocationsTableViewCell) {
        let indexPath = self.locationtable.indexPath(for: cell)

        
        let idget = FirstNumberArray[indexPath!.row]
                    
        FirstCallTag = String(idget)
                    
        print("countid=>\(idget)")
                    
        cell.btnCallFirst.tag = Int(FirstCallTag.count)
               
               if cell.btnCallFirst.tag == Int(FirstCallTag.count){
                phone(phoneNum: idget)
               }
    }
    

    
    func btnidTappedcallsecond(cell: LocationsTableViewCell) {
        print("count")
        let indexPath = self.locationtable.indexPath(for: cell)

        
        let idget = SecondNumberArray[indexPath!.row]
                    
        SecondCallTag = String(idget)
                    
        print("countid=>\(idget)")
                    
        cell.btnCallSecond.tag = Int(SecondCallTag.count)
               
               if cell.btnCallSecond.tag == Int(SecondCallTag.count){
                phone(phoneNum: idget)
               }
    }
    
    func phone(phoneNum: String) {
        if let url = URL(string: "tel://\(phoneNum)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LocationsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LocationsTableViewCell", for: indexPath) as! LocationsTableViewCell
        
        
        if ConditionString == "Health and Wellness Clinic Services"{
            
            cell.delegatecall = self
            cell.delegatecallsecond = self
            cell.delegateLocation = self
            
            cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
            cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.lblsecondTitle.isHidden = true
            cell.lblSecondNumber.isHidden = true
            cell.btnCallSecond.isHidden = true
            
            cell.lblTitle.text = TitleArray[indexPath.row]
            cell.lblAddress.text = AddressArray[indexPath.row]
            cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
            cell.lblsecondTitle.text = secondTitleArray[indexPath.row]
            cell.lblSecondNumber.text = SecondNumberArray[indexPath.row]
            
            LocationTag = AddressArray[indexPath.row]
            FirstCallTag = FirstNumberArray[indexPath.row]
            SecondCallTag = SecondNumberArray[indexPath.row]
            
            cell.btnLocation.tag = Int(LocationTag.count)
            cell.btnCallFirst.tag = Int(FirstCallTag.count)
            cell.btnCallSecond.tag = Int(SecondCallTag.count)
            
            cell.Mainview.layer.cornerRadius = 10
            cell.Mainview.layer.borderWidth = 0.6
            cell.Mainview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
  
            
            cell.btnLocation.layer.cornerRadius = 15
            cell.btnLocation.layer.borderWidth = 1
            cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            cell.btnCallFirst.layer.cornerRadius = 15
            cell.btnCallFirst.layer.borderWidth = 1
            cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
         
            
            cell.btnCallSecond.layer.cornerRadius = 15
            cell.btnCallSecond.layer.borderWidth = 1
            cell.btnCallSecond.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            
            
                      let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                      print("onoff==>\(onoff ?? "")")
                      
                      if onoff == "on"{
                          
          //                cell.viewlayout.backgroundColor = AppConstant.ViewColor
          //                cell.lbl.textColor = AppConstant.LabelColor
          //                cell.ArrowRight.tintColor = AppConstant.LabelColor
          //                cell.viewlayout.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                          
                          cell.Mainview.backgroundColor = AppConstant.ViewColor
                          cell.Mainview.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                          cell.btnLocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                          cell.btnCallFirst.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                          cell.btnCallSecond.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                          
                          cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                          
                          cell.btnLocation.setTitleColor(AppConstant.LabelWhiteColor, for: .normal)
                          cell.lblAddress.textColor = AppConstant.LabelWhiteColor
                          cell.lblFirstNumber.textColor = AppConstant.LabelWhiteColor
                          cell.lblSecondNumber.textColor = AppConstant.LabelWhiteColor
                          cell.lblsecondTitle.textColor = AppConstant.LabelWhiteColor
                      }else if onoff == "off"{
                          
                      }else{
                          
                      }
            
//            if modelNameOrignal == "iPhone 8"{
//                cell.heightconstraint.constant = 205
//            }else{
//                cell.heightconstraint.constant = 185
//            }
//
//            if modelName == "Simulator iPhone 11 Pro"{
//                cell.heightconstraint.constant = 210
//            }else{
//                cell.heightconstraint.constant = 185
//            }
//
//            if modelNameOrignal == "iPhone 11 Pro"{
//                cell.heightconstraint.constant = 210
//            }else{
//                cell.heightconstraint.constant = 185
//            }
            
            if modelNameOrignal == "iPhone 8"{
                cell.heightconstraint.constant = 205
            }else if modelNameOrignal == "iPhone 11 Pro"{
                cell.heightconstraint.constant = 210
            }else if modelNameOrignal == "iPhone Xs"{
                cell.heightconstraint.constant = 205
            }else{
                cell.heightconstraint.constant = 185
            }
            

            
            
        }
        
        if ConditionString == "Refugee Health Screening Program"{
            if(indexPath.row == 0){
                
                cell.delegatecall = self
                cell.delegatecallsecond = self
                cell.delegateLocation = self
                
                cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
                cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                
                cell.lblsecondTitle.isHidden = true
                cell.lblSecondNumber.isHidden = true
                cell.btnCallSecond.isHidden = true
                
                cell.lblTitle.text = TitleArray[indexPath.row]
                cell.lblAddress.text = AddressArray[indexPath.row]
                cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
                cell.lblsecondTitle.text = secondTitleArray[indexPath.row]
                cell.lblSecondNumber.text = SecondNumberArray[indexPath.row]
                
                LocationTag = AddressArray[indexPath.row]
                FirstCallTag = FirstNumberArray[indexPath.row]
                SecondCallTag = SecondNumberArray[indexPath.row]
                
                cell.btnLocation.tag = Int(LocationTag.count)
                cell.btnCallFirst.tag = Int(FirstCallTag.count)
                cell.btnCallSecond.tag = Int(SecondCallTag.count)
                
                cell.Mainview.layer.cornerRadius = 10
                
                cell.Mainview.layer.borderWidth = 0.6
                cell.Mainview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
                
                
                cell.btnLocation.layer.cornerRadius = 15
                cell.btnLocation.layer.borderWidth = 1
                cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
                cell.btnCallFirst.layer.cornerRadius = 15
                cell.btnCallFirst.layer.borderWidth = 1
                cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
             
                
                cell.btnCallSecond.layer.cornerRadius = 15
                cell.btnCallSecond.layer.borderWidth = 1
                cell.btnCallSecond.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                
                cell.heightconstraint.constant = 185
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
                if onoff == "on"{
//                    cell.Mainview.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.9782107068)
//                    cell.btnLocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                    cell.btnCallFirst.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                    cell.btnCallSecond.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                    cell.lblAddress.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                    cell.lblFirstNumber.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                    cell.lblTitle.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                    cell.lblSecondNumber.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                    cell.lblsecondTitle.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
                    
                    cell.Mainview.backgroundColor = AppConstant.ViewColor
                    cell.Mainview.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                    cell.btnLocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.btnCallFirst.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.btnCallSecond.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    
                    cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                    
                    cell.btnLocation.setTitleColor(AppConstant.LabelWhiteColor, for: .normal)
                    cell.lblAddress.textColor = AppConstant.LabelWhiteColor
                    cell.lblFirstNumber.textColor = AppConstant.LabelWhiteColor
                    cell.lblSecondNumber.textColor = AppConstant.LabelWhiteColor
                    cell.lblsecondTitle.textColor = AppConstant.LabelWhiteColor
                }else if onoff == "off"{
                    
                }else{
                    
                }
                

                  
            }else{
                
                cell.delegatecall = self
                cell.delegatecallsecond = self
                cell.delegateLocation = self
                
                cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
                cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
                
                cell.lblsecondTitle.isHidden = true
                cell.lblSecondNumber.isHidden = true
                cell.btnCallSecond.isHidden = true
                
                cell.lblTitle.text = TitleArray[indexPath.row]
                cell.lblAddress.text = AddressArray[indexPath.row]
                cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
                
                LocationTag = AddressArray[indexPath.row]
                FirstCallTag = FirstNumberArray[indexPath.row]
                //SecondCallTag = SecondNumberArray[indexPath.row]
                
                cell.btnLocation.tag = Int(LocationTag.count)
                cell.btnCallFirst.tag = Int(FirstCallTag.count)
                //cell.btnCallSecond.tag = Int(SecondCallTag.count)
           
                cell.Mainview.layer.cornerRadius = 10
                
                cell.Mainview.layer.borderWidth = 0.6
                cell.Mainview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
                cell.btnLocation.layer.cornerRadius = 15
                cell.btnLocation.layer.borderWidth = 1
                cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
                cell.btnCallFirst.layer.cornerRadius = 15
                cell.btnCallFirst.layer.borderWidth = 1
                cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
             
                cell.heightconstraint.constant = 185
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
                if onoff == "on"{
//                    cell.Mainview.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.9782107068)
//                    cell.btnLocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                    cell.btnCallFirst.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                    cell.btnCallSecond.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                    cell.lblAddress.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                    cell.lblFirstNumber.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                    cell.lblTitle.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                    cell.lblSecondNumber.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                    cell.lblsecondTitle.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
                    
                    cell.Mainview.backgroundColor = AppConstant.ViewColor
                    cell.Mainview.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                    cell.btnLocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.btnCallFirst.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    cell.btnCallSecond.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    
                    cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                    
                    cell.btnLocation.setTitleColor(AppConstant.LabelWhiteColor, for: .normal)
                    cell.lblAddress.textColor = AppConstant.LabelWhiteColor
                    cell.lblFirstNumber.textColor = AppConstant.LabelWhiteColor
                    cell.lblSecondNumber.textColor = AppConstant.LabelWhiteColor
                    cell.lblsecondTitle.textColor = AppConstant.LabelWhiteColor
                }else if onoff == "off"{
                    
                }else{
                    
                }
                
            }
            
            if indexPath.row == 3{
                cell.heightconstraint.constant = 198
            }
        }
        
        
        if ConditionString == "Dental Services"{
            
            cell.delegatecall = self
            cell.delegatecallsecond = self
            cell.delegateLocation = self
            
            cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
            cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.lblsecondTitle.isHidden = true
            cell.lblSecondNumber.isHidden = true
            cell.btnCallSecond.isHidden = true
            
            cell.lblTitle.text = TitleArray[indexPath.row]
            cell.lblAddress.text = AddressArray[indexPath.row]
            cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
            
            LocationTag = AddressArray[indexPath.row]
            FirstCallTag = FirstNumberArray[indexPath.row]
            SecondCallTag = SecondNumberArray[indexPath.row]
            
            cell.btnLocation.tag = Int(LocationTag.count)
            cell.btnCallFirst.tag = Int(FirstCallTag.count)
            cell.btnCallSecond.tag = Int(SecondCallTag.count)
       
            cell.Mainview.layer.cornerRadius = 10
            cell.Mainview.layer.borderWidth = 0.6
            cell.Mainview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            cell.btnLocation.layer.cornerRadius = 15
            cell.btnLocation.layer.borderWidth = 1
            cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            cell.btnCallFirst.layer.cornerRadius = 15
            cell.btnCallFirst.layer.borderWidth = 1
            cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
            print("onoff==>\(onoff ?? "")")
            
            if onoff == "on"{
//                cell.Mainview.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.9782107068)
//                cell.btnLocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                cell.btnCallFirst.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                cell.btnCallSecond.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                cell.lblAddress.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                cell.lblFirstNumber.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                cell.lblTitle.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                cell.lblSecondNumber.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                cell.lblsecondTitle.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
                
                cell.Mainview.backgroundColor = AppConstant.ViewColor
                cell.Mainview.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                cell.btnLocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.btnCallFirst.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.btnCallSecond.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
                cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                
                cell.btnLocation.setTitleColor(AppConstant.LabelWhiteColor, for: .normal)
                cell.lblAddress.textColor = AppConstant.LabelWhiteColor
                cell.lblFirstNumber.textColor = AppConstant.LabelWhiteColor
                cell.lblSecondNumber.textColor = AppConstant.LabelWhiteColor
                cell.lblsecondTitle.textColor = AppConstant.LabelWhiteColor
            }else if onoff == "off"{
                
            }else{
                
            }
            
//            if modelNameOrignal == "iPhone 8"{
//                cell.heightconstraint.constant = 205
//            }else{
//                cell.heightconstraint.constant = 185
//            }
//
//            if modelName == "Simulator iPhone 11 Pro"{
//                cell.heightconstraint.constant = 200
//            }else{
//                cell.heightconstraint.constant = 185
//            }
//
//            if modelNameOrignal == "iPhone 11 Pro"{
//                cell.heightconstraint.constant = 200
//            }else{
//                cell.heightconstraint.constant = 185
//            }
            
            if modelNameOrignal == "iPhone 8"{
                cell.heightconstraint.constant = 205
            }else if modelNameOrignal == "iPhone 11 Pro"{
                cell.heightconstraint.constant = 200
            }else if modelNameOrignal == "iPhone Xs"{
                cell.heightconstraint.constant = 205
            }else{
                cell.heightconstraint.constant = 185
            }
            
        }
        
        if ConditionString == "WIC"{
            
            cell.delegatecall = self
            cell.delegatecallsecond = self
            cell.delegateLocation = self
            
            cell.locationimage.image = cell.locationimage.image?.withRenderingMode(.alwaysTemplate)
            cell.locationimage.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.lblsecondTitle.isHidden = true
            cell.lblSecondNumber.isHidden = true
            cell.btnCallSecond.isHidden = true
            cell.lblFirstNumber.isHidden = true
            
            cell.lblTitle.text = TitleArray[indexPath.row]
            cell.lblAddress.text = AddressArray[indexPath.row]
            //cell.lblFirstNumber.text = FirstNumberArray[indexPath.row]
            
            LocationTag = AddressArray[indexPath.row]
            FirstCallTag = FirstNumberArray[indexPath.row]
            //SecondCallTag = SecondNumberArray[indexPath.row]
            
            cell.btnLocation.tag = Int(LocationTag.count)
            cell.btnCallFirst.tag = Int(FirstCallTag.count)
            //cell.btnCallSecond.tag = Int(SecondCallTag.count)
       
            cell.Mainview.layer.cornerRadius = 10
            cell.Mainview.layer.borderWidth = 0.6
            cell.Mainview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            
            cell.btnLocation.layer.cornerRadius = 15
            cell.btnLocation.layer.borderWidth = 1
            cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            cell.btnCallFirst.layer.cornerRadius = 15
            cell.btnCallFirst.layer.borderWidth = 1
            cell.btnCallFirst.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)

            let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
            print("onoff==>\(onoff ?? "")")
            
            if onoff == "on"{
//                cell.Mainview.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.9782107068)
//                cell.btnLocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                cell.btnCallFirst.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                cell.btnCallSecond.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                cell.lblAddress.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                cell.lblFirstNumber.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                cell.lblTitle.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                cell.lblSecondNumber.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
//                cell.lblsecondTitle.textColor = #colorLiteral(red: 0.533272922, green: 0.5333681703, blue: 0.5332669616, alpha: 1)
                
                cell.Mainview.backgroundColor = AppConstant.ViewColor
                cell.Mainview.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                cell.btnLocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.btnCallFirst.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.btnCallSecond.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
                cell.btnLocation.layer.borderColor = #colorLiteral(red: 0.2588828802, green: 0.2548307478, blue: 0.2589023411, alpha: 1)
                
                cell.btnLocation.setTitleColor(AppConstant.LabelWhiteColor, for: .normal)
                cell.lblAddress.textColor = AppConstant.LabelWhiteColor
                cell.lblFirstNumber.textColor = AppConstant.LabelWhiteColor
                cell.lblSecondNumber.textColor = AppConstant.LabelWhiteColor
                cell.lblsecondTitle.textColor = AppConstant.LabelWhiteColor
                
            }else if onoff == "off"{
                
            }else{
                
            }
        
            //cell.Lblheightconstraint.constant = 0
            
//            if modelName == "Simulator iPhone 11 Pro"{
//                cell.heightconstraint.constant = 185
//            }else{
//                cell.heightconstraint.constant = 175
//            }
//
//            if modelNameOrignal == "iPhone 11 Pro"{
//                cell.heightconstraint.constant = 185
//            }else{
//                cell.heightconstraint.constant = 175
//            }
            
             if modelNameOrignal == "iPhone 11 Pro"{
                cell.heightconstraint.constant = 185
            }else if modelNameOrignal == "iPhone Xs"{
                cell.heightconstraint.constant = 185
            }else{
                cell.heightconstraint.constant = 175
            }
            
        }
      
        return cell
    }
    
 
}

extension UIDevice {
    /// Returns `true` if the device has a notch
    var hasNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}
