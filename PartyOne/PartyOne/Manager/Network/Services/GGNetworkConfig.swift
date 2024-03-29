//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class PONetworkConfig<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            if let request = try self.buildRequest(from: route) {
                NetworkLogger.log(request: request)
                task = session.dataTask(with: request, completionHandler: { data, response, error in
                    completion(data, response, error)
                })
            } else {
                completion(nil, nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Not able to create request object"]))
            }
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest? {
        guard let baseUrl = route.baseURL else {
                return nil
        }
        
        var request : URLRequest
       
        if route.path.isEmpty{
            request = URLRequest(url: baseUrl,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        }else{
         request = URLRequest(url: baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        }
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .requestDefault:
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                request.setValue(RequestConstants.CONTENT_VALUE, forHTTPHeaderField: RequestConstants.ACCEPT)
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            // TODO REfactor this to add header parameter and whatever is required
            case .requestBodyAndHeaders(let data, let encodingMethod, let additionaHeaders):
                
                self.addAdditionalHeaders(additionaHeaders, request: &request)
                self.addBody(data, request: &request)
                if encodingMethod == .jsonEncoding {
                    self.bodyJsonEncoding(request: &request)
                }
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    fileprivate func bodyJsonEncoding(request: inout URLRequest) {
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
    
    fileprivate func addBody(_ jsonBody: Data?, request: inout URLRequest) {
        guard let body = jsonBody else {
            return
        }
        request.httpBody = body
        return
    }
    
}

