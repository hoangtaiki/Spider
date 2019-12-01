//
//  MatchersTests.swift
//  SpiderTests
//
//  Created by Harry Tran on 7/17/19.
//  Copyright © 2019 Harry Tran. All rights reserved.
//

import XCTest
@testable import Spider

// swiftlint:disable force_try
final class MatchersTests: XCTestCase {
    
    private let appleURLString = "https://www.apple.com"
    private let googleURLString = "https://www.google.com"

    func testCompareTwoRegexMatchers() {
        let regex = try! NSRegularExpression(pattern: appleURLString, options: [])
        let first = RegexMatcher(regex: regex)
        let second = RegexMatcher(regex: regex)

        XCTAssert(first.isEqual(to: second))
    }
    
    func testCompareRegexMatcherAndStringMatcher() {
        let regex = try! NSRegularExpression(pattern: appleURLString, options: [])
        let regexMatcher = RegexMatcher(regex: regex)
        let stringMatcher = StringMatcher(string: appleURLString)
        
        XCTAssertFalse(regexMatcher.isEqual(to: stringMatcher))
    }
    
    func testStringMatchWithRegex() {
        let regex = try! NSRegularExpression(pattern: appleURLString, options: [])
        let regexMatcher = RegexMatcher(regex: regex)

        XCTAssert(regexMatcher.matches(string: "https://www.apple.com/users/1"))
        XCTAssertFalse(regexMatcher.matches(string: nil))
        XCTAssertFalse(regexMatcher.matches(string: "http://www.apple.com"))
    }
    
    func testCompareTwoStringMatchers() {
        let first = StringMatcher(string: appleURLString)
        let second = StringMatcher(string: appleURLString)
        let third = StringMatcher(string: googleURLString)
        
        XCTAssert(first.isEqual(to: second))
        XCTAssertFalse(second.isEqual(to: third))
    }
    
    func testCompareStringMatcherAndRegexMatcher() {
        let stringMatcher = StringMatcher(string: appleURLString)
        let regex = try! NSRegularExpression(pattern: appleURLString, options: [])
        let regexMatcher = RegexMatcher(regex: regex)

        XCTAssertFalse(stringMatcher.isEqual(to: regexMatcher))
    }
    
    func testStringMatchStringMatcher() {
        let urlString = appleURLString
        let matcher = StringMatcher(string: appleURLString)
        XCTAssert(matcher.matches(string: urlString))
    }
    
    static var allTests = [
        ("testCompareTwoRegexMatchers", testCompareTwoRegexMatchers),
        ("testCompareRegexMatcherAndStringMatcher", testCompareRegexMatcherAndStringMatcher),
        ("testStringMatchWithRegex", testStringMatchWithRegex),
        ("testCompareTwoStringMatchers", testCompareTwoStringMatchers),
        ("testCompareStringMatcherAndRegexMatcher", testCompareStringMatcherAndRegexMatcher),
        ("testStringMatchStringMatcher", testStringMatchStringMatcher)
    ]
}
