//
//  ServiceConnector.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit
import Alamofire

enum RequestHeader: String {
    case AuthKey = "authorization"
}

class ServiceConnector: NSObject {
    // MARK: Propertises
    fileprivate var connector: HttpConnector!
    fileprivate var requestsList = [String: DataRequest]()
    
    // MARK: Initialize/Deinitialize
    init(isDelegateInMainQueue: Bool = false) {
        connector = HttpConnector(isDelegateInMainQueue: isDelegateInMainQueue)
    }
    
    deinit {
        cancelAllRequests()
    }
    
    // MARK: Requests Cancellation
    func cancelAllRequests() {
        let temp = requestsList
        requestsList = [String: DataRequest]()
        for request in temp.values {
            request.cancel()
        }
    }
    
    func cancel(requestId: String) {
        if let req = requestsList[requestId] {
            requestsList[requestId] = nil
            req.cancel()
        }
    }
    
    func cancel(api: String) {
        let temp = requestsList
        temp.forEach { (key, req) in
            guard api.count <= key.count else { return }
            let startIndex = key.startIndex
            let endIndex = key.index(startIndex, offsetBy: api.count)
            let range = startIndex..<endIndex
            if key.range(of: api, options: .literal, range: range, locale: nil) == nil {
                return
            }
            requestsList[key] = nil
            req.cancel()
        }
    }
    
    // MARK: Basic methods
    @discardableResult func get(_ api: String,
                                params: [String: Any]? = nil,
                                token: String? = nil,
                                completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .get,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.requestsList[requestId] != nil else { return }
                                        weakSelf.requestsList[requestId] = nil
                                        logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                        completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
    
    @discardableResult func put(_ api: String,
                                params: [String: Any]? = nil,
                                token: String? = nil,
                                completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .put,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.requestsList[requestId] != nil else { return }
                                        weakSelf.requestsList[requestId] = nil
                                        logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                        completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
    
    @discardableResult func post(_ api: String,
                                 params: [String: Any]? = nil,
                                 token: String? = nil,
                                 completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .post,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.requestsList[requestId] != nil else { return }
                                        weakSelf.requestsList[requestId] = nil
                                        logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                        completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
    
    @discardableResult func delete(_ api: String,
                                   params: [String: Any]? = nil,
                                   token: String? = nil,
                                   completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .delete,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.requestsList[requestId] != nil else { return }
                                        weakSelf.requestsList[requestId] = nil
                                        logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                        completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
    
    @discardableResult func patch(_ api: String,
                                  params: [String: Any]? = nil,
                                  token: String? = nil,
                                  completion: ((_ result: APIResponse) -> Void)?) -> DataRequest?
    {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .patch,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.requestsList[requestId] != nil else { return }
                                        weakSelf.requestsList[requestId] = nil
                                        logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                        completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
    
    // MARK: Advance methods
    
    @discardableResult func postWithObjectBody(_ api: String,
                                               body: [String: Any],
                                               token: String? = nil,
                                               completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token]
        }
        request = connector.requestWithObjectBody(withApi: URL(string: api),
                                                  method: .post,
                                                  body: body,
                                                  httpHeader: headers,
                                                  completion: { [weak self] (result) in
                                                    guard let weakSelf = self else { return }
                                                    guard weakSelf.requestsList[requestId] != nil else { return }
                                                    weakSelf.requestsList[requestId] = nil
                                                    logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                                    completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
    
    @discardableResult func putWithObjectBody(_ api: String,
                                              body: [String: Any],
                                              token: String? = nil,
                                              completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token]
        }
        request = connector.requestWithObjectBody(withApi: URL(string: api),
                                                  method: .put,
                                                  body: body,
                                                  httpHeader: headers,
                                                  completion: { [weak self] (result) in
                                                    guard let weakSelf = self else { return }
                                                    guard weakSelf.requestsList[requestId] != nil else { return }
                                                    weakSelf.requestsList[requestId] = nil
                                                    logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                                    completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
    
    @discardableResult func putWithArrayObjectBody(_ api: String,
                                                   body: [[String: Any]],
                                                   token: String? = nil,
                                                   completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token]
        }
        request = connector.requestWithArrayObjectBody(withApi: URL(string: api),
                                                       method: .put,
                                                       body: body,
                                                       httpHeader: headers,
                                                       completion: { [weak self] (result) in
                                                        guard let weakSelf = self else { return }
                                                        guard weakSelf.requestsList[requestId] != nil else { return }
                                                        weakSelf.requestsList[requestId] = nil
                                                        logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                                        completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
    
    @discardableResult func postXWwwFormWithObjectBody(_ api: String,
                                                       body: [String: Any],
                                                       token: String? = nil,
                                                       completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token,
                       "Content-Type": "application/x-www-form-urlencoded"]
        } else {
            headers = ["Content-Type": "application/x-www-form-urlencoded"]
        }
        request = connector.requestWithObjectBody(withApi: URL(string: api),
                                                  method: .post,
                                                  body: body,
                                                  httpHeader: headers,
                                                  completion: { [weak self] (result) in
                                                    guard let weakSelf = self else { return }
                                                    guard weakSelf.requestsList[requestId] != nil else { return }
                                                    weakSelf.requestsList[requestId] = nil
                                                    logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                                    completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
    
    @discardableResult func getXWwwFormWithObjectBody(_ api: String,
                                                      body: [String: Any],
                                                      token: String? = nil,
                                                      completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let now = Date().timeIntervalSince1970
        let requestId = "\(api).\(now)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [RequestHeader.AuthKey.rawValue : token,
                       "Content-Type": "application/x-www-form-urlencoded"]
        } else {
            headers = ["Content-Type": "application/x-www-form-urlencoded"]
        }
        request = connector.requestWithObjectBody(withApi: URL(string: api),
                                                  method: .get,
                                                  body: body,
                                                  httpHeader: headers,
                                                  completion: { [weak self] (result) in
                                                    guard let weakSelf = self else { return }
                                                    guard weakSelf.requestsList[requestId] != nil else { return }
                                                    weakSelf.requestsList[requestId] = nil
                                                    logger.debug("API TIME: \(api):\(Date().timeIntervalSince1970 - now)")
                                                    completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
}

