import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LinkedListTests.allTests),
        testCase(StackTests.allTests),
        testCase(QueueTests.allTests),
    ]
}
#endif
