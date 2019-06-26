//
//  SearchTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/27.
//

import XCTest
@testable import DataStructures

final class SearchTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func testLinearSearch() throws {
        var calledTimes = 0
        let arr = [1, 3, 5, 7, 9]
        let index = arr.searchLinear { calledTimes += 1; return 7 - $0 }
        XCTAssertNotNil(index)
        XCTAssertEqual(index, 3)
        XCTAssertEqual(calledTimes, 4)
    }

    func testLinearInverted() throws {
        var calledTimes = 0
        let arr = [9, 7, 5, 3, 1]
        let index = arr.searchLinear { calledTimes += 1; return $0 - 7}
        XCTAssertNotNil(index)
        XCTAssertEqual(index, 1)
        XCTAssertEqual(calledTimes, 2)
    }

    func testLinearSearchNotFound() throws {
        var calledTimes = 0
        let arr = [1, 3, 5, 7, 9, 11]
        let index = arr.searchLinear { calledTimes += 1; return 4 - $0 }
        XCTAssertNil(index)
        XCTAssertEqual(calledTimes, 3)
    }

    func testBinarySearch() throws {
        var calledTimes = 0
        let arr = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21]
        let index = arr.searchBinary { calledTimes += 1; return 7 - $0 }
        XCTAssertNotNil(index)
        XCTAssertEqual(index, 3)
        XCTAssertEqual(calledTimes, 3)
    }

    func testBinarySearchInverted() throws {
        var calledTimes = 0
        let arr = [21, 19, 17, 15, 13, 11, 9, 7, 5, 3, 1]
        let index = arr.searchBinary { calledTimes += 1; return $0 - 7 }
        XCTAssertNotNil(index)
        XCTAssertEqual(index, 7)
        XCTAssertEqual(calledTimes, 4)
    }

    func testBinarySearchNotFound() throws {
        var calledTimes = 0
        let arr = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31]
        let index = arr.searchBinary { calledTimes += 1; return 28 - $0 }
        XCTAssertNil(index)
        XCTAssertEqual(calledTimes, 5)
    }

}
