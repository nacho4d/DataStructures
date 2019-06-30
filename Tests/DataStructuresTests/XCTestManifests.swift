import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LinkedListTests.allTests),
        testCase(QueueTests.allTests),
        testCase(SearchTests.allTests),
        testCase(SortTests.allTests),
        testCase(StackTests.allTests),
    ]
}
#endif
