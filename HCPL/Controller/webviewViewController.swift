
import UIKit
import WebKit

class webviewViewController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet var bottomview: UIView!
    
    var strUrl : String! = nil
    var strTitle : String! = nil
    
    var datastr:String!
    var receivedTitle:String!
    
    var CheckCondition:String!
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        LoadLink()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomview.isHidden = true
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        if CheckCondition == "ScoreHistory"{
            bottomview.isHidden = false
        }else if CheckCondition == "ViewReport"{
            bottomview.isHidden = false
        }
        
        if onoff == "on"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .dark
             }
            webView.isOpaque = false
            webView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else if onoff == "off"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }else{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }
        
        LoadLink()
        
    }
    
    @IBAction func leftarrow(_ sender: UIButton) {
        
    }
    
    @IBAction func rightarrow(_ sender: UIButton) {
        
    }
    
    @IBAction func cross(_ sender: UIButton) {
        webView.stopLoading()
        self.view.showToast(toastMessage: "Stop Loading Page", duration: 0.5)
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        self.view.showToast(toastMessage: "Refreshing Page", duration: 0.5)
        LoadLink()
    }
    
    @IBAction func share(_ sender: UIButton) {
        guard let url = URL(string: strUrl) else { return }
        UIApplication.shared.open(url)
    }
    
    
    func LoadLink(){
        if Reachability.isConnectedToNetwork(){
            //self.loadrefresh.isHidden = true
            self.activityIndicator.isHidden = false

            datastr = strUrl
            receivedTitle = strTitle
            
            lbltitle.text  = receivedTitle

            let urlget = datastr ?? ""
            let url = NSURL(string: urlget)
            let request = NSURLRequest(url: url! as URL)
                                   
            webView.navigationDelegate = self
            webView.load(request as URLRequest)
            
        }else{
         
            //self.loadrefresh.isHidden = false
            self.activityIndicator.isHidden = true
            let alertController = UIAlertController(title: "Internet Connection", message: "Please turn on your device internet connection to continue.", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
          
        }
    }
    
    @IBAction func Backbuttonaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
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
