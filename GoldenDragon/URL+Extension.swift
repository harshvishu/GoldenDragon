//
//  URL+Extension.swift
//  BlueDragon
//
//  Created by harsh vishwakarma on 20/04/19.
//  Copyright © 2019 Harsh Vishwakarma. All rights reserved.
//

import Foundation

public extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}


extension URLResponse {
    func toConsole() {
        NetworkLogger.log(response: self)
    }
}

extension URLRequest {
    func toConsole() {
        NetworkLogger.log(request: self)
    }
}
