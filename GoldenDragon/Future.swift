//
//  Future.swift
//  BlueDragon
//
//  Created by harsh vishwakarma on 20/04/19.
//  Copyright © 2019 Harsh Vishwakarma. All rights reserved.
//

import Foundation

public class Future<Value> {
    fileprivate var result: Result<Value, Error>? {
        // Observe whenever a result is assigned, and report it
        didSet { result.map(report) }
    }
    
    private lazy var callbacks = [(Result<Value, Error>) -> Void]()
    
    func observe(with callback: @escaping (Result<Value, Error>) -> Void) {
        callbacks.append(callback)
        
        // If a result has already been set, call the callback directly
        result.map(callback)
    }
    
    private func report(result: Result<Value, Error>) {
        for callback in callbacks {
            callback(result)
        }
    }
}

public class Promise<Value>: Future<Value> {
    init(value: Result<Value, Error>? = nil) {
        super.init()
        result = value
    }
    
    func resolve(with value: Value) {
        result = .success(value)
    }
    
    func reject(with error: Error) {
        result = .failure(error)
    }
}
