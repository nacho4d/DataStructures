//
//  CacheTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/07/20.
//

import XCTest
@testable import DataStructures

final class CacheTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func assertLfuCache<K: Hashable, V: Equatable>(_ cache: LFUCache<K, V>, _ dictionary: [K:V], _ lists:[(Int, [V])], file: StaticString = #file, line: UInt = #line) {
        var tempDic = [K: V]()
        var tempLists = [(Int, [V])]()
        for pair in cache.nodes {
            tempDic[pair.key] = pair.value.value
        }
        var fnNode: FrequencyNode<K, V>? = cache.frequencies.first
        while fnNode != nil {
            let list = fnNode!.nodes.map { $0 }
            tempLists.append((fnNode!.value, list))
            fnNode = fnNode!.next
        }
        // Assert objects in dictionary
        XCTAssertEqual(tempDic.count, dictionary.count, "Incorrect numbers of objects in cache. Expected:\(dictionary.count)", file: file, line: line)
        for pair in tempDic {
            XCTAssertEqual(tempDic[pair.key], dictionary[pair.key], "Incorrect object for key: \(pair.key). Expected: \(dictionary[pair.key])", file: file, line: line)
        }
        XCTAssertEqual(tempLists.count, lists.count, "Incorrect number of frequencies. Expected:\(lists.count)", file: file, line: line)
        let total = lists.reduce(0) { return $0 + $1.1.count }
        let tempTotal = tempLists.reduce(0) { return $0 + $1.1.count }
        XCTAssertEqual(tempTotal, total, "Incorrect total number of nodes. Expected: \(total)", file: file, line: line)
        for i in 0..<tempLists.count {
            XCTAssertEqual(tempLists[i].0, lists[i].0, "Incorrect frequency", file: file, line: line)
            XCTAssertEqual(tempLists[i].1, lists[i].1, "Incorrect objects in nodes of frequency: \(lists[i].0).", file: file, line: line)
        }
    }

    func testGet() throws {
        let cache = LFUCache<Int, String>(capacity: 5)
        var res: String

        cache[1] = "1"
        assertLfuCache(cache, [1: "1"], [(1, ["1"])])
        res = try XCTUnwrap(cache[1])
        XCTAssertEqual(res, "1")
        assertLfuCache(cache, [1: "1"], [(2, ["1"])])
        res = try XCTUnwrap(cache[1])
        XCTAssertEqual(res, "1")
        assertLfuCache(cache, [1: "1"], [(3, ["1"])])
        XCTAssertNil(cache[8])
        assertLfuCache(cache, [1: "1"], [(3, ["1"])])
    }

    func testGet2() throws {
        let cache = LFUCache<Int, String>(capacity: 5)
        var res: String

        cache[1] = "1"
        assertLfuCache(cache, [1: "1"], [(1, ["1"])])
        cache[2] = "2"
        assertLfuCache(cache, [1: "1", 2: "2"], [(1, ["2", "1"])])
        res = try XCTUnwrap(cache[1])
        XCTAssertEqual(res, "1")
        assertLfuCache(cache, [1: "1", 2: "2"], [(1, ["2"]), (2, ["1"])])
        res = try XCTUnwrap(cache[1])
        XCTAssertEqual(res, "1")
        assertLfuCache(cache, [1: "1", 2: "2"], [(1, ["2"]), (3, ["1"])])

        XCTAssertNil(cache[8])
        assertLfuCache(cache, [1: "1", 2: "2"], [(1, ["2"]), (3, ["1"])])
    }

    func testBasics() throws {

        let cache = LFUCache<Int, String>(capacity: 4)
        cache[1] = "1"
        assertLfuCache(cache, [1: "1"], [(1, ["1"])])
        cache[2] = "2"
        assertLfuCache(cache, [1: "1", 2: "2"], [(1, ["2", "1"])])

        cache[3] = "3"
        assertLfuCache(cache, [1: "1", 2: "2", 3: "3"], [(1, ["3", "2", "1"])])
        cache[4] = "4"
        assertLfuCache(cache, [1: "1", 2: "2", 3: "3", 4: "4"], [(1, ["4", "3", "2", "1"])])

        _ = cache[1]
        assertLfuCache(cache, [1: "1", 2: "2", 3: "3", 4: "4"], [(1, ["4", "3", "2"]), (2, ["1"])])
        _ = cache[1]
        assertLfuCache(cache, [1: "1", 2: "2", 3: "3", 4: "4"], [(1, ["4", "3", "2"]), (3, ["1"])])

        cache[5] = "5"
        assertLfuCache(cache, [1: "1", 3: "3", 4: "4", 5: "5"], [(1, ["5", "4", "3"]), (3, ["1"])])

        _ = cache[5]
        assertLfuCache(cache, [1: "1", 3: "3", 4: "4", 5: "5"], [(1, ["4", "3"]), (2, ["5"]), (3, ["1"])])

        cache[1] = nil
        assertLfuCache(cache, [3: "3", 4: "4", 5: "5"], [(1, ["4", "3"]), (2, ["5"])])

        cache[99] = "99"
        assertLfuCache(cache, [3: "3", 4: "4", 5: "5", 99: "99"], [(1, ["99", "4", "3"]), (2, ["5"])])

        cache[5] = "5"
        assertLfuCache(cache, [3: "3", 4: "4", 5: "5", 99: "99"], [(1, ["99", "4", "3"]), (3, ["5"])])

        XCTAssertNil(cache.removeValue(forKey: 88))
        assertLfuCache(cache, [3: "3", 4: "4", 5: "5", 99: "99"], [(1, ["99", "4", "3"]), (3, ["5"])])
    }

    func testBasicsWithSpecialFrequencyNodeRemoval() throws {
        let c = LFUCache<Int, String>(capacity: 3)
        c[1] = "1"
        c[2] = "2"
        c[3] = "3"
        _ = c[1]
        assertLfuCache(c, [1: "1", 2: "2", 3: "3"], [(1, ["3", "2"]), (2, ["1"])])
        c[1] = "4"
        assertLfuCache(c, [1: "4", 2: "2", 3: "3"], [(1, ["3", "2"]), (3, ["4"])])
        _ = c[3]
        assertLfuCache(c, [1: "4", 2: "2", 3: "3"], [(1, ["2"]), (2, ["3"]), (3, ["4"])])
        c[8] = "8"
        assertLfuCache(c, [1: "4", 3: "3", 8: "8"], [(1, ["8"]), (2, ["3"]), (3, ["4"])])
    }

    func testCapacityInitialization() throws {
        let c = LFUCache<Int, String>(capacity: 0)
        XCTAssertTrue(c.capacity > 0)

        let c1 = LFUCache<Int, String>(capacity: -1)
        XCTAssertTrue(c1.capacity > 0)

        let c2 = LFUCache<Int, String>(capacity: 99)
        XCTAssertEqual(c2.capacity, 99)
    }

    func testInitWithSequence() throws {
    }

    static var allTests = [
        ("testBasics", testBasics),
        ("testGet", testGet),
        ("testGet2", testGet2),
        ("testInitWithSequence", testInitWithSequence),
    ]
}
