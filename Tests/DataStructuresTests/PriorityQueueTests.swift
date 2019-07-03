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
        continueAfterFailure = true
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

        XCTAssertEqual(queue.peek(), 1)
        XCTAssertEqual(queue.poll(), 1)
        XCTAssertEqual(queue.count, 6)

        queue.insert(0)
        XCTAssertEqual(queue.count, 7)
        XCTAssertEqual(queue.poll(), 0)
        XCTAssertEqual(queue.count, 6)
    }

    func testInitWithSequence() throws {
        let queue = PriorityQueue<Int>(sequence: [7, 8, 4, 5, 6, 1, 3])
        queue.reserveCapacity(11)
        XCTAssertEqual(queue.poll(), 1)
        XCTAssertEqual(queue.poll(), 3)
        XCTAssertEqual(queue.poll(), 4)
        XCTAssertEqual(queue.poll(), 5)
        XCTAssertEqual(queue.poll(), 6)
        XCTAssertEqual(queue.poll(), 7)
        XCTAssertEqual(queue.poll(), 8)
        XCTAssertNil(queue.poll())

    }

    func testIntenalSiftDown() throws {
        let queue = PriorityQueue<Int>(sequence: [1, 3, 4, 5, 6, 7, 8])
        // Test array is correctly modified
        XCTAssertEqual(queue.queue, [1, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(queue.poll(), 1)
        XCTAssertEqual(queue.queue, [3, 5, 4, 8, 6, 7])
        XCTAssertEqual(queue.poll(), 3)
        XCTAssertEqual(queue.queue, [4, 5, 7, 8, 6])
        XCTAssertEqual(queue.poll(), 4)
        XCTAssertEqual(queue.queue, [5, 6, 7, 8])
        XCTAssertEqual(queue.poll(), 5)
        XCTAssertEqual(queue.queue, [6, 8, 7])
        XCTAssertEqual(queue.poll(), 6)
        XCTAssertEqual(queue.queue, [7, 8])
        XCTAssertEqual(queue.poll(), 7)
        XCTAssertEqual(queue.queue, [8])
        XCTAssertEqual(queue.poll(), 8)
        XCTAssertEqual(queue.queue, [])
        // Test no crash even on bad usage
        queue.siftDown(index: 0)
        XCTAssertEqual(queue.queue, [])
    }

    func testIntenalSiftUp() throws {
        let queue = PriorityQueue<Int>()
        XCTAssertEqual(queue.queue, [])
        // Test no crash even on bad usage
        queue.siftUp(index: -1)
        XCTAssertEqual(queue.queue, [])
        // Test array is correctly modified
        queue.insert(7)
        XCTAssertEqual(queue.queue, [7])
        queue.insert(8)
        XCTAssertEqual(queue.queue, [7, 8])
        queue.insert(4)
        XCTAssertEqual(queue.queue, [4, 8, 7])
        queue.insert(5)
        XCTAssertEqual(queue.queue, [4, 5, 7, 8])
        queue.insert(6)
        XCTAssertEqual(queue.queue, [4, 5, 7, 8, 6])
        queue.insert(1)
        XCTAssertEqual(queue.queue, [1, 5, 4, 8, 6, 7])
        queue.insert(3)
        XCTAssertEqual(queue.queue, [1, 5, 3, 8, 6, 7, 4])

        let queue2 = PriorityQueue(sequence: [4, 8, 9])
        XCTAssertEqual(queue2.poll(), 4)
        XCTAssertEqual(queue2.queue, [8, 9])
    }

    static var allTests = [
        ("testBasics", testBasics),
        ("testInitWithSequence", testInitWithSequence),
        ("testIntenalSiftDown", testIntenalSiftDown),
        ("testIntenalSiftUp", testIntenalSiftUp),
    ]
}
