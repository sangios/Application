//
//  Keyword.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit
import ObjectMapper

class Keyword: BaseModel, Mappable {
    fileprivate let keywordKey = "keyword"
    fileprivate let iconKey = "icon"
    
    var text: String = ""
    var icon: String? = nil
    
    init(text: String, icon: String? = nil) {
        self.text = text
        self.icon = icon
    }
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        text <- map[keywordKey]
        icon <- map[iconKey]
    }    
}
