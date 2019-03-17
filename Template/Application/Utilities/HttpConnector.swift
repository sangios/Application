//
//  HttpConnector.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

let HttpConnectorDomain = "HttpConnector"

enum HTTPCODE: Int {
    case OK = 200
    case CONFLICT = 409
    case NOT_FOUND = 404
    case NO_CONTENT = 204
    case BAD_GATEWAY = 502
    case BAD_REQUEST = 400
    case UNAUTHORIZED = 401
    case GATEWAY_TIMEOUT = 504
    case BAD_PARAMS = 1400
    case BAD_CONTENT = 1204
    case UNKNOWN = 1404
}

struct APIResponse {
    var api: String = ""
    var method: String = ""
    var code: HTTPCODE
    var data: Any?
    var error: Error?
    
    init (code: Int, data: Any?, error: Error?) {
        self.code = HTTPCODE(rawValue: code) ?? HTTPCODE.UNKNOWN
        self.data = data
        self.error = error
    }
    
    init (error: Error) {
        self.code = HTTPCODE(rawValue: (error as NSError).code) ?? HTTPCODE.UNKNOWN
        self.data = nil
        self.error = error
    }
    
    var hasError: Bool {
        return (self.error != nil)
    }
    
    func getErrorIfNeed() -> NSError {
        let error = NSError(domain: HttpConnectorDomain,
                            code: code.rawValue,
                            userInfo: nil)
        return error
    }
}

class HttpConnector {
    // MARK: Propertises
    var timeout = 30.0
    
    // Setup HTTP client configure
    let manager: SessionManager!
    let delegateQueue: OperationQueue!
    let isDelegateInMainQueue: Bool
    
    // MARK: Initialize
    convenience init() {
        self.init(isDelegateInMainQueue: false)
    }
    
    init(isDelegateInMainQueue: Bool = false) {
        self.isDelegateInMainQueue = isDelegateInMainQueue
        delegateQueue = isDelegateInMainQueue ? OperationQueue.main : OperationQueue.init()
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = timeout
        let delegate = SessionDelegate()
        let session = URLSession(configuration: configuration,
                                 delegate: delegate,
                                 delegateQueue: delegateQueue)
        
        manager = SessionManager.init(session: session, delegate: delegate)
    }
    
    deinit {
        
    }
    
    // MARK: Helper Methods
    
    func getParamsError() -> APIResponse {
        let error = NSError(domain: HttpConnectorDomain,
                            code: HTTPCODE.BAD_PARAMS.rawValue,
                            userInfo: nil)
        return APIResponse(error: error)
    }
    
    func getCode(_ response: DataResponse<Any>) -> Int {
        return response.response?.statusCode ?? HTTPCODE.UNKNOWN.rawValue
    }
    
    func handleResponse(response: DataResponse<Any>, completion: ((_ result: APIResponse) -> Void)?){
        var apiResponse = APIResponse(code: self.getCode(response),
                                      data: response.result.value,
                                      error: response.result.error)
        apiResponse.method = response.request?.httpMethod ?? ""
        apiResponse.api = response.request?.url?.absoluteString ?? ""
        
        completion?(apiResponse)
    }
    
    func requestWithObjectBody(withApi api: URL?,
                               method: HTTPMethod,
                               body: [String: Any],
                               completion: ((_ result: APIResponse) -> Void)?) -> DataRequest?
    {
        guard let api = api else {
            completion?(getParamsError())
            return nil
        }
        
        guard var urlRequest = try? URLRequest(url: api).asURLRequest(), let data = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            completion?(getParamsError())
            return nil
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        urlRequest.httpBody = data
        
        return manager.request(urlRequest).responseJSON(completionHandler:
            { [weak self] (response) in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.handleResponse(response: response, completion: completion)
        })
    }
    
    func requestWithArrayObjectBody(withApi api: URL?,
                                    method: HTTPMethod,
                                    body: [[String: Any]],
                                    completion: ((_ result: APIResponse) -> Void)?)  -> DataRequest?
    {
        guard let api = api else {
            completion?(getParamsError())
            return nil
        }
        
        guard var urlRequest = try? URLRequest(url: api).asURLRequest(), let data = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            completion?(getParamsError())
            return nil
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        urlRequest.httpBody = data
        urlRequest.httpMethod = method.rawValue
        
        return manager.request(urlRequest).responseJSON(completionHandler:
            { [weak self] (response) in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.handleResponse(response: response, completion: completion)
        })
    }
    
    func request(withApi api: URL?,
                 method: HTTPMethod,
                 params: [String: Any]? = nil,
                 header: [String: String]? = nil,
                 completion: ((_ result: APIResponse) -> Void)?) -> DataRequest?
    {
        guard let api = api else {
            completion?(getParamsError())
            return nil
        }
        
        var encoding: ParameterEncoding = URLEncoding.queryString
        if method == .post || method == .patch || method == .put {
            encoding = JSONEncoding.default
        }
        
        return manager.request(api,
                               method: method,
                               parameters: params,
                               encoding: encoding,
                               headers: header).responseJSON
            { [weak self] (response) in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.handleResponse(response: response, completion: completion)
        }
    }
    
    static func getXWwwFormUrlencodedHeaders() -> [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    func requestWithObjectBody(withApi api: URL?,
                               method: HTTPMethod,
                               body: [String: Any],
                               httpHeader: [String: String],
                               completion: ((_ result: APIResponse) -> Void)?) -> DataRequest?
    {
        guard let api = api else {
            completion?(getParamsError())
            return nil
        }
        
        return manager.request(api,
                               method: .post,
                               parameters: body,
                               encoding: URLEncoding.httpBody,
                               headers: httpHeader).responseJSON(completionHandler: { [weak self] (response) in
                                guard let weakSelf = self else { return }
                                weakSelf.handleResponse(response: response, completion: completion)
                               })
    }
    
    
    func requestWithArrayObjectBody(withApi api: URL?,
                                    method: HTTPMethod,
                                    body: [[String: Any]],
                                    httpHeader: [String: String],
                                    completion: ((_ result: APIResponse) -> Void)?)  -> DataRequest?
    {
        guard let api = api else {
            completion?(getParamsError())
            return nil
        }
        
        guard var urlRequest = try? URLRequest(url: api).asURLRequest(), let data = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            completion?(getParamsError())
            return nil
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let headerKey = httpHeader.keys.first, urlRequest.value(forHTTPHeaderField: headerKey) == nil, let headerValue = httpHeader[headerKey] {
            urlRequest.setValue(headerValue, forHTTPHeaderField: headerKey)
        }
        urlRequest.httpBody = data
        urlRequest.httpMethod = method.rawValue
        
        return manager.request(urlRequest).responseJSON(completionHandler: { [weak self] (response) in
            guard let weakSelf = self else { return }
            weakSelf.handleResponse(response: response, completion: completion)
        })
    }
}

