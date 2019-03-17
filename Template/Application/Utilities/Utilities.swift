//
//  Utilities.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    static func calculateSize(text: String, height: CGFloat, font: UIFont = UIFont.systemFont(ofSize: 14.0)) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let string = NSString(string: text)
        let tempSize = CGSize(width: CGFloat(Float.greatestFiniteMagnitude), height: height)
        let rect = string.boundingRect(with: tempSize,
                                       options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                       attributes: attributes,
                                       context: nil);
        
        return rect.size
    }
    
    static func calculateSize(text: String, width: CGFloat, font: UIFont = UIFont.systemFont(ofSize: 14.0)) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let string = NSString(string: text)
        let tempSize = CGSize(width: width, height: CGFloat(Float.greatestFiniteMagnitude))
        let rect = string.boundingRect(with: tempSize,
                                       options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                       attributes: attributes,
                                       context: nil);
        
        return rect.size
    }
}
