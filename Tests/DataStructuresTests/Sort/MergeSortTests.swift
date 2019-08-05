//
//  MergeSortTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/26.
//

import XCTest
@testable import DataStructures

final class MergeSortTests: BaseTestCase {

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

        array = [5, 1, 4, 2, 8]
        array.sortMerge()
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testMergeSortLargeCase() {
        var array = [6, 7, 3, 8, 1, 9, 5, 4, 2, 0, 10, -1, 11]
        array.sortMerge(by: <)
        XCTAssertEqual(array, [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    }

    static var allTests = [
        ("testMergeSort", testMergeSort),
        ("testMergeSortLargeCase", testMergeSortLargeCase),
    ]
}
