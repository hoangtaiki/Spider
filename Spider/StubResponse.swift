//
//  StubResponse.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

public protocol StubResponseType {
    var statusCode: Int { get }
    var headers: HTTPHeaders { get }
    var body: Data? { get }
    var error: NSError? { get }
}

public struct StubResponse: StubResponseType {
    
    public let statusCode: Int
    public let headers: HTTPHeaders
    public var body: Data?
    public var error: NSError?
    
    public init(statusCode: Int = 200, headers: HTTPHeaders = [:], body: Data) {
        self.statusCode = statusCode
        self.headers = headers
        self.body = body
    }
    
    public init(statusCode: Int = 500, headers: HTTPHeaders = [:], error: NSError) {
        self.statusCode = statusCode
        self.headers = headers
        self.error = error
    }
}
