//
//  HTTPRequest.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public protocol URLRequestType {
    var url: URL? { get }
    var method: HTTPMethod? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

extension URLRequest: URLRequestType {
    
    public var method: HTTPMethod? {
        return HTTPMethod(rawValue: httpMethod!)
    }
    
    public var headers: [String: String]? {
        return allHTTPHeaderFields
    }
    
    public var body: Data? {
        guard let stream = httpBodyStream else {
            return httpBody
        }
        
        var data = Data()
        stream.open()
        let bufferSize = 4096
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while stream.hasBytesAvailable {
            let read = stream.read(buffer, maxLength: bufferSize)
            data.append(buffer, count: read)
        }
        buffer.deallocate()
        stream.close()
        
        return data
    }
}
