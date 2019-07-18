//
//  StubRequest.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public struct StubRequest: Equatable {

    public let method: HTTPMethod
    public var headers: HTTPHeaders = [:]
    public let body: Data?
    public let matcher: Matcher
    public let response: StubResponse

    /// Initialize a request with method and url
    ///
    /// - Parameters:
    ///   - method: The `HTTPMethod` to match
    ///   - url: The `URL` to match
    public init(method: HTTPMethod, headers: HTTPHeaders = [:], body: Data? = nil, matcher: Matcher, response: StubResponse) {
        self.method = method
        self.headers = headers
        self.body = body
        self.matcher = matcher
        self.response = response
    }
    
    public func matchesRequest(_ request: URLRequestType) -> Bool {
        return request.method == method
            && headers == request.headers
            && body == request.body
            && matcher.matches(string: request.url?.absoluteString)
    }
    
    public static func == (lhs: StubRequest, rhs: StubRequest) -> Bool {
        return lhs.method == rhs.method
            && lhs.headers == rhs.headers
            && lhs.body == rhs.body
            && lhs.matcher.isEqual(to: rhs.matcher)
    }
}
