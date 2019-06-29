//
//  SortTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/26.
//

import XCTest
@testable import DataStructures

final class SortTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func testBubbleSort() throws {
        var array = [Int]()
        array.sortBubble(by: <)
        XCTAssertEqual(array, [])

        array = [5]
        array.sortBubble(by: <)
        XCTAssertEqual(array, [5])

        array = [5, 1, 4, 2, 8]
        array.sortBubble(by: <)
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testButtleSortBestCase() {
        // Best case: Array already sorted
        var array = [1, 2, 4, 5, 8]
        array.sortBubble(by: <)
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testButtleSortWorstCase() {
        // Worst case: Array sorted in reverse order
        var array = [8, 5, 4, 2, 1]
        array.sortBubble(by: <)
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testInsertionSort() throws {
        var array = [Int]()
        array.sortInsertion(by: <)
        XCTAssertEqual(array, [])

        array = [5]
        array.sortInsertion(by: <)
        XCTAssertEqual(array, [5])

        array = [5, 1, 4, 2, 8]
        array.sortInsertion(by: <)
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testInsertionSortBestCase() {
        // Best case: Array already sorted
        var array = [1, 2, 4, 5, 8]
        array.sortInsertion(by: <)
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testInsertionSortWorstCase() {
        // Worst case: Array sorted in reverse order
        var array = [8, 5, 4, 2, 1]
        array.sortInsertion(by: <)
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testBinaryInsertionSort() throws {
        var array = [Int]()
        array.sortBinaryInsertion { return ComparisonResult($0 - $1) }
        XCTAssertEqual(array, [])

        array = [5]
        array.sortBinaryInsertion { return ComparisonResult($0 - $1) }
        XCTAssertEqual(array, [5])

        array = [5, 1, 4, 2, 8]
        array.sortBinaryInsertion { return ComparisonResult($0 - $1) }
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testBinaryInsertionSortBestCase() {
        // Best case: Array already sorted
        var array = [1, 2, 4, 5, 8]
        array.sortBinaryInsertion { return ComparisonResult($0 - $1) }
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testBinaryInsertionSortWorstCase() {
        // Worst case: Array sorted in reverse order
        var array = [8, 5, 4, 2, 1]
        array.sortBinaryInsertion { return ComparisonResult($0 - $1) }
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testQuickSort() {
        var array = [Int]()
        array.sortQuick(by: <)
        XCTAssertEqual(array, [])

        array = [5]
        array.sortQuick(by: <)
        XCTAssertEqual(array, [5])

        array = [5, 1, 4, 2, 8]
        array.sortQuick(by: <)
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testQuickSortLargeCase() {
        var array = [6, 7, 3, 8, 1, 9, 5, 4, 2, 0, 10, -1, 11]
        array.sortQuick(by: <)
        XCTAssertEqual(array, [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    }

    func testMergeSort() {
        var array = [Int]()
        array.sortMerge(by: <)
        XCTAssertEqual(array, [])

        array = [5]
        array.sortMerge(by: <)
        XCTAssertEqual(array, [5])

        array = [5, 1, 4, 2, 8]
        array.sortMerge(by: <)
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testMergeSortLargeCase() {
        var array = [6, 7, 3, 8, 1, 9, 5, 4, 2, 0, 10, -1, 11]
        array.sortMerge(by: <)
        XCTAssertEqual(array, [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    }

    static var allTests = [
        ("testBubbleSort", testBubbleSort),
        ("testButtleSortBestCase", testButtleSortBestCase),
        ("testButtleSortWorstCase", testButtleSortWorstCase),
        ("testInsertionSort", testInsertionSort),
        ("testInsertionSortBestCase", testInsertionSortBestCase),
        ("testInsertionSortWorstCase", testInsertionSortWorstCase),
        ("testQuickSort", testQuickSort),
        ("testQuickSortLargeCase", testQuickSortLargeCase),
        ("testMergeSort", testMergeSort),
        ("testMergeSortLargeCase", testMergeSortLargeCase),
    ]
}
