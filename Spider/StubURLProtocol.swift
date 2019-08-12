//
//  StubURLProtocol.swift
//  Spider
//
//  Created by Harry Tran on 7/16/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

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
        
        switch stubResponse {
        case let .success(statusCode, data):
            sendResponseData(data, statusCode: statusCode)
        case let .failed(statusCode, data, error):
            if let responseData = data {
                sendResponseData(responseData, statusCode: statusCode)
                return
            } else if let responseError = error {
                sensendResponseError(responseError)
            }
            
            let error = NSError(domain: NSExceptionName.internalInconsistencyException.rawValue, code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Failed response dont contain any data or error"])
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        
    }
    
    private func sendResponseData(_ data: Data, statusCode: Int) {
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode,
                                       httpVersion: nil, headerFields: request.allHTTPHeaderFields)!
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    private func sensendResponseError(_ error: Error) {
        client?.urlProtocol(self, didFailWithError: error)
    }
}
