import XCTest

import SpiderTests

var tests = [XCTestCaseEntry]()
tests += SpiderTests.allTests()
tests += MatchersTests.allTests()
XCTMain(tests)
