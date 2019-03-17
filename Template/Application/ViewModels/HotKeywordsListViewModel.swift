//
//  HotKeywordsListViewModel.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit

class HotKeywordsListViewModel: BaseViewModel {
    var keywords = [HotKeywordViewModel]()
    var updateKeywordsAction: ((HotKeywordsListViewModel, Error?) -> Void)? = nil
    
    var count: Int {
        return keywords.count
    }
    
    subscript (indexPath: IndexPath) -> HotKeywordViewModel {
        return keywords[indexPath.row]
    }
    
    override init() {
        super.init()
    }
    
    func loadKeywords() {
        CloudAPI.shared.getKeywords { [weak self] (keywords, error) in
            guard let weakSelf = self else { return }
            if let err = error {
                weakSelf.updateKeywordsAction?(weakSelf, err)
                return
            }
            weakSelf.keywords = keywords.compactMap({ (keyword) -> HotKeywordViewModel in
                return HotKeywordViewModel(keyword: keyword)
            })
            weakSelf.updateKeywordsAction?(weakSelf, nil)
        }
    }
}
