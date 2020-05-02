//
//  RequestRetier.swift
//  Hoberman-Client
//
//  Created by ISHIR on 30/10/18.
//  Copyright © 2018 Hoberman. All rights reserved.
//

import Foundation

protocol RequestRetier {
    func add(for key: String)
    func clear()
    func remove(for key: String)
    func count(for key: String) -> Int
    func canRetry(for key: String) -> Bool
}
