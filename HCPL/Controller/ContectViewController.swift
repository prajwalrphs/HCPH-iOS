
import UIKit
import AMTabView

class ContectViewController: UIViewController,TabItem,UITableViewDelegate,UITableViewDataSource,MyocationFirst,MyocationSecond,MycallFirst,MycallSecond {

    var tabImage: UIImage? {
      return UIImage(named: "call-2")
    }
    
    @IBOutlet weak var Contactstable: UITableView!
    
    var indexsecondArray = ["For new mothers, infants and children services Women,infants and Children (WIC) Clinics"]
    var indexsecondArrayarrAddress = ["2223 West Loop South, Houston, TX 77027"]
    var indexsecondArrayarrMobile = ["(713) 407-5800"]
    
    var arrTitle = ["For Food establishment (Environmental Public Health)","For report issue (Home Screen)","For health Wellness Services(Disease Control and Clinical Prevention,plus Nutrition and Chronic Disease Prevention)","For animal issues(Veterinary Public Health)","For preparedness and response (Office of Public preparedness & Response)","For mosquito issues (Mosquito Control)"]
    
    var arrAddress = ["101 S. Richey Suite G. Pasadena, TX 77506","101 S. Richey Suite G. Pasadena, TX 77506","For general health and wellness services Clinical health Prevention Clinics","101 S. Richey Suite G. Pasadena, TX 77506","101 S. Richey Suite G. Pasadena, TX 77506","101 S. Richey Suite G. Pasadena, TX 77506"]
    
    var arrMap = ["101 S. Richey Suite G. Pasadena, TX 77506","2223 West Loop South, Houston, TX 77027","2223 West Loop South, Houston, TX 77027","612 Camino Road,Houston, TX 77076","2223 West Loop South, Houston, TX 77027","3330 Old Spanish Trail,Bldg. D, Houston, Tx 77021"]
    
    var arrMObile = ["(713)274-6300","(713)439-6000","(713)212-6800","(281)999-3191","(713)439-6000","(713)440-4800"]
    
    var LocationTagFirst:String!
    var LocationTagSecond:String!
    var CallTagFirst:String!
    var CallTagSecond:String!
    
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
    
    func btnidTappedLocationFirst(cell: ContactallTableViewCell) {
        
        let indexPath = self.Contactstable.indexPath(for: cell)

        let idget = arrMap[indexPath!.row]
                    
        LocationTagFirst = String(idget)
                    
        print("countid=>\(idget)")
                    
        cell.btnlocation.tag = Int(LocationTagFirst.count)
               
               if cell.btnlocation.tag == Int(LocationTagFirst.count){
                openMaps(title: idget)
               }
    }
    
    func btnidTappedLocationSecond(cell: ContactallTableViewCell) {
        
        let indexPath = self.Contactstable.indexPath(for: cell)

        let idget = indexsecondArrayarrAddress[0]
                    
        LocationTagSecond = String(idget)
                    
        print("countid=>\(idget)")
                    
        cell.btnlocationsecond.tag = Int(LocationTagSecond.count)
               
               if cell.btnlocationsecond.tag == Int(LocationTagSecond.count){
                openMaps(title: idget)
               }
    }
    
    func btnidTappedcallFirst(cell: ContactallTableViewCell) {
        
        let indexPath = self.Contactstable.indexPath(for: cell)

        
        let idget = arrMObile[indexPath!.row]
                    
        CallTagFirst = String(idget)
                    
        print("countid=>\(idget)")
                    
        cell.btncall.tag = Int(CallTagFirst.count)
               
               if cell.btncall.tag == Int(CallTagFirst.count){
                phone(phoneNum: idget)
               }
    }
    
