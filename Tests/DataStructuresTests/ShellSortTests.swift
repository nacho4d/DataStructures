//
//  ShellSortTests.swift
//  DataStructuresPackageTests
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/08/02.
//

import XCTest
@testable import DataStructures

final class SortShellTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func testShellSort() throws {
        var array: [Int]

        // Empty
        array = [Int]()
        array.sortShell()
        XCTAssertEqual(array, [])

        // Single element
        array = [5]
        array.sortShell()
        XCTAssertEqual(array, [5])

        // Normal sort
        array = [62, 83, 18, 53, 07, 17, 95, 86, 47, 69, 25, 28]
        array.sortShell()
        XCTAssertEqual(array, [7, 17, 18, 25, 28, 47, 53, 62, 69, 83, 86, 95])

        // Inverted sort
        array = [62, 83, 18, 53, 07, 17, 95, 86, 47, 69, 25, 28]
        array.sortShell { $0 < $1 ? .orderedDescending : $0 > $1 ? .orderedAscending : .orderedSame }
        XCTAssertEqual(array, [95, 86, 83, 69, 62, 53, 47, 28, 25, 18, 17, 7])
    }

    static var allTests = [
        ("testShellSort", testShellSort),
    ]
}
