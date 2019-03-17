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
    fileprivate var cancelled = false
    
    // MARK: Initialize/Deinitialize
    init(isDelegateInMainQueue: Bool = false) {
        connector = HttpConnector(isDelegateInMainQueue: isDelegateInMainQueue)
    }
    
    deinit {
        cancelAllRequests()
    }
    
    // MARK: Requests Cancellation
    func cancelAllRequests() {
        cancelled = true
        for request in requestsList.values {
            request.cancel()
        }
    }
    
    // MARK: Basic methods
    @discardableResult func get(_ api: String,
                                params: [String: Any]? = nil,
                                token: String? = nil,
                                completion: ((_ result: APIResponse) -> Void)?) -> DataRequest? {
        var request: DataRequest? = nil
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token ]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .get,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.cancelled == false else { return }
                                        
                                        weakSelf.requestsList[requestId] = nil
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
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token ]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .put,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.cancelled == false else { return }
                                        
                                        weakSelf.requestsList[requestId] = nil
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
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token ]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .post,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.cancelled == false else { return }
                                        
                                        weakSelf.requestsList[requestId] = nil
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
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token ]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .delete,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.cancelled == false else { return }
                                        
                                        weakSelf.requestsList[requestId] = nil
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
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token ]
        }
        request = connector.request(withApi: URL(string: api),
                                    method: .patch,
                                    params: params,
                                    header: headers,
                                    completion: { [weak self] (result) in
                                        guard let weakSelf = self else { return }
                                        guard weakSelf.cancelled == false else { return }
                                        
                                        weakSelf.requestsList[requestId] = nil
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
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token ]
        }
        request = connector.requestWithObjectBody(withApi: URL(string: api),
                                                  method: .post,
                                                  body: body,
                                                  httpHeader: headers,
                                                  completion: { [weak self] (result) in
                                                    guard let weakSelf = self else { return }
                                                    guard weakSelf.cancelled == false else { return }
                                                    
                                                    weakSelf.requestsList[requestId] = nil
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
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token ]
        }
        request = connector.requestWithObjectBody(withApi: URL(string: api),
                                                  method: .put,
                                                  body: body,
                                                  httpHeader: headers,
                                                  completion: { [weak self] (result) in
                                                    guard let weakSelf = self else { return }
                                                    guard weakSelf.cancelled == false else { return }
                                                    
                                                    weakSelf.requestsList[requestId] = nil
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
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token ]
        }
        request = connector.requestWithArrayObjectBody(withApi: URL(string: api),
                                                       method: .put,
                                                       body: body,
                                                       httpHeader: headers,
                                                       completion: { [weak self] (result) in
                                                        guard let weakSelf = self else { return }
                                                        guard weakSelf.cancelled == false else { return }
                                                        
                                                        weakSelf.requestsList[requestId] = nil
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
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token, "Content-Type": "application/x-www-form-urlencoded"]
        } else {
            headers = [ "Content-Type": "application/x-www-form-urlencoded"]
        }
        request = connector.requestWithObjectBody(withApi: URL(string: api),
                                                  method: .post,
                                                  body: body,
                                                  httpHeader: headers,
                                                  completion: { [weak self] (result) in
                                                    guard let weakSelf = self else { return }
                                                    guard weakSelf.cancelled == false else { return }
                                                    
                                                    weakSelf.requestsList[requestId] = nil
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
        let requestId = "\(api).\(Date().timeIntervalSince1970)"
        var headers: HTTPHeaders = HTTPHeaders()
        if let token = token, token.count > 0 {
            headers = [ RequestHeader.AuthKey.rawValue : token, "Content-Type": "application/x-www-form-urlencoded"]
        } else {
            headers = [ "Content-Type": "application/x-www-form-urlencoded"]
        }
        request = connector.requestWithObjectBody(withApi: URL(string: api),
                                                  method: .get,
                                                  body: body,
                                                  httpHeader: headers,
                                                  completion: { [weak self] (result) in
                                                    guard let weakSelf = self else { return }
                                                    guard weakSelf.cancelled == false else { return }
                                                    
                                                    weakSelf.requestsList[requestId] = nil
                                                    completion?(result)
        })
        if request != nil {
            requestsList[requestId] = request!
        }
        return request
    }
}
