
import UIKit
import AMTabView
import WebKit

class AboutUsViewController: UIViewController,TabItem,WKNavigationDelegate {
    
    var tabImage: UIImage? {
      return UIImage(named: "apple")
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var webView: WKWebView!
    
    var strUrl = "https://publichealth.harriscountytx.gov/About/About-Us"
    
    var datastr:String!
    
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
        
        let urlget = datastr ?? ""
        let url = NSURL(string: urlget)
        let request = NSURLRequest(url: url! as URL)
                               
        webView.navigationDelegate = self
        webView.load(request as URLRequest)
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
