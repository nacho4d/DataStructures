import XCTest
@testable import DataStructures

final class LinkedListTests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    /// Helper function that iterates a list to check its nodes order and count. Uses an array for comparison reasons
    func assertList<T: Equatable>(_ list: LinkedList<T>, _ array: Array<T>, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        print("Array: \(array)")
        print("Linked: \(list)")
        // check first and value
        XCTAssertEqual(list.first?.value, array.first, "first?.value is incorrect", file: file, line: line)
        XCTAssertNil(list.first?.prev, "first?.prev is incorrect", file: file, line: line)
        XCTAssertEqual(list.last?.value, array.last, "last?.value is incorrect",file: file, line: line)
        XCTAssertNil(list.last?.next, "last?.next is incorrect", file: file, line: line)
        
        // check correctness of next
        var cur: LinkedListNode<T>? = nil
        for (index, elem) in array.enumerated() {
            if index == 0 {
                cur = list.first
            } else {
                cur = cur?.next
            }
            XCTAssertEqual(cur?.value, elem, "Element at \(index) is icorrect (iterating next)", file: file, line: line)
        }
        XCTAssertNil(cur?.next, file: file, line: line)
        
        // check correctness of prev
        for (index, elem) in array.reversed().enumerated() {
            if index == 0 {
                cur = list.last
            } else {
                cur = cur?.prev
            }
            XCTAssertEqual(cur?.value, elem, "Element at \(array.count - index) is incorrect (iterating prev)", file: file, line: line)
        }
        XCTAssertNil(cur?.prev, file: file, line: line)
        
        // check count
        XCTAssertEqual(list.count, array.count)
    }
    
    func testBasics() throws {
        
        let list = LinkedList<Int>()
        XCTAssertEqual(list.count, 0)
        
        let node1 = try XCTUnwrap(list.insertFirst(1))
        assertList(list, [1])
        
        list.remove(node: node1)
        assertList(list, [])
        
        list.append(3)
        assertList(list, [3])
        
        list.append(5)
        assertList(list, [3, 5])
        
        list.append(7)
        assertList(list, [3, 5, 7])
        
        let node5 = try XCTUnwrap(list.findFirst(5))
        assertList(list, [3, 5, 7])
        
        let node6 = try XCTUnwrap(list.insert(6, after: node5))
        assertList(list, [3, 5, 6, 7])
        XCTAssertEqual(node6.value, 6)
        
        let node7 = try XCTUnwrap(list.findFirst(7))
        assertList(list, [3, 5, 6, 7])
        
        let node8 = try XCTUnwrap(list.insert(8, after: node7))
        assertList(list, [3, 5, 6, 7, 8])
        XCTAssertEqual(node8.value, 8)
        
        let node4 = try XCTUnwrap(list.insert(4, before: node5))
        assertList(list, [3, 4, 5, 6, 7, 8])
        XCTAssertEqual(node4.value, 4)
        
        let node3 = try XCTUnwrap(list.findFirst(3))
        assertList(list, [3, 4, 5, 6, 7, 8])
        
        let node2 = try XCTUnwrap(list.insert(2, before: node3))
        assertList(list, [2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(node2.value, 2)
        
        let removedNode4 = try XCTUnwrap(list.remove(4))
        assertList(list, [2, 3, 5, 6, 7, 8])
        XCTAssertEqual(removedNode4.value, 4)
        
        let notFound = list.findFirst(99)
        assertList(list, [2, 3, 5, 6, 7, 8])
        XCTAssertNil(notFound)
        
        let notRemoved = list.remove(99)
        assertList(list, [2, 3, 5, 6, 7, 8])
        XCTAssertNil(notRemoved)
    }
    
    func testFindBackwards() throws {
        let list = LinkedList<Int>()
        list.append(0)
        let node5 = list.append(5)
        list.append(1)
        let node5Back = list.append(5)
        list.append(2)
        let node5Find = try XCTUnwrap(list.findFirst(5))
        let node5BackFind = try XCTUnwrap(list.findLast(5))
        XCTAssertFalse(node5Find === node5BackFind)
        XCTAssertTrue(node5 === node5Find)
        XCTAssertTrue(node5Back === node5BackFind)
    }

    func testRemoveAll() throws {
        let list = LinkedList<Int>()
        list.append(0)
        list.append(5)
        list.append(1)
        list.append(5)
        list.append(2)
        assertList(list, [0, 5, 1, 5, 2])

        list.removeAll()
        assertList(list, [])
    }

    func testContains() throws {
        let list = LinkedList<Int>()
        list.append(0)
        list.append(1)
        list.append(5)
        assertList(list, [0, 1, 5])
        XCTAssertTrue(list.contains(1))
        XCTAssertFalse(list.contains(99))

        let five = try XCTUnwrap(list.findFirst(5))
        XCTAssertEqual(five.value, 5)
        XCTAssertTrue(list.contains(node: five))
    }

    func testInitWithIterable() throws {
        let list = LinkedList(sequence: [1, 2, 3, 4, 5])
        assertList(list, [1, 2, 3, 4, 5])
    }

    func testInitWithLinkedNode() throws {
        let list = LinkedList(sequence: [1, 2, 3, 4, 5])
        assertList(list, [1, 2, 3, 4, 5])
        let list2 = LinkedList(head: list.first!)
        assertList(list2, [1, 2, 3, 4, 5])
    }

    func testLinkedListSequenceProtocolAdopt() throws {
        let list = LinkedList(sequence: [1, 2, 3, 4, 5])

        /// Sequence protocol adoption allows `for in`. Each access complexity is O(1)
        var arr = [1, 2, 3, 4, 5]
        for i in list {
            let expected = arr.remove(at: 0)
            XCTAssertEqual(i, expected)
        }
        /// List should not be modified
        assertList(list, [1, 2, 3, 4, 5])

        /// Sequence protocol adoption allows `filter`. Each access complexity is O(1)
        let impars = list.filter { $0 % 2 == 0 }
        XCTAssertEqual(impars, [2, 4])
        /// List should not be modified
        assertList(list, [1, 2, 3, 4, 5])

        /// Sequence protocol adoption allows `enumerated`. Each access complexity is O(1)
        for (i, e) in list.enumerated() {
            XCTAssertEqual(e, [1, 2, 3, 4, 5][i])
        }
        /// List should not be modified
        assertList(list, [1, 2, 3, 4, 5])

        /// Sequence protocol adoption allows `reversed` too. Array is copied and reversed at initialization hence time complexity is O(n). Each access time complexity is O(1).
        for (i, e) in list.reversed().enumerated() {
            XCTAssertEqual(e, [5, 4, 3, 2, 1][i])
        }
        /// List should not be modified
        assertList(list, [1, 2, 3, 4, 5])
    }

    static var allTests = [
        ("testBasics", testBasics),
        ("testFindBackwards", testFindBackwards),
        ("testInitWithIterable", testInitWithIterable),
        ("testInitWithLinkedNode", testInitWithLinkedNode),
        ("testLinkedListSequenceProtocolAdopt", testLinkedListSequenceProtocolAdopt)
    ]
}
