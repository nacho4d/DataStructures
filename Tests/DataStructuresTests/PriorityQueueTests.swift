//
//  PriorityQueueTests.swift
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/07/02.
//

import Foundation

import XCTest
@testable import DataStructures

final class PriorityQueueTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func testBasics() throws {
        let queue = PriorityQueue<Int>()
        // Test empty
        XCTAssertEqual(queue.count, 0)
        XCTAssertNil(queue.peek())
        XCTAssertEqual(queue.count, 0)
        XCTAssertNil(queue.poll())
        XCTAssertEqual(queue.count, 0)

        queue.insert(1)
        XCTAssertEqual(queue.count, 1)
        queue.insert(8)
        XCTAssertEqual(queue.count, 2)
        queue.insert(7)
        XCTAssertEqual(queue.count, 3)
        queue.insert(4)
        XCTAssertEqual(queue.count, 4)
        queue.insert(3)
        XCTAssertEqual(queue.count, 5)
        queue.insert(5)
        XCTAssertEqual(queue.count, 6)
        queue.insert(6)
        XCTAssertEqual(queue.count, 7)

        //XCTAssertEqual(queue.queue, [1, 3, 5, 4, 8, 7, 6])
        XCTAssertEqual(queue.queue, [1, 3, 5, 8, 4, 7, 6])

        XCTAssertEqual(queue.poll(), 1)
        XCTAssertEqual(queue.count, 6)

        queue.insert(0)
        XCTAssertEqual(queue.count, 7)
        XCTAssertEqual(queue.poll(), 0)
        XCTAssertEqual(queue.count, 6)
    }

    func testInitWithSequence() throws {
//        let queue = Queue(sequence: [1, 3, 5, 7])
//        XCTAssertEqual(queue.dequeue(), 1)
//        XCTAssertEqual(queue.dequeue(), 3)
//        XCTAssertEqual(queue.dequeue(), 5)
//        XCTAssertEqual(queue.dequeue(), 7)
//        XCTAssertNil(queue.dequeue())
    }

    static var allTests = [
        ("testBasics", testBasics),
        ("testInitWithSequence", testInitWithSequence),
    ]
}
