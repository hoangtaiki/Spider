//
//  SpiderTests.swift
//  SpiderTests
//
//  Created by Harry Tran on 7/17/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import XCTest
@testable import Spider

class SpiderTests: XCTestCase {
    
    override func setUp() {
        Spider.default.start()
    }
    
    override func tearDown() {
        Spider.default.stop()
    }
    
    func testGETRequestWithSuccessResponse() {
        let url = URL(string: "https://www.apple.com")!
        let body = "{\"value\":\"test\"}".data(using: .utf8)!
        let response = StubResponse(body: body)
        let stub = StubRequest(url: url, method: .GET, response: response)
        Spider.default.addStubRequest(stub)
        
        let expectation = self.expectation(description: "Stubs network call return success response")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, error in
            XCTAssertEqual(data, body)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGETRequestWithFailedResponse() {
        let url = URL(string: "https://www.apple.com")!
        let error = NSError(domain: "com.apple.error", code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Unauthorized"])
        let response = StubResponse(error: error)
        let stub = StubRequest(url: url, method: .GET, response: response)
        Spider.default.addStubRequest(stub)
        
        let expectation = self.expectation(description: "Stubs network call return error response")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { _, _, err in
            guard let networkError = err as NSError? else {
                XCTFail("Not found error")
                return
            }
            XCTAssertEqual(networkError, error)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPOSTRequestWithSuccessResponse() {
        let url = URL(string: "https://www.apple.com")!
        let responseBody = "{\"value\":\"test\"}".data(using: .utf8)!
        let response = StubResponse(body: responseBody)
        let requestParamters: [String: Any] = ["id": 1, "name": "Spider"]
        let requestBody = try! JSONSerialization.data(withJSONObject: requestParamters, options: .prettyPrinted)
        let stub = StubRequest(url: url, method: .POST,
                               headers: ["Content-Type": "application/json"],
                               body: requestBody, response: response)
        Spider.default.addStubRequest(stub)
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBody
        
        let expectation = self.expectation(description: "Stubs network call return success response")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, _, error in
            XCTAssertEqual(data, responseBody)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPOSTRequestWithFailedResponse() {
        let url = URL(string: "https://www.apple.com")!
        let error = NSError(domain: "com.apple.error", code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Unauthorized"])
        let response = StubResponse(error: error)
        let requestParamters: [String: Any] = ["id": 1, "name": "Spider"]
        let requestBody = try! JSONSerialization.data(withJSONObject: requestParamters, options: .prettyPrinted)
        let stub = StubRequest(url: url, method: .POST,
                               headers: ["Content-Type": "application/json"],
                               body: requestBody, response: response)
        Spider.default.addStubRequest(stub)

        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBody
        
        let expectation = self.expectation(description: "Stubs network call return error response")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { _, _, err in
            guard let networkError = err as NSError? else {
                XCTFail("Not found error")
                return
            }
            XCTAssertEqual(networkError, error)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testRequestWithNoStub() {
        let stubURL = URL(string: "https://www.apple.com")!
        let body = "{\"value\":\"test\"}".data(using: .utf8)!
        let response = StubResponse(body: body)
        let stub = StubRequest(url: stubURL, method: .GET, response: response)
        Spider.default.addStubRequest(stub)

        let url = URL(string: "https://google.com")!
        let error = NSError(domain: NSExceptionName.internalInconsistencyException.rawValue, code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Handling request without a matching stub."])
        let expectation = self.expectation(description: "Stubs network call return error response")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { _, _, err in
            guard let networkError = err as NSError? else {
                XCTFail("Not found error")
                return
            }
            XCTAssertEqual(networkError, error)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testClearAllStubs() {
        let url = URL(string: "https://www.apple.com")!
        let body = "{\"value\":\"test\"}".data(using: .utf8)!
        let response = StubResponse(body: body)
        // Create GET Stub
        let getStub = StubRequest(url: url, method: .GET, response: response)
        Spider.default.addStubRequest(getStub)
        
        // Create POST Stub
        let requestParamters: [String: Any] = ["id": 1, "name": "Spider"]
        let requestBody = try! JSONSerialization.data(withJSONObject: requestParamters, options: .prettyPrinted)
        let posStub = StubRequest(url: url, method: .POST,
                                  headers: ["Content-Type": "application/json"],
                                  body: requestBody, response: response)
        Spider.default.addStubRequest(posStub)
        
        Spider.default.clearStubs()
        
        XCTAssert(Spider.default.stubbedRequests.isEmpty)
    }
}
