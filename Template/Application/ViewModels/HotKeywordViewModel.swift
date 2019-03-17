//
//  HotKeywordViewModel.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit

class HotKeywordViewModel: BaseViewModel {
    private var keyword: Keyword
    var text: String
    var calculatedSize: CGSize? // To improve performace when scroll cell
    
    var iconURL: URL? {
        guard let link = keyword.icon else { return nil }
        guard let url = URL.init(string: link) else { return nil }
        return url
    }
    
    init(keyword: Keyword) {
        self.keyword = keyword;
        var text = keyword.text
        
        let idxStart = text.startIndex
        let idxEnd = text.endIndex
        let idxMiddle = text.index(idxStart, offsetBy: text.count/2)
        var firstHalf = idxStart..<idxMiddle
        var lastHalf = idxMiddle..<idxEnd
        
        var foundSpaceInFirstHalf = false
        var foundSpaceInLastHalf = false
        
        // Find last space from 0 to text's length/2
        if let range = text.range(of: " ", options: .backwards, range: firstHalf, locale: nil) {
            firstHalf = range
            foundSpaceInFirstHalf = true
        }
        // Find first space from text's length/2 to end of text
        if let range = text.range(of: " ", options: .literal, range: lastHalf, locale: nil) {
            lastHalf = range
            foundSpaceInLastHalf = true
        }
        
        let firstHalfLine1 = text[..<firstHalf.lowerBound]
        let firstHalfLine2 = text[firstHalf.upperBound...]
        
        let lastHalfLine1 = text[..<lastHalf.lowerBound]
        let lastHalfLine2 = text[lastHalf.upperBound...]
        
        if foundSpaceInFirstHalf && foundSpaceInLastHalf {
            if text.count/2 - firstHalfLine1.count <= text.count/2 - lastHalfLine2.count {
                text = "\(firstHalfLine1)\n\(firstHalfLine2)"
            } else {
                text = "\(lastHalfLine1)\n\(lastHalfLine2)"
            }
        } else if foundSpaceInFirstHalf {
            text = "\(firstHalfLine1)\n\(firstHalfLine2)"
        } else if foundSpaceInLastHalf {
            text = "\(lastHalfLine1)\n\(lastHalfLine2)"
        }
        self.text = text
        
        logger.debug(
            "\n--------------------------------" +
            "\n" + keyword.text +
            "\n" + String(firstHalfLine1) +
            "\n" + String(firstHalfLine2) +
            "\n" + String(lastHalfLine1) +
            "\n" + String(lastHalfLine2) +
            "\n" + text +
            "\n--------------------------------"
        )
    }
}
