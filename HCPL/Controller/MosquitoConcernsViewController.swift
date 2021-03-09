
import UIKit

class MosquitoConcernsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    var arrofname = ["   Dead Birds","   Mosquito Breeding","   Disease Activity","   Apray Area","   Visit Our Website","   Report Issues"]
    
    var imagearray = [#imageLiteral(resourceName: "mosq1"),#imageLiteral(resourceName: "mosq2"),#imageLiteral(resourceName: "mosq3"),#imageLiteral(resourceName: "mosq4"),#imageLiteral(resourceName: "pic6"),#imageLiteral(resourceName: "pic7")]

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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MosquitoConcernsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MosquitoConcernsTableViewCell", for: indexPath) as! MosquitoConcernsTableViewCell
        
        cell.img.image = imagearray[indexPath.row]
        cell.lbl.text = arrofname[indexPath.row]
        
        cell.mainview.layer.cornerRadius = 20
        cell.mainview.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let navigate:DeadbirdViewController = self.storyboard?.instantiateViewController(identifier: "DeadbirdViewController") as! DeadbirdViewController
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 1{
            let navigate:MosquitoBreedingViewController = self.storyboard?.instantiateViewController(identifier: "MosquitoBreedingViewController") as! MosquitoBreedingViewController
            self.navigationController?.pushViewController(navigate, animated: true)
        }
        if indexPath.row == 2{
            let naviagte:MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            naviagte.TitleHead = "Disease Activity"
            self.navigationController?.pushViewController(naviagte, animated: true)
        }
        if indexPath.row == 3{
            let naviagte:MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            naviagte.TitleHead = "Spray Area"
            self.navigationController?.pushViewController(naviagte, animated: true)
        }
        if indexPath.row == 4{
            self.naviGetTo(url: "http://publichealth.harriscountytx.gov/About/Organization-Offices/Mosquito-and-Vector-Control", title: "Website")
        }
        if indexPath.row == 5{
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
            alert.view.backgroundColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)  // change background color
            alert.view.layer.cornerRadius = 25
            
            alert.addAction(action1)
            alert.addAction(action2)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }

    func naviGetTo(url:String, title:String){
        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
        
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
        
    }
}
