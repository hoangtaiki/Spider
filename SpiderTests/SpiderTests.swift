//
//  SpiderTests.swift
//  SpiderTests
//
//  Created by Harry Tran on 7/17/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import XCTest
@testable import Spider

//swiftlint:disable force_try
class SpiderTests: XCTestCase {
    
    private let session = URLSession(configuration: .default)

    private let appleURLString = "https://www.apple.com"
    private let googleURLString = "https://www.google.com"
    private let responseBody = "{\"value\":\"test\"}".data(using: .utf8)

    override func setUp() {
        Spider.default.start()
    }
    
    override func tearDown() {
        Spider.default.stop()
    }
    
    func testRequestWithSuccessResponse() {
        let response = StubResponse.success(200, responseBody!)
        let stub = StubRequest(method: .GET, matcher: appleURLString.asStringMatcher(), response: response)
        Spider.default.addStubRequest(stub)
        
        let expectation = self.expectation(description: "Stubs network call return success response")
        let task = session.dataTask(with: appleURLString.asURL()!) { [weak self] data, _, _ in
            XCTAssertEqual(data, self?.responseBody)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFailedRequestWithNoneDataResponse() {
        let error = NSError(domain: "com.apple.error", code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Unauthorized"])
        let response = StubResponse.failed(422, nil, error)
        let stub = StubRequest(method: .GET, matcher: StringMatcher(string: appleURLString), response: response)
        Spider.default.addStubRequest(stub)
        
        let expectation = self.expectation(description: "Stubs network call return error response")
        let task = session.dataTask(with: appleURLString.asURL()!) { _, _, err in
            XCTAssertEqual(err as NSError?, error)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFailedRequestWithDataResponse() {
        let response = StubResponse.failed(422, responseBody!, nil)
        let stub = StubRequest(method: .GET, matcher: StringMatcher(string: appleURLString), response: response)
        Spider.default.addStubRequest(stub)
        
        let expectation = self.expectation(description: "Stubs network call return error response")
        let task = session.dataTask(with: appleURLString.asURL()!) { [weak self] data, _, _ in
            XCTAssertEqual(data, self?.responseBody)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }

    func testRequestWithRegexMatcher() {
        let regex = try! NSRegularExpression(pattern: appleURLString, options: [])
        let matcher = RegexMatcher(regex: regex)

        let urlString = "https://www.apple.com/abc"
        let url = URL(string: urlString)!
        let response = StubResponse.success(200, responseBody!)
        let stub = StubRequest(method: .GET, matcher: matcher, response: response)
        Spider.default.addStubRequest(stub)
        
        let expectation = self.expectation(description: "Stubs network call return success response")
        let task = session.dataTask(with: url) { [weak self] data, _, _ in
            XCTAssertEqual(data, self?.responseBody)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testRequestWithNoStub() {
        let response = StubResponse.success(200, responseBody!)
        let stub = StubRequest(method: .GET, matcher: StringMatcher(string: appleURLString), response: response)
        Spider.default.addStubRequest(stub)

        let error = NSError(domain: NSExceptionName.internalInconsistencyException.rawValue, code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Handling request without a matching stub."])
        let expectation = self.expectation(description: "Stubs network call return error response")
        let task = session.dataTask(with: googleURLString.asURL()!) { _, _, err in
            XCTAssertEqual(err as NSError?, error)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }

    func testClearAllStubs() {
        let response = StubResponse.success(200, responseBody!)
        // Create GET Stub
        let getStub = StubRequest(method: .GET, matcher: StringMatcher(string: appleURLString), response: response)
        Spider.default.addStubRequest(getStub)
        
        // Create POST Stub
        let postStub = StubRequest(method: .POST,
                                   matcher: StringMatcher(string: appleURLString),
                                   response: response)
        Spider.default.addStubRequest(postStub)
        
        Spider.default.clearStubs()
        
        XCTAssert(Spider.default.stubbedRequests.isEmpty)
    }
}
