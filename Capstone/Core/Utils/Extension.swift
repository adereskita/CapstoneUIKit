//
//  Extension.swift
//  Capstone
//
//  Created by Ade Reskita on 18/12/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension UIView {
    
    static func nibName() -> String {
        let nameSpaceClassName = NSStringFromClass(self)
        let className = nameSpaceClassName.components(separatedBy: ".").last! as String
        return className
    }

    static func nib() -> UINib {
        return UINib(nibName: self.nibName(), bundle: nil)
    }
    
    func cardStyle() {
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.4
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func blurredBackground() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.bounds
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.addSubview(blurredEffectView)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
         return Data(utf8).htmlToAttributedString
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func search(_ term: String) -> Bool {
        let lowercasedSelf = self.lowercased()
        let lowercasedTerm = term.lowercased()
        return lowercasedSelf.localizedCaseInsensitiveContains(lowercasedTerm)
    }
}

extension Data {
    var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { htmlToAttributedString?.string ?? "" }
}

extension UITableViewCell {
    public class var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    
    public class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public class var identifier: String {
        return String(describing: self)
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
