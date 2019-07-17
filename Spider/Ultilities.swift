//
//  Ultilities.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

/// Http method
public enum HTTPMethod: String {
    case GET, HEAD, POST, PUT, DELETE, CONNECT, OPTIONS, TRACE, PATCH
}

/// Http headers type
public typealias HTTPHeaders = [String: String]

extension HTTPHeaders {
    
    static func == (lhs: HTTPHeaders, rhs: HTTPHeaders?) -> Bool {
        guard let rHeaders = rhs else {
            return lhs.isEmpty
        }
        
        for key in lhs.keys {
            guard let value = rHeaders[key] else {
                return false
            }
            
            if value != lhs[key] {
                return false
            }
        }
        
        return true
    }
}
