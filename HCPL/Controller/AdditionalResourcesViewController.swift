
import UIKit

class AdditionalResourcesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var Listofarray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Listofarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AdditionalResourcesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalResourcesTableViewCell", for: indexPath) as! AdditionalResourcesTableViewCell
        
        
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
        
        if Reachability.isConnectedToNetwork(){
            if self.Listofarray == ["Texas Quitline","Become an Ex"]{
                if indexPath.row == 0{
                    naviGetTo(url: "https://www.quitnow.net/mve/quitnow?qnclient=texas", title: "Texas Quitline")
                }
                
                if indexPath.row == 1{
                    naviGetTo(url: "https://www.becomeanex.org/", title: "Become an Ex")
                }
            }else{
                if indexPath.row == 0{
                    naviGetTo(url: "https://aspire2.mdanderson.org/", title: "MDAnderson Program")
                }
                
                if indexPath.row == 1{
                    naviGetTo(url: "https://myquitforlife.com/mve/?client=LVFTX&clientId=11501506", title: "Live Vaps")
                    
                }
            }
        }else{
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
    }

    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
    
}
