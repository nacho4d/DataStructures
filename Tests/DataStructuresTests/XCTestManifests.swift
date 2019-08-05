import XCTest

class BaseTestCase: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

}

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GraphTests.allTest),
        testCase(LinkedListTests.allTests),
        testCase(QueueTests.allTests),
        testCase(SearchTests.allTests),
        testCase(SortTests.allTests),
        testCase(BinarySortTests.allTests),
        testCase(BubbleSortTests.allTests),
        testCase(HeapSortTests.allTests),
        testCase(InsertionSortTests.allTests),
        testCase(MergeSortTests.allTests),
        testCase(QuickSortTests.allTests),
        testCase(ShellSortTests.allTests),
        testCase(StackTests.allTests),
        testCase(LFUCacheTests.allTests),
        testCase(LRUCacheTests.allTests),
    ]
}
#endif
