//
//  PrivacyPolicyViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 01/02/21.
//  Copyright © 2021 Skywave-Mac. All rights reserved.
//

import UIKit
import AMTabView
import WebKit

class PrivacyPolicyViewController: UIViewController,WKNavigationDelegate,TabItem {

    var tabImage: UIImage? {
      return #imageLiteral(resourceName: "secure")
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lbltitle: UILabel!
    
    var strUrl : String! = nil
    var strTitle : String! = nil
    
    var datastr:String!
    var receivedTitle:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datastr = "http://publichealth.harriscountytx.gov/About/Privacy"
        receivedTitle = "Privacy Policy"
        
        lbltitle.text  = receivedTitle

        let urlget = datastr ?? ""
        let url = NSURL(string: urlget)
        let request = NSURLRequest(url: url! as URL)
                               
        webView.navigationDelegate = self
        webView.load(request as URLRequest)
        
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
