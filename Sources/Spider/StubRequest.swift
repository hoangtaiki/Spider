//
//  StubRequest.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public struct StubRequest: Equatable {

    public enum HTTPMethod: String {
        case GET, HEAD, POST, PUT, DELETE, CONNECT, OPTIONS, TRACE, PATCH
    }
    
    public let method: HTTPMethod
    public let matcher: Matcher
    public let response: StubResponse

    /// Initialize a request with method and url
    ///
    /// - Parameters:
    ///   - method: The `HTTPMethod` to match
    ///   - url: The `URL` to match
    public init(method: HTTPMethod, matcher: Matcher, response: StubResponse) {
        self.method = method
        self.matcher = matcher
        self.response = response
    }
    
    public func matchesRequest(_ request: URLRequest) -> Bool {
        return HTTPMethod(rawValue: request.httpMethod!) == method
            && matcher.matches(string: request.url?.absoluteString)
    }
    
    public static func == (lhs: StubRequest, rhs: StubRequest) -> Bool {
        return lhs.method == rhs.method
            && lhs.matcher.isEqual(to: rhs.matcher)
    }
}