    func btnidTappedcallSecond(cell: ContactallTableViewCell) {
        
        let indexPath = self.Contactstable.indexPath(for: cell)

        let idget = indexsecondArrayarrMobile[0]
                    
        CallTagSecond = String(idget)
                    
        print("countid=>\(idget)")
                    
        cell.btncallsecond.tag = Int(CallTagSecond.count)
               
               if cell.btncallsecond.tag == Int(CallTagSecond.count){
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    //Simulator iPhone 11 Pro
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ContactallTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactallTableViewCell", for: indexPath) as! ContactallTableViewCell
        
        if indexPath.row == 2{
            
//            if modelNameOrignal == "iPhone 8"{
//                cell.heightconstraint.constant = 460
//            }else{
//                cell.heightconstraint.constant = 400
//            }
//
//            if modelName == "Simulator iPhone 11 Pro"{
//                cell.heightconstraint.constant = 455
//            }else{
//                cell.heightconstraint.constant = 400
//            }
//
//            if modelNameOrignal == "iPhone 11 Pro"{
//                cell.heightconstraint.constant = 455
//            }else{
//                cell.heightconstraint.constant = 400
//            }
            
            if modelNameOrignal == "iPhone 8"{
                cell.heightconstraint.constant = 460
            }else if modelNameOrignal == "iPhone 11 Pro"{
                cell.heightconstraint.constant = 455
            }else{
                cell.heightconstraint.constant = 390
            }
            
            cell.delegateLocationFirst = self
            cell.delegateLocationSecond = self
            cell.delegatecallFirst = self
            cell.delegatecallSecond = self
            
            cell.mappinsecond.image = cell.mappin.image?.withRenderingMode(.alwaysTemplate)
            cell.mappinsecond.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.btnlocationsecond.layer.cornerRadius = 15
            cell.btnlocationsecond.layer.borderWidth = 1
            cell.btnlocationsecond.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

            cell.btncallsecond.layer.cornerRadius = 15
            cell.btncallsecond.layer.borderWidth = 1
            cell.btncallsecond.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.lbltitle.text = arrTitle[indexPath.row]
            cell.lbladdress.text = arrAddress[indexPath.row]
            cell.lblmap.text = arrMap[indexPath.row]
            cell.lblmobilenumber.text = arrMObile[indexPath.row]
            
            cell.lblsecondtitle.text = indexsecondArray[0]
            cell.lblsecondaddress.text = indexsecondArrayarrAddress[0]
            cell.lblsecondmobilenumber.text = indexsecondArrayarrMobile[0]
                        
            LocationTagSecond = indexsecondArrayarrAddress[0]
            CallTagSecond = indexsecondArrayarrMobile[0]
            
            cell.btnlocationsecond.tag = Int(LocationTagSecond.count)
            cell.btncallsecond.tag = Int(CallTagSecond.count)
            
            cell.contectview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.contectview.layer.shadowOpacity = 2
            cell.contectview.layer.shadowOffset = CGSize.zero
            cell.contectview.layer.shadowRadius = 2
            cell.contectview.layer.cornerRadius = 10
            
            cell.mappin.image = cell.mappin.image?.withRenderingMode(.alwaysTemplate)
            cell.mappin.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.btnlocation.layer.cornerRadius = 15
            cell.btnlocation.layer.borderWidth = 1
            cell.btnlocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            cell.btncall.layer.cornerRadius = 15
            cell.btncall.layer.borderWidth = 1
            cell.btncall.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
            print("onoff==>\(onoff ?? "")")
            
            if onoff == "on"{
                
//                @IBOutlet weak var lblsecondtitle: UILabel!
//                @IBOutlet weak var lblsecondaddress: UILabel!
//                @IBOutlet weak var lblsecondmobilenumber: UILabel!
                
                cell.lblsecondtitle.textColor = AppConstant.NormalTextColor
                cell.lblsecondaddress.textColor = AppConstant.NormalTextColor
                cell.lblsecondmobilenumber.textColor = AppConstant.NormalTextColor
                
                cell.lbltitle.textColor = AppConstant.LabelColor
                cell.lbladdress.textColor = AppConstant.NormalTextColor
                cell.lblmap.textColor = AppConstant.NormalTextColor
                cell.lblmobilenumber.textColor = AppConstant.NormalTextColor
                
                cell.contectview.backgroundColor = AppConstant.ViewColor
                cell.btnlocation.backgroundColor = AppConstant.ButtonColor
                cell.btncall.backgroundColor = AppConstant.ButtonColor
                cell.btncallsecond.backgroundColor = AppConstant.ButtonColor
                cell.btnlocationsecond.backgroundColor = AppConstant.ButtonColor
                
                cell.btnlocation.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
                cell.btnlocationsecond.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.btnlocation.setTitleColor(AppConstant.LabelColor, for: .normal)
                cell.btnlocationsecond.setTitleColor(AppConstant.LabelColor, for: .normal)
            }else if onoff == "off"{
                
            }else{
                
            }
            

        }else{
            
            cell.delegateLocationFirst = self
            cell.delegateLocationSecond = self
            cell.delegatecallFirst = self
            cell.delegatecallSecond = self
            
            if modelNameOrignal == "iPhone 8"{
                cell.heightconstraint.constant = 220
            }else if modelNameOrignal == "iPhone 11 Pro"{
                cell.heightconstraint.constant = 215
            }else{
                cell.heightconstraint.constant = 185
            }
            
//            if modelName == "Simulator iPhone 11 Pro"{
//                cell.heightconstraint.constant = 215
//            }else{
//                cell.heightconstraint.constant = 185
//            }
            
//            if modelNameOrignal == "iPhone 11 Pro"{
//                cell.heightconstraint.constant = 215
//            }else{
//                cell.heightconstraint.constant = 185
//            }
//
            cell.lbltitle.text = arrTitle[indexPath.row]
            cell.lbladdress.text = arrAddress[indexPath.row]
            cell.lblmap.text = arrMap[indexPath.row]
            cell.lblmobilenumber.text = arrMObile[indexPath.row]
            
            
            LocationTagFirst = arrMap[indexPath.row]
            CallTagFirst = arrMObile[indexPath.row]
            
            cell.btnlocation.tag = Int(LocationTagFirst.count)
            cell.btncall.tag = Int(CallTagFirst.count)
            
            cell.contectview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.contectview.layer.shadowOpacity = 2
            cell.contectview.layer.shadowOffset = CGSize.zero
            cell.contectview.layer.shadowRadius = 2
            cell.contectview.layer.cornerRadius = 10
            
            cell.mappin.image = cell.mappin.image?.withRenderingMode(.alwaysTemplate)
            cell.mappin.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            cell.btnlocation.layer.cornerRadius = 15
            cell.btnlocation.layer.borderWidth = 1
            cell.btnlocation.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

            cell.btncall.layer.cornerRadius = 15
            cell.btncall.layer.borderWidth = 1
            cell.btncall.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
            print("onoff==>\(onoff ?? "")")
            
            if onoff == "on"{
                
                cell.contectview.backgroundColor = AppConstant.ViewColor
                cell.btnlocation.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.btncall.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.lbltitle.textColor = AppConstant.LabelColor
                cell.lbladdress.textColor = AppConstant.NormalTextColor
                cell.lblmap.textColor = AppConstant.NormalTextColor
                cell.lblmobilenumber.textColor = AppConstant.NormalTextColor
                
                cell.btnlocation.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
                cell.btnlocationsecond.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.btnlocation.setTitleColor(AppConstant.LabelColor, for: .normal)
               
            }else if onoff == "off"{
                
            }else{
                
            }
            

        }
    
        
        return cell
        
    }
}


public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                    return "iPad (8th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                    return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                    return "iPad Air (4th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "AudioAccessory5,1":                       return "HomePod mini"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}
