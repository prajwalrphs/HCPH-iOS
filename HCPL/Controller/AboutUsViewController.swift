//
//  AboutUsViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 26/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

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
