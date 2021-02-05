//
//  UIViewExtension.swift
//  ODOMeter
//
//

import Foundation
import UIKit

extension UIView
{
    func showToast(toastMessage:String,duration:CGFloat)
    {
        //View to blur bg and stopping user interaction
        let bgView = UIView(frame: self.frame)
        bgView.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(0.0))
        bgView.tag = 555
        
        //Label For showing toast text
        let lblMessage = UILabel()
        lblMessage.numberOfLines = 0
        lblMessage.lineBreakMode = .byWordWrapping
        lblMessage.textColor = .white
        lblMessage.backgroundColor = .darkGray
        lblMessage.textAlignment = .center
        lblMessage.font = GetAppFont(FontType: .Regular, FontSize: .Medium)
        lblMessage.text = toastMessage
        
        //calculating toast label frame as per message content
        let maxSizeTitle : CGSize = CGSize(width: self.bounds.size.width-16, height: self.bounds.size.height)
        var expectedSizeTitle : CGSize = lblMessage.sizeThatFits(maxSizeTitle)
        // UILabel can return a size larger than the max size when the number of lines is 1
        expectedSizeTitle = CGSize(width:maxSizeTitle.width.getminimum(value2:expectedSizeTitle.width), height: maxSizeTitle.height.getminimum(value2:expectedSizeTitle.height))
        lblMessage.frame = CGRect(x:((self.bounds.size.width)/2) - ((expectedSizeTitle.width+16)/2) , y: ((self.bounds.size.height - 20) - (expectedSizeTitle.height+22+self.safeAreaInsets.bottom)), width: expectedSizeTitle.width+16, height: expectedSizeTitle.height+16)
        lblMessage.layer.cornerRadius = 8
        lblMessage.layer.masksToBounds = true
        lblMessage.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        bgView.addSubview(lblMessage)
        self.addSubview(bgView)
        lblMessage.alpha = 0
        UIView.animateKeyframes(withDuration:TimeInterval(duration) , delay: 0, options: [] , animations: {
            lblMessage.alpha = 1
        }, completion: {
            sucess in
            UIView.animate(withDuration: TimeInterval(duration), delay: 1, options: [], animations: {
                lblMessage.alpha = 0
                bgView.alpha = 0
            }, completion: { (success) in
                bgView.removeFromSuperview()
            })
        })
    }
}
extension CGFloat
{
    func getminimum(value2:CGFloat)->CGFloat
    {
        if self < value2
        {
            return self
        }
        else
        {
            return value2
        }
    }
}


enum FontSize : CGFloat {
    case ExtraSmall = 10.0
    case Small = 12.0
    case Regular = 14.0
    case Medium = 16.0
    case Large = 18.0
    case ExtraLarge = 20.0
    case belowBig = 22.0
    case Big = 24.0
    case ExtraBig = 26.0
}

enum AppFont : String {
    
    case Regular = "HelveticaNeue"
    case Medium = "HelveticaNeue-Medium"
    case Bold = "HelveticaNeue-Bold"
    case Italic = "HelveticaNeue-Italic"
    case BoldItalic = "HelveticaNeue-BoldItalic"
    case Light = "HelveticaNeue-Light"
}

func GetAppFont(FontType : AppFont,FontSize : FontSize) -> UIFont{
    
    guard let font = UIFont(name: FontType.rawValue, size: FontSize.rawValue) else {
        print("Font with provided font name not found!")
        return UIFont.systemFont(ofSize: FontSize.rawValue)
    }
    return font
}
