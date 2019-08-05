import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GraphTests.allTest),
        testCase(LinkedListTests.allTests),
        testCase(QueueTests.allTests),
        testCase(SearchTests.allTests),
        testCase(SortTests.allTests),
        testCase(SortShellTests.allTests),
        testCase(StackTests.allTests),
        testCase(LFUCacheTests.allTests),
        testCase(LRUCacheTests.allTests),
    ]
}
#endif
