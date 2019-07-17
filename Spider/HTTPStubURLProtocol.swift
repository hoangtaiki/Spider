//
//  HTTPStubURLProtocol.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import Foundation

struct NoMatchError: Error, CustomStringConvertible {
    
    let request: URLRequest
    
    var description: String {
        return "No matching stub found for \(request)"
    }
}

final class HTTPStubURLProtocol: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        guard let scheme = request.url?.scheme else { return false }
        return ["http", "https"].contains(scheme)
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        // Get stub response from stub array
        // If not found return not found stub for request
        guard let stubResponse = Spider.default.response(for: request), let requestURL = request.url else {
            let error = NSError(domain: NSExceptionName.internalInconsistencyException.rawValue, code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Handling request without a matching stub."])
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        if let data = stubResponse.body {
            let response = HTTPURLResponse(url: requestURL, statusCode: stubResponse.statusCode,
                                           httpVersion: nil, headerFields: stubResponse.headers)!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        
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
