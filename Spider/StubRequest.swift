//
//  StubRequest.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public struct StubRequest: Hashable {

    public let url: URL
    public let method: HTTPMethod
    public var headers: HTTPHeaders = [:]
    public let body: Data?
    public let response: StubResponse

    /// Initialize a request with method and url
    ///
    /// - Parameters:
    ///   - method: The `HTTPMethod` to match
    ///   - url: The `URL` to match
    public init(url: URL, method: HTTPMethod, headers: HTTPHeaders = [:], body: Data? = nil, response: StubResponse) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.response = response
    }
    
    public func matchesRequest(_ request: URLRequestType) -> Bool {
        return request.method == method
            && url.absoluteString == request.url?.absoluteString
            && headers == request.headers
            && body == request.body
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(method)
        hasher.combine(url.absoluteString)
        hasher.combine(body)
        hasher.combine(headers)
    }
    
    public static func ==(lhs: StubRequest, rhs: StubRequest) -> Bool {
        return lhs.method == rhs.method
            && lhs.url.absoluteString == rhs.url.absoluteString
            && lhs.headers == rhs.headers
            && lhs.body == rhs.body
    }
}
