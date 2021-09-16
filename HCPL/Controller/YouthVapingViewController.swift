import UIKit

class YouthVapingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var Listofarray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Listofarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YouthVapingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "YouthVapingTableViewCell", for: indexPath) as! YouthVapingTableViewCell
        
        cell.lbl.text = Listofarray[indexPath.row]
        cell.viewlayout.layer.cornerRadius = 7
        cell.viewlayout.layer.borderWidth = 0.6
        cell.viewlayout.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if onoff == "on"{

            cell.viewlayout.backgroundColor = AppConstant.ViewColor
            cell.lbl.textColor = AppConstant.NormalTextColor
            cell.ArrowRight.tintColor = AppConstant.LabelColor
            cell.viewlayout.layer.borderColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1)
            
        }else if onoff == "off"{
            
        }else{
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            
            let navigate:SignupnowViewController = self.storyboard?.instantiateViewController(identifier: "SignupnowViewController") as! SignupnowViewController
            
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        
        if indexPath.row == 1{

            let navigate:AdditionalResourcesViewController = self.storyboard?.instantiateViewController(identifier: "AdditionalResourcesViewController") as! AdditionalResourcesViewController
            
            navigate.Listofarray = ["MDAnderson ASPIRE Program","Live Vaps"]
            
            self.navigationController?.pushViewController(navigate, animated: true)
            
        }
    
    }
    
}
