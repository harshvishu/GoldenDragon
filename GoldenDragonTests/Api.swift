//
//  ApiSample.swift
//  BlueDragonTests
//
//  Created by harsh vishwakarma on 20/04/19.
//  Copyright © 2019 Harsh Vishwakarma. All rights reserved.
//

import Foundation
@testable import GoldenDragon

enum Api {
    case search(query: String)
}

extension Api: EndPointType {
    
    public  var host: String {
        return "api.github.com"
    }
    
    public  var scheme: String {
        return "https"
    }
    
    public  var path: String {
        switch self {
        case .search:
            return "/search/repositories"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .search(let query):
            let params: Parameters = [
                "q": query
            ]
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params)
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
