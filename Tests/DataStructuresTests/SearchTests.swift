//
//  SearchTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/27.
//

import XCTest
@testable import DataStructures

extension ComparisonResult {
    init(_ num: Int) {
        if num < 0 {
            self = .orderedAscending
        } else if num == 0 {
            self = .orderedSame
        } else {
            self = .orderedDescending
        }
    }
}
extension ComparisonResult: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .orderedAscending: return "orderedAscending"
        case .orderedDescending: return "orderedDescending"
        case .orderedSame: return "orderedSame"
        }
    }
}

final class SearchTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func testLinearSearch() throws {
        var calledTimes = 0
        let arr = [1, 3, 5, 7, 9]
        let index = arr.searchLinear { e, i in calledTimes += 1; return ComparisonResult(7 - e) }
        XCTAssertNotNil(index)
        XCTAssertEqual(index, 3)
        XCTAssertEqual(calledTimes, 4)
    }

    func testLinearInverted() throws {
        var calledTimes = 0
        let arr = [9, 7, 5, 3, 1]
        let index = arr.searchLinear { e, i in calledTimes += 1; return ComparisonResult(e - 7) }
        XCTAssertNotNil(index)
        XCTAssertEqual(index, 1)
        XCTAssertEqual(calledTimes, 2)
    }

    func testLinearSearchNotFound() throws {
        var calledTimes = 0
        let arr = [1, 3, 5, 7, 9, 11]
        let index = arr.searchLinear { e, i in calledTimes += 1; return ComparisonResult(4 - e) }
        XCTAssertNil(index)
        XCTAssertEqual(calledTimes, 3)

        let indexNotFound = arr.searchLinear { e, i in return ComparisonResult(15 - e) }
        XCTAssertNil(indexNotFound)
    }

    func testBinarySearch() throws {
        var calledTimes = 0
        let arr = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21]
        let index = arr.searchBinary { e, i in calledTimes += 1; return ComparisonResult(7 - e) }
        XCTAssertNotNil(index)
        XCTAssertEqual(index, 3)
        XCTAssertEqual(calledTimes, 3)
    }

    func testBinarySearchInverted() throws {
        var calledTimes = 0
        let arr = [21, 19, 17, 15, 13, 11, 9, 7, 5, 3, 1]
        let index = arr.searchBinary { e, i in calledTimes += 1; return ComparisonResult(e - 7) }
        XCTAssertNotNil(index)
        XCTAssertEqual(index, 7)
        XCTAssertEqual(calledTimes, 4)
    }

    func testBinarySearchNotFound() throws {
        var calledTimes = 0
        let arr = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31]
        let index = arr.searchBinary { e, i in calledTimes += 1; return ComparisonResult(28 - e) }
        XCTAssertNil(index)
        XCTAssertEqual(calledTimes, 4) // 17, 25, 29, 27

        let indexNotFound = [].searchBinary { e, i in return .orderedSame }
        XCTAssertNil(indexNotFound)
    }

    func testBinarySearchInternal() throws {
        let arr = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31]
        var l: Int
        var u: Int
        var index: Int?
//        l = 2
//        u = 7
//        index = arr.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(1 - elem) }
//        XCTAssertNil(index)
//
//        l = 2
//        u = 7
//        index = arr.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(3 - elem) }
//        XCTAssertNil(index)
//
//        l = 2
//        u = 7
//        index = arr.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(5 - elem) }
//        XCTAssertEqual(index, 2)
//
//        l = 2
//        u = 7
//        index = arr.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(7 - elem) }
//        XCTAssertEqual(index, 3)
//
//        l = 2
//        u = 7
//        index = arr.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(9 - elem) }
//        XCTAssertEqual(index, 4)
//
//        l = 2
//        u = 7
//        index = arr.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(11 - elem) }
//        XCTAssertEqual(index, 5)
//
//        l = 2
//        u = 7
//        index = arr.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(13 - elem) }
//        XCTAssertEqual(index, 6)
//
//        l = 2
//        u = 7
//        index = arr.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(15 - elem) }
//        XCTAssertEqual(index, 7)
//
//        l = 2
//        u = 7
//        index = arr.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(17 - elem) }
//        XCTAssertNil(index)

        let arr2 = [1,2,3,4,5,6,7,8,9]
        l = 0
        u = 8
        index = arr2.__searchBinary(lowerIndex: &l, upperIndex: &u) { elem, i in return ComparisonResult(7 - elem) }
        XCTAssertEqual(index, 6)

    }

}
