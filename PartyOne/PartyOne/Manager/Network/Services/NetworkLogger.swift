//
//  NetworkLogger.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public class NetworkLogger {
    
    private static let TAG = "NetLogr"
    
    public static let LOG_ENABLED = false
    
    static func log(request: URLRequest) {
        
        NetworkLogger.printNL("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { NetworkLogger.printNL("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        NetworkLogger.printNL(logOutput)
    }
    
    static func log(response: URLResponse) {}
    
    static func printNL(_ value: String) {
        if NetworkLogger.LOG_ENABLED {
            Logger.d(NetworkLogger.TAG, value)
        }
    }
    
}
