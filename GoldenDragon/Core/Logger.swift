//
//  Logger.swift
//  Hoberman-Client
//
//  Created by harsh vishwakarma on 20/04/19.
//  Copyright © 2019 Harsh Vishwakarma. All rights reserved.
//

import Foundation

enum LogMethod: String {
    case error      // use to print errors
    case info       // use to print information
    case verbose    // use for general purpose
    case debug  // use when debuging a value
}

/**
 Manage string debug print functions here
 
 */
struct Logger {
    
    /// print anything to the console
    #if DEBUG
    static func log(method: LogMethod = .info, _ any: Any?...) {
        // Print only when we are in debug mode
        if any.count == 1 {
            print("LOG \(method.rawValue): ", any[0] ?? "NIL")
        } else {
            print("LOG \(method.rawValue): ", any.compactMap {$0})
        }
    }
    #else
    static func log(method: LogMethod = .info, _ any: Any?...) {
        // Plain do nothing in release mode
    }
    #endif
}
