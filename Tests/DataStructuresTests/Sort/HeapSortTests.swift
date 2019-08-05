//
//  HeapSortTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/26.
//

import XCTest
@testable import DataStructures

final class HeapSortTests: BaseTestCase {

    func testHeapSort() {
        var array = [8, 2, 5, 4, 1]
        array.sortHeap()
        XCTAssertEqual(array, [1, 2, 4, 5, 8])

        array = [6, 7, 3, 8, 1, 9, 5, 4, 2, 0, 10, -1, 11]
        array.sortHeap()
        XCTAssertEqual(array, [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    }

    static var allTests = [
        ("testHeapSort", testHeapSort),
    ]
}
