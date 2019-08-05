//
//  QuickSortTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/26.
//

import XCTest
@testable import DataStructures

final class QuickSortTests: BaseTestCase {

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

        array = [5, 1, 4, 2, 8]
        array.sortQuick()
        XCTAssertEqual(array, [1, 2, 4, 5, 8])
    }

    func testQuickSortLargeCase() {
        var array = [6, 7, 3, 8, 1, 9, 5, 4, 2, 0, 10, -1, 11]
        array.sortQuick(by: <)
        XCTAssertEqual(array, [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    }

    static var allTests = [
        ("testQuickSort", testQuickSort),
        ("testQuickSortLargeCase", testQuickSortLargeCase),
    ]
}
