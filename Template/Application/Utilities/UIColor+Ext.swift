//
//  UIColor+Ext.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func colorWithHexString(hex:String, alpha: CGFloat = 1.0) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespaces).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(index: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = cString.substringToIndex(index: 2)
        let gString = cString.substringFromIndex(index: 2).substringToIndex(index: 2)
        let bString = cString.substringFromIndex(index: 4).substringToIndex(index: 2)
        
        var r: Int = 0, g: Int = 0, b: Int = 0
        Scanner.init(string: rString).scanInt(&r)
        Scanner.init(string: gString).scanInt(&g)
        Scanner.init(string: bString).scanInt(&b)
        
        return UIColor(red: CGFloat(r)/255.0,
                       green:CGFloat(g)/255.0,
                       blue:CGFloat(b)/255.0,
                       alpha: alpha)
    }
}
