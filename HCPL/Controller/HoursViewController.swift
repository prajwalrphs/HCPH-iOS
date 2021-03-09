
import UIKit

class HoursViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var lblheadTitle: UILabel!
    
    var WeekArray = [String]()
    var Timearray = [String]()
    var CallArray = [String]()
    var ClinicArray = [String]()
    var NumberArray = [String]()
    
    var TitleTopBar:String!
    
        
    @IBOutlet weak var tableView: UITableView!
    
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
        self.lblheadTitle.text = TitleTopBar
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
          return 3
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section==0{
            return WeekArray.count
            
        }
        else if section == 1{
            return CallArray.count
        }
        else {
            
            return ClinicArray.count
           
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeekTableViewCell") as! WeekTableViewCell
            cell.weekday.text = WeekArray[indexPath.row]
            cell.time.text = Timearray[indexPath.row]
//            cell.time.layer.cornerRadius = 15
//            cell.time.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            cell.time.layer.borderWidth = 1
//            cell.time.clipsToBounds = true
            
            cell.borderview.layer.cornerRadius = 10
            cell.borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.borderview.layer.borderWidth = 1
            cell.borderview.clipsToBounds = true
            
            cell.viewborder.layer.cornerRadius = 3
            cell.viewborder.layer.borderWidth = 0.6
            cell.viewborder.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
            print("onoff==>\(onoff ?? "")")
            
            if onoff == "on"{
                cell.viewborder.backgroundColor = AppConstant.ViewColor
                cell.viewborder.layer.borderColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1)
            }else if onoff == "off"{
                
            }else{
                
            }

        
            return cell
            
        } else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CallforAppointmentTableViewCell") as! CallforAppointmentTableViewCell
            
            cell.lbl.text = CallArray[indexPath.row]
            
            if cell.lbl.text == "Call for Appointment"{
                cell.lbl.text = CallArray[indexPath.row]
                
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
                if onoff == "on"{
                    cell.lbl.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    cell.lbl.font = UIFont.boldSystemFont(ofSize: 17.0)
                }else if onoff == "off"{
                    cell.lbl.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    cell.lbl.font = UIFont.boldSystemFont(ofSize: 17.0)
                }else{
                    
                }
            }else{
                let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
                print("onoff==>\(onoff ?? "")")
                
                if onoff == "on"{
                    cell.lbl.textColor = AppConstant.LabelColor
                    cell.lbl.font = UIFont.boldSystemFont(ofSize: 15.0)
                }else if onoff == "off"{
                    
                }else{
                    
                }
            }
            

            return cell
 
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CallforAppointmenttwoTableViewCell") as! CallforAppointmenttwoTableViewCell
            cell.clinicname.text = ClinicArray[indexPath.row]
            cell.number.text = NumberArray[indexPath.row]
            
            cell.borderview.layer.cornerRadius = 3
            cell.borderview.layer.borderWidth = 0.6
            cell.borderview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

            
            cell.call.layer.cornerRadius = 10
            cell.call.layer.borderWidth = 1
            cell.call.layer.borderColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
            
            let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
            print("onoff==>\(onoff ?? "")")
            
            if onoff == "on"{
                cell.borderview.backgroundColor = AppConstant.ViewColor
                cell.borderview.layer.borderColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1)
                cell.clinicname.textColor = AppConstant.LabelWhiteColor
                cell.number.textColor = AppConstant.LabelWhiteColor
                cell.call.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }else if onoff == "off"{
                
            }else{
                
            }
            
            return cell

        }

    }

}
