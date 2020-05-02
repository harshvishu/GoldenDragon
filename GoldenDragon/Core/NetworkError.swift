//
//  NetworkError.swift
//  BlueDragon
//
//  Created by harsh vishwakarma on 20/04/19.
//  Copyright © 2019 Harsh Vishwakarma. All rights reserved.
//

import Foundation

public struct NetworkError: LocalizedError {

    var title: String?
    var code: Int
    public var errorDescription: String? { return _description }
    public var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }

    static var jsonParsing = NetworkError(title: "Unable to parse json", description: "Unable to parse json into model", code: 999)
    static var parametersNil =  NetworkError(title: "Parameters were nil", description: "Unable to parse json into model", code: 998)
    static var encodingFailed =  NetworkError(title: "Parameter encoding failed", description: "Unable to parse json into model", code: 997)
    static var missingURL =  NetworkError(title: "URL is nil", description: "Unable to parse json into model", code: 996)
}
