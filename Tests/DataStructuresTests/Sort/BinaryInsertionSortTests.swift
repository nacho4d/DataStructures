//
//  SortTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/26.
//

import XCTest
@testable import DataStructures

final class BinarySortTests: BaseTestCase {

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

        array = [5, 1, 4, 2, 8]
        array.sortBinaryInsertion()
        XCTAssertEqual(array, [1, 2, 4, 5, 8])

        array = [5, 1, 4, 2, 4, 8]
        array.sortBinaryInsertion()
        XCTAssertEqual(array, [1, 2, 4, 4, 5, 8])
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

    static var allTests = [
        ("testBinaryInsertionSort", testBinaryInsertionSort),
        ("testBinaryInsertionSortBestCase", testBinaryInsertionSortBestCase),
        ("testBinaryInsertionSortWorstCase", testBinaryInsertionSortWorstCase),
    ]
}
