
import UIKit

class LeftMenuTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SwitchisOn {
 
    @IBOutlet weak var sidetable: UITableView!
    
    
    var arrlable = ["Home","Contacts","About","Privacy Policy","Report Issue","Enable Dark\n Mode"]
    var arrimages = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "call-2"),#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "baseline_privacy_tip_black_18dp"),#imageLiteral(resourceName: "alarm"),#imageLiteral(resourceName: "user"),#imageLiteral(resourceName: "baseline_insert_drive_file_black_18dp")]
    

    var SwitchTag:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .dark
             }
            sidetable.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        }else if onoff == "off"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }else{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }
        
        print("releaseVersionNumber==>\(Bundle.main.releaseVersionNumber ?? "")")
        print("buildVersionNumber==>\(Bundle.main.buildVersionNumber ?? "")")
        
        arrlable.append("Version \(Bundle.main.releaseVersionNumber ?? "")")

    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrimages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SidemenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SidemenuTableViewCell", for: indexPath) as! SidemenuTableViewCell
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{
            cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        }else{
            
        }
        
        if indexPath.row == 5{
            
            if onoff == "on"{
                cell.img.image = arrimages[indexPath.row]
                cell.lbl.text = arrlable[indexPath.row]
                cell.img.image = cell.img.image?.withRenderingMode(.alwaysTemplate)
                cell.img.tintColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)
                cell.darklightmode.isHidden = false
                cell.darklightmode.isOn = true
                cell.delegateSwitchisOn = self
                SwitchTag = arrlable[indexPath.row]
                cell.darklightmode.tag = Int(SwitchTag.count)
            }else{
                cell.img.image = arrimages[indexPath.row]
                cell.lbl.text = arrlable[indexPath.row]
                cell.img.image = cell.img.image?.withRenderingMode(.alwaysTemplate)
                cell.img.tintColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)
                cell.darklightmode.isHidden = false
                cell.darklightmode.isOn = false
                cell.delegateSwitchisOn = self
                SwitchTag = arrlable[indexPath.row]
                cell.darklightmode.tag = Int(SwitchTag.count)
            }

            
        }else{
            cell.img.image = arrimages[indexPath.row]
            cell.lbl.text = arrlable[indexPath.row]
            cell.img.image = cell.img.image?.withRenderingMode(.alwaysTemplate)
            cell.img.tintColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)
            cell.darklightmode.isHidden = true

        }
        
        return cell
        
    }
    
    func SwitchisOnTapped(cell: SidemenuTableViewCell) {
        
        let indexPath = self.sidetable.indexPath(for: cell)

        let idget = arrlable[indexPath!.row]
                    
        SwitchTag = String(idget)
                                        
        cell.darklightmode.tag = Int(SwitchTag.count)
               
        if cell.darklightmode.tag == Int(SwitchTag.count){
            
            
            
            if cell.darklightmode.isOn{
                print("is on")
                
                let alertController = UIAlertController(title: "Dear User", message: "Do you really want to chnage app theme?", preferredStyle: UIAlertController.Style.alert)

                let okAction = UIAlertAction(title: "OK", style: .default, handler: {(cAlertAction) in
                    UserDefaults.standard.set("on", forKey: AppConstant.ISONISOFF)
                    UIApplication.shared.windows.forEach { window in
                         window.overrideUserInterfaceStyle = .dark
                     }
                    let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    navigate.selectdtab = 2
                    self.navigationController?.pushViewController(navigate, animated: true)
                })
            
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            
            
                alertController.addAction(cancelAction)

                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
                
                
            }else{
                
                let alertController = UIAlertController(title: "Dear User", message: "Do you really want to chnage app theme?", preferredStyle: UIAlertController.Style.alert)

                let okAction = UIAlertAction(title: "OK", style: .default, handler: {(cAlertAction) in
                    print("of")
                    print("is off")
                    UserDefaults.standard.set("off", forKey: AppConstant.ISONISOFF)
                    UIApplication.shared.windows.forEach { window in
                         window.overrideUserInterfaceStyle = .light
                     }
                    let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    navigate.selectdtab = 2
                    self.navigationController?.pushViewController(navigate, animated: true)
                })
            
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            
            
                alertController.addAction(cancelAction)

                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
                
                
            }
        }
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 2
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 1{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 0
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 2{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 1
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 3{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 3
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 4{
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 4
            self.navigationController?.pushViewController(navigate, animated: true)
        }
 
    }
    
    
    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
    
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
