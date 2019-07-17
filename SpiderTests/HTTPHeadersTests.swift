//
//  HTTPHeadersTests.swift
//  SpiderTests
//
//  Created by Harry Tran on 7/17/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import XCTest
@testable import Spider

class HTTPHeadersTests: XCTestCase {
    
    func testCompareTwoHTTPHeaders() {
        let firstHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
        var secondHeaders: HTTPHeaders!
        secondHeaders = [:]
        secondHeaders?["Content-Type"] = "application/json"
        XCTAssertFalse(firstHeaders == secondHeaders)
        
        secondHeaders?["Acc"] = "application/json"
        XCTAssertFalse(firstHeaders == secondHeaders)
        
        secondHeaders?["Accept"] = "application"
        XCTAssertFalse(firstHeaders == secondHeaders)
        
        XCTAssertFalse(firstHeaders == nil)
    }
}
