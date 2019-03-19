//
//  ListKeywordsAPI.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit
import ObjectMapper

extension CloudAPI {
    func getKeywords(completion: @escaping ([Keyword], Error?) -> Void) {
        let api = "\(host)\(API.keywords.rawValue)"
        connector.get(api, token: self.token) { (response) in
            if let error = response.error {
                logger.error(error.localizedDescription)
                completion([], error)
                return
            }
            
            switch response.code {
            case HTTPCODE.OK:
                let error = NSError(domain: CloudAPIDomain,
                                    code: HTTPCODE.BAD_CONTENT.rawValue,
                                    userInfo: response.data != nil ? ["response": response.data!] : nil)
                
                guard let dict = response.data as? [String: Any] else {
                    logger.error(error.localizedDescription)
                    completion([], error)
                    return
                }
                guard let data = dict["keywords"] as? [Any] else {
                    logger.error(error.localizedDescription)
                    completion([], error)
                    return
                }
                guard let keywords = Mapper<Keyword>().mapArray(JSONObject: data) else {
                    logger.error(error.localizedDescription)
                    completion([], error)
                    return
                }
                completion(keywords, nil)
                
            default:
                let error = NSError(domain: CloudAPIDomain,
                                    code: response.code.rawValue,
                                    userInfo: nil)
                logger.error(error.localizedDescription)
                completion([], error)
            }
        }
    }
    
    func cancelGetKeywords() {
        connector.cancel(api: API.keywords.rawValue)
    }
}
