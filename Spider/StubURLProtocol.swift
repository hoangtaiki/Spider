//
//  StubURLProtocol.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

final class StubURLProtocol: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        return request.url != nil
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Get stub response from stub array
        // If not found return not found stub for request
        guard let stubResponse = Spider.default.response(for: request) else {
            let error = NSError(domain: NSExceptionName.internalInconsistencyException.rawValue, code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Handling request without a matching stub."])
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        // Return success response
        if let data = stubResponse.body {
            let response = HTTPURLResponse(url: request.url!, statusCode: stubResponse.statusCode,
                                           httpVersion: nil, headerFields: stubResponse.headers)!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        
        // Return error response
        if let error = stubResponse.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        let error = NSError(domain: NSExceptionName.internalInconsistencyException.rawValue, code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Not found error for stub"])
        client?.urlProtocol(self, didFailWithError: error)
    }
    
    override func stopLoading() {
    
    }
}
