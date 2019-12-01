import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SpiderTests.allTests),
        testCase(MatchersTests.allTests)
    ]
}
#endif
