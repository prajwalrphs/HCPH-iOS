
import UIKit
import AMTabView
import WebKit

class AboutUsViewController: UIViewController,TabItem,WKNavigationDelegate {
    
    var tabImage: UIImage? {
      return UIImage(named: "apple")
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet var loadrefresh: UIButton!
    
    var strUrl = "https://publichealth.harriscountytx.gov/About/About-Us"
    
    var datastr:String!
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        LoadLink()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        
    }
    
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
        datastr = strUrl
        
        
        LoadLink()
        
    }
    
    @IBAction func RefreshBtn(_ sender: UIButton) {
        LoadLink()
    }
    
    
    func LoadLink(){
        if Reachability.isConnectedToNetwork(){
            //self.loadrefresh.isHidden = true
            self.activityIndicator.isHidden = false
            print("Internet Connection Available!")
            let urlget = datastr ?? ""
            let url = NSURL(string: urlget)
            let request = NSURLRequest(url: url! as URL)
                                   
            webView.navigationDelegate = self
            webView.load(request as URLRequest)
            
        }else{
         
            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigate.selectdtab = 2
            self.navigationController?.pushViewController(navigate, animated: true)
            
            //self.loadrefresh.isHidden = false
            self.activityIndicator.isHidden = true
            let alertController = UIAlertController(title: "Internet Connection", message: "Please turn on your device internet connection to continue.", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            

          
        }
    }
    
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

}
