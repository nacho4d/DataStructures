//
//  SortTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/26.
//

import XCTest
@testable import DataStructures

final class BubbleSortTests: BaseTestCase {

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

        array = [5, 1, 4, 2, 8]
        array.sortBubble()
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

    static var allTests = [
        ("testBubbleSort", testBubbleSort),
        ("testButtleSortBestCase", testButtleSortBestCase),
        ("testButtleSortWorstCase", testButtleSortWorstCase),
    ]
}
