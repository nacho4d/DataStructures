//
//  LRUCacheTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/07/26.
//

import XCTest
@testable import DataStructures

final class LRUCacheTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func assertLruCache<K: Hashable, V: Equatable>(_ cache: LRUCache<K, V>, _ dictionary: [K:V], _ nodes:[(key: K, value: V)], file: StaticString = #file, line: UInt = #line) {
        // Assert objects in dictionary
        XCTAssertEqual(cache.storage.count, dictionary.count, "Incorrect numbers of objects in cache. Expected:\(dictionary.count)", file: file, line: line)
        for pair in cache.storage {
            XCTAssertEqual(cache.storage[pair.key]!.value, dictionary[pair.key], "Incorrect value for key: \(pair.key). Expected: \(dictionary[pair.key]!)", file: file, line: line)
        }
        // Assert objects in linked list
        let tempNodes = cache.map { $0 }
        XCTAssertEqual(tempNodes.count, nodes.count, "Incorrect number of frequencies. Expected:\(nodes.count)", file: file, line: line)
        for i in 0..<tempNodes.count {
            XCTAssertEqual(tempNodes[i].key, nodes[i].key, "Incorrect node key. Expected: \(nodes[i].key)", file: file, line: line)
            XCTAssertEqual(tempNodes[i].value, nodes[i].value, "Incorrect node value. Expected: \(nodes[i].value).", file: file, line: line)
        }
    }

    func testBasics() throws {
        let cache = LRUCache<Int, String>(capacity: 5)
        var res: String

        cache[1] = "1"
        assertLruCache(cache, [1: "1"], [(1, "1")])
        cache[2] = "2"
        assertLruCache(cache, [1: "1", 2: "2"], [(1, "1"), (2, "2")])
        cache[3] = "3"
        assertLruCache(cache, [1: "1", 2: "2", 3: "3"], [(1, "1"), (2, "2"), (3, "3")])
        cache[4] = "4"
        assertLruCache(cache, [1: "1", 2: "2", 3: "3", 4: "4"], [(1, "1"), (2, "2"), (3, "3"), (4, "4")])
        cache[5] = "5"
        assertLruCache(cache, [1: "1", 2: "2", 3: "3", 4: "4", 5: "5"], [(1, "1"), (2, "2"), (3, "3"), (4, "4"), (5, "5")])

        res = try XCTUnwrap(cache[1])
        XCTAssertEqual(res, "1")
        assertLruCache(cache, [1: "1", 2: "2", 3: "3", 4: "4", 5: "5"], [(2, "2"), (3, "3"), (4, "4"), (5, "5"), (1, "1")])
        res = try XCTUnwrap(cache[2])
        XCTAssertEqual(res, "2")
        assertLruCache(cache, [1: "1", 2: "2", 3: "3", 4: "4", 5: "5"], [(3, "3"), (4, "4"), (5, "5"), (1, "1"), (2, "2")])

        cache[6] = "6"
        assertLruCache(cache, [1: "1", 2: "2", 4: "4", 5: "5", 6: "6"], [(4, "4"), (5, "5"), (1, "1"), (2, "2"), (6, "6")])
        cache[7] = "7"
        assertLruCache(cache, [1: "1", 2: "2", 5: "5", 6: "6", 7: "7"], [(5, "5"), (1, "1"), (2, "2"), (6, "6"), (7, "7")])
        cache[8] = "8"
        assertLruCache(cache, [1: "1", 2: "2", 6: "6", 7: "7", 8: "8"], [(1, "1"), (2, "2"), (6, "6"), (7, "7"), (8, "8")])

        XCTAssertNil(cache[9])
        assertLruCache(cache, [1: "1", 2: "2", 6: "6", 7: "7", 8: "8"], [(1, "1"), (2, "2"), (6, "6"), (7, "7"), (8, "8")])

        XCTAssertEqual(cache.removeValue(forKey: 6), "6")
        assertLruCache(cache, [1: "1", 2: "2", 7: "7", 8: "8"], [(1, "1"), (2, "2"), (7, "7"), (8, "8")])

        XCTAssertNil(cache.removeValue(forKey: 99))
        assertLruCache(cache, [1: "1", 2: "2", 7: "7", 8: "8"], [(1, "1"), (2, "2"), (7, "7"), (8, "8")])

        cache[98] = nil
        assertLruCache(cache, [1: "1", 2: "2", 7: "7", 8: "8"], [(1, "1"), (2, "2"), (7, "7"), (8, "8")])

        cache[2] = "22"
        assertLruCache(cache, [1: "1", 2: "22", 7: "7", 8: "8"], [(1, "1"), (7, "7"), (8, "8"), (2, "22")])
    }

    func testCapacityInitialization() throws {
        let c = LRUCache<Int, String>(capacity: 0)
        XCTAssertTrue(c.capacity > 0)

        let c1 = LRUCache<Int, String>(capacity: -1)
        XCTAssertTrue(c1.capacity > 0)

        let c2 = LRUCache<Int, String>(capacity: 99)
        XCTAssertEqual(c2.capacity, 99)
    }

    func testSequence() throws {
        let cache = LRUCache<Int, String>(capacity: 4)
        cache[1] = "1"
        cache[2] = "2"
        cache[3] = "3"
        cache[4] = "4"
        _ = cache[1]
        _ = cache[1]
        cache[5] = "5"
        _ = cache[5]
        cache[1] = nil
        cache[99] = "99"
        cache[5] = "5"
        assertLruCache(cache, [3: "3", 4: "4", 5: "5", 99: "99"], [(3, "3"), (4, "4"), (99, "99"), (5, "5")])

        let seq = [(3, "3"), (4, "4"), (99, "99"), (5, "5")]
        let tempArray = cache.map { $0 }
        XCTAssertEqual(seq.count, tempArray.count)
        for i in 0..<tempArray.count {
            XCTAssertEqual(tempArray[i].key, seq[i].0, "")
            XCTAssertEqual(tempArray[i].value, seq[i].1)
        }
    }

    func testInitWithSequence() throws {
    }

    static var allTests = [
        ("testBasics", testBasics),
        ("testCapacityInitialization", testCapacityInitialization),
        ("testInitWithSequence", testInitWithSequence),
    ]
}
