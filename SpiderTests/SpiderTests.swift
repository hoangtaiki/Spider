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
    
    func testExample() {
        let url = URL(string: "http://www.apple.com")!
        let body = "{\"value\":\"test\"}".data(using: .utf8)!
        let response = StubResponse(body: body)
        let stub = StubRequest(method: .GET, url: url, response: response)
        Spider.default.addStubRequest(stub)
        
        Spider.default.start()
        
        let expectation = self.expectation(description: "Stubs network call")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, res, _ in
            print(res!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
            XCTAssertEqual(data, body)
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 1)
    }
}
