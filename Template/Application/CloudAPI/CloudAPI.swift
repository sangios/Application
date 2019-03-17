//
//  CloudAPI.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit
import ObjectMapper

let CloudAPIDomain = "CloudAPIDomain"

enum Host: String {
    case production = "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com"
}

enum API: String {
    case keywords = "/ios/keywords.json"
}

class CloudAPI {
    var host: String
    var token: String = ""
    var connector: ServiceConnector!
    
    static var defaultHost = Host.production.rawValue
    static var isDelegateInMainQueue: Bool = true
    static let shared = CloudAPI()
    
    // MARK:- Init/Deinit
   
    init(host: String = CloudAPI.defaultHost, token: String = "", isDelegateInMainQueue: Bool = true) {
        self.host = host
        self.token = token
        connector = ServiceConnector(isDelegateInMainQueue: isDelegateInMainQueue)
    }
    
    deinit {

    }
}
