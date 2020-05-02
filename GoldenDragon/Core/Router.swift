//
//  SCRouter.swift
//  Hoberman-Client
//
//  Created by harsh vishwakarma on 20/04/19.
//  Copyright © 2019 Harsh Vishwakarma. All rights reserved.
//

import Foundation

public protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request<T: Codable>(_ route: EndPoint, completionHandler: @escaping (T?, Data?, URLResponse?, Error?) -> Void) -> Int?
    func request<T: Codable>(_ route: EndPoint, completionHandler: @escaping (Result<T,Error>) -> Void) -> Int?
    func request<T: Codable>(_ route: EndPoint) -> Future<T>
    func cancel(taskIdentifier: Int)
}

public class Router<EndPoint: EndPointType>: NetworkRouter {
    private var tasks: [Int: URLSessionTask?] = [:]
    
    @discardableResult
    public func request<T: Codable>(_ route: EndPoint, completionHandler: @escaping (T?, Data?, URLResponse?, Error?) -> Void) -> Int? {
        let session = URLSession.shared
        var taskIdentifier: Int?
        do {
            let request = try self.buildRequest(from: route)
            request.toConsole()
            let task =  session.dataTask(with: request) { data, response, error in
                
                response?.toConsole()
                
                guard let data = data, error == nil else {
                    completionHandler(nil, nil, response, error)
                    return
                }
                
                completionHandler(try? JSONDecoder().decode(T.self, from: data), data, response, nil)
            }
            
            taskIdentifier = task.taskIdentifier    // Record taskIdentifier
            self.tasks[task.taskIdentifier] = task  // Save task
            task.resume()   // Resume
        } catch {
            completionHandler(nil, nil, nil, error)
        }
        
        return taskIdentifier
    }
    
    public func cancel(taskIdentifier: Int) {
        self.tasks[taskIdentifier]??.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.url!,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
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
}

extension Router {
    
    public func request<T: Codable>(_ route: EndPoint, completionHandler: @escaping (Result<T,Error>) -> Void) -> Int? {
        let session = URLSession.shared
        var taskIdentifier: Int?
        do {
            let request = try self.buildRequest(from: route)
            request.toConsole() // Log this request
            
            let task = session.dataTask(with: request) { data, response, error in
                response?.toConsole()   // Log this request
                
                if let data = data, let parsedData = try? JSONDecoder().decode(T.self, from: data) {
                    completionHandler(.success(parsedData))
                } else if let error = error {
                    completionHandler(.failure(error))
                }
            }
            
            taskIdentifier = task.taskIdentifier    // Record taskIdentifier
            self.tasks[task.taskIdentifier] = task  // Save task
            task.resume()   // Resume
        } catch {
            completionHandler(.failure(error))
        }
        return taskIdentifier
    }
    
    public func request<T: Codable>(_ route: EndPoint) -> Future<T> {
        let promise = Promise<T>()

        do {
            let request = try self.buildRequest(from: route)
            request.toConsole() // Log this request
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                response?.toConsole()   // Log this request
                
                if let data = data, let parsedData = try? JSONDecoder().decode(T.self, from: data) {
                    promise.resolve(with: parsedData)
                } else if let error = error {
                    promise.reject(with: error)
                } else {
                    promise.reject(with: NetworkError.jsonParsing)
                }
            }
            self.tasks[task.taskIdentifier] = task  // Save task
            task.resume()   // Resume
        } catch {
            promise.reject(with: error)
        }
        
        return promise
    }
}
