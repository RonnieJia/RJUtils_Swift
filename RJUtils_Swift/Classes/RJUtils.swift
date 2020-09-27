//
//  RJUtils.swift

import Foundation
import UIKit
import NVActivityIndicatorView
import MBProgressHUD



public let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
public let kNavigatioBarHeight = kStatusBarHeight+44.0
public let kTabbarHeight = UITabBar.appearance().frame.height
public let kScreenWidth = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height
public let isIphoneX = kStatusBarHeight > 20
public let kSafeBottonHeight = isIphoneX ? 34 : 0

public let RJNotificationCenter = NotificationCenter.default


public func RJFont(size: CGFloat = 14.0) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

public func RJMediumFont(size: CGFloat = 14.0) -> UIFont {
    guard let font = UIFont(name: "PingFangSC-Medium", size: size) else {
        return RJFont(size: size)
    }
    return font
}

public func RJHexColor(hex color: String) -> UIColor {
    var nStr = color.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    guard nStr.count >= 6 else {
        return UIColor.clear
    }
    if nStr.hasPrefix("0X") {
        nStr = String(nStr[nStr.index(nStr.startIndex, offsetBy: 2) ..< nStr.endIndex])
    }
    if nStr.hasPrefix("#") {
        nStr = String(nStr[nStr.index(nStr.startIndex, offsetBy: 1) ..< nStr.endIndex])
    }
    guard nStr.count == 6 else {
        return UIColor.clear
    }
    
    var startIndex = nStr.startIndex
    let redStr = String(nStr[startIndex ..< nStr.index(startIndex, offsetBy: 2)])
    
    startIndex = nStr.index(startIndex, offsetBy: 2)
    let greenStr = String(nStr[startIndex ..< nStr.index(startIndex, offsetBy: 2)])
    
    startIndex = nStr.index(startIndex, offsetBy: 2)
    let blueStr = String(nStr[startIndex ..< nStr.index(startIndex, offsetBy: 2)])
    
    let redPointer = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
    Scanner(string: redStr).scanHexInt32(redPointer)
    
    let greenPointer = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
    Scanner(string: greenStr).scanHexInt32(greenPointer)
    
    let bluePointer = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
    Scanner(string: blueStr).scanHexInt32(bluePointer)
    
    return RJRGBAColor(
        red: CGFloat(redPointer.pointee),
        green: CGFloat(greenPointer.pointee),
        blue: CGFloat(bluePointer.pointee),
        alpha: 1.0
    )
}

public func RJRGBAColor(red r: CGFloat, green g: CGFloat, blue b: CGFloat, alpha a: CFloat) -> UIColor {
    var rValue = r > 255.0 ? 255.0 : r
    rValue = r < 0 ? 0 : rValue
    
    var gValue = g > 255.0 ? 255.0 : g
    gValue = g < 0 ? 0 : gValue
    
    var bValue = b > 255.0 ? 255.0 : b
    bValue = b < 0 ? 0 : bValue
    
    var aValue = CGFloat(a > 1.0 ? 1.0 : a)
    aValue = a < 0 ? 0 : aValue
    
    return UIColor(red: rValue / 255.0, green: gValue / 255.0, blue: bValue / 255.0, alpha: aValue)
}

public func RJRGBColor(red r: CGFloat, green g: CGFloat, blue b: CGFloat) -> UIColor {
    return RJRGBAColor(red: r, green: g, blue: b, alpha: 1.0)
}

public extension UIViewController {
    func RJ_showMessage(message: String) {
        self.view.RJ_showMessage(message: message)
    }
    
    func RJ_showProgressHUD(type:NVActivityIndicatorType? = NVActivityIndicatorView.DEFAULT_TYPE, message: String? = nil) {
        self.view.RJ_showProgressHUD(type: type, message: message)
    }
    
    func RJ_hideProgressHUD(message: String? = nil)  {
        self.view.RJ_hideProgressHUD(message: message)
    }
}

public extension UIView {
    func RJ_showMessage(message msg: String, textColor: UIColor? = .white, backgroundColor: UIColor? = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)) {
        let messageHud = MBProgressHUD.showAdded(to: self, animated: true)
        messageHud.mode = .text
        messageHud.label.text = msg
        messageHud.label.textColor = textColor
        messageHud.bezelView.backgroundColor = backgroundColor
        messageHud.hide(animated: true, afterDelay: 0.8)
    }
    
    func  RJ_showProgressHUD(type:NVActivityIndicatorType? = NVActivityIndicatorView.DEFAULT_TYPE, message: String? = nil) {
        let activityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: type)
        activityIndicatorView.startAnimating()
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.bezelView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
        hud.mode = .customView
        hud.customView = activityIndicatorView
        hud.label.text = message
        hud.label.textColor = .white
    }
    
    func RJ_hideProgressHUD(message msg: String? = nil) {
        guard let hud = MBProgressHUD.forView(self) else { return }
        if let activiyView: NVActivityIndicatorView = hud.customView as? NVActivityIndicatorView {
            activiyView.stopAnimating()
        }
        if let message = msg {
            hud.mode = .text
            hud.label.text = message
            hud.label.textColor = .white
            hud.hide(animated: true, afterDelay: 0.8)
        } else {
            hud.hide(animated: true)
        }
    }
}

/// UIView  frame
public extension UIView {
    var x: CGFloat {
        return self.frame.minX
    }
    
    func x(_ x: CGFloat) {
        var rect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    var y: CGFloat {
        return self.frame.minY
    }
    
    func y(_ y: CGFloat) {
        var rect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    var right: CGFloat {
        return self.frame.maxX
    }
    
    func right(_ r: CGFloat) {
        var rect = self.frame
        rect.origin.x = r - rect.size.width
        self.frame = rect
    }
    
    var bottom: CGFloat {
        return self.frame.maxY
    }
    
    func bottom(_ b: CGFloat) {
        var rect = self.frame
        rect.origin.y = b - rect.size.height
        self.frame = rect
    }
    
    var width: CGFloat {
        return self.frame.width
    }
    
    func width(_ w: CGFloat) {
        var rect = self.frame
        rect.size.width = w
        self.frame = rect
    }
    
    var height: CGFloat {
        return self.frame.height
    }
    
    func height(_ h: CGFloat) {
        var rect = self.frame
        rect.size.height = h
        self.frame = rect
    }
    
    var centerX: CGFloat {
        return self.center.x
    }
    
    func centerX(_ centerX: CGFloat) {
        var cen = self.center
        cen.x = centerX
        self.center = cen
    }
    
    var centerY: CGFloat {
        return self.center.y
    }
    
    func centerY(_ centerY: CGFloat) {
        var cen = self.center
        cen.y = centerY
        self.center = cen
    }
    
    var size: CGSize {
        return self.frame.size
    }
    
    func size(_ size:CGSize) -> Void {
        var frame = self.frame
        frame.size = size
        self.frame = frame;
    }
}
