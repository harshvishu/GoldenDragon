//
//  EndPointType.swift
//  Hoberman-Client
//
//  Created by harsh vishwakarma on 20/04/19.
//  Copyright © 2019 Harsh Vishwakarma. All rights reserved.
//
import Foundation

public protocol EndPointType {
    var host: String { get }
    var path: String { get }
    var scheme: String {get}
    
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }

    var url: URL? {get}
}

public extension EndPointType {
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        return components.url
    }
}
