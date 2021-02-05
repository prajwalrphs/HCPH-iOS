//
//  ViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 24/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import AMTabView

class ViewController: AMTabsViewController {

    var SelectIndex = 2
    var selectdtab = 2
 
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setTabsControllers()
        
        SelectIndex = selectdtab
        
        selectedTabIndex = SelectIndex
        
        AMTabView.settings.ballColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)
        AMTabView.settings.tabColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.5)
        AMTabView.settings.selectedTabTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        AMTabView.settings.unSelectedTabTintColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)

        // Chnage the animation duration
        AMTabView.settings.animationDuration = 1
    }
    
    private func setTabsControllers() {
      let ContectStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContectViewController")
      let AboutUsStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutUsViewController")
      let HomeStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
      let ProfileStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrivacyPolicyViewController")
      let ReportStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReportIssueViewController")
      

         
      viewControllers = [ContectStoryboard, AboutUsStoryboard,HomeStoryboard,ProfileStoryboard,ReportStoryboard]
    }
    
    override func tabDidSelectAt(index: Int) {
      super.tabDidSelectAt(index: index)
        print("index==>\(index)")
      
    }
    
}

