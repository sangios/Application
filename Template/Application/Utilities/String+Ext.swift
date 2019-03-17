//
//  String+Ext.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//


import Foundation

extension String {
    func substringToIndex(index: Int) -> String {
        let index: String.Index = self.index(self.startIndex, offsetBy: index)
        return String(self[..<index])
    }
    
    func substringFromIndex(index: Int) -> String {
        let index: String.Index = self.index(self.startIndex, offsetBy: index)
        return String(self[index...])
    }
    
    func substringsMatched(pattern: String) -> [String] {
        var subStrs: [String] = []
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            subStrs = results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("No substring matchs regex: \(error.localizedDescription)")
        }
        return subStrs
    }
    
    func trimSpace() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    var isNumber: Bool {
        let characters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
    }
}
