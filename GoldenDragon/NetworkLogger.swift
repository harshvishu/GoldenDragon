//
//  NetworkLogger.swift
//  Hoberman-Client
//
//  Created by harsh vishwakarma on 20/04/19.
//  Copyright © 2019 Harsh Vishwakarma. All rights reserved.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        
        Logger.log(method: .debug, "\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { Logger.log(method: .debug, "\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
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
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        
        Logger.log(method: .debug, logOutput)
    }
    
    static func log(response: URLResponse) {
        Logger.log(method: .debug, "\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
        defer { Logger.log(method: .debug, "\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAsString = response.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        guard let response = response as? HTTPURLResponse else {return}
        
        let statusCode = response.statusCode
        
        var logOutput = """
        \(urlAsString) \n\n
        \(statusCode) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        
        for (key, value) in response.allHeaderFields {
            logOutput += "\(key): \(value) \n"
        }
        
        Logger.log(method: .debug, logOutput)
    }
}
