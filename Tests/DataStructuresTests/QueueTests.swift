//
//  QueueTests.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/24.
//

import XCTest
@testable import DataStructures

final class QueueTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func testBasics() throws {
        let queue = Queue<Int>()
        // Test empty
        XCTAssertEqual(queue.count, 0)
        XCTAssertNil(queue.peek())

        // Test enqueue
        queue.enqueue(1)
        XCTAssertEqual(queue.count, 1)
        XCTAssertEqual(queue.peek(), 1)

        // Test contains
        XCTAssertFalse(queue.contains(0))
        XCTAssertTrue(queue.contains(1))
        XCTAssertFalse(queue.contains(2))

        // Test enqueue again
        queue.enqueue(2)
        XCTAssertEqual(queue.count, 2)
        XCTAssertEqual(queue.peek(), 1)

        // Test dequeue
        XCTAssertEqual(queue.dequeue(), 1)
        XCTAssertEqual(queue.count, 1)
        XCTAssertEqual(queue.peek(), 2)

        // Test pop again
        XCTAssertEqual(queue.dequeue(), 2)
        XCTAssertEqual(queue.count, 0)
        XCTAssertNil(queue.peek())

        // Test removeAll
        queue.enqueue(4)
        queue.enqueue(5)
        XCTAssertEqual(queue.count, 2)
        queue.removeAll()
        XCTAssertEqual(queue.count, 0)
    }

    static var allTests = [
        ("testBasics", testBasics),
    ]
}
