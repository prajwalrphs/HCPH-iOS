//
//  Appconstant.swift
//  HCPL
//
//  Created by Skywave-Mac on 24/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import Foundation
import UIKit

public class AppConstant {
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

//    func naviGetTo(url:String, title:String){
//        let navigate:webviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewViewController") as! webviewViewController
//
//        navigate.strUrl = url
//        navigate.strTitle = title
//
//        self.navigationController?.pushViewController(navigate, animated: true)
//
//    }
    
}
