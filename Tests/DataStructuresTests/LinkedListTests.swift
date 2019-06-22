import XCTest
@testable import DataStructures

final class LinkedListTests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }
    
    func assertList<T>(_ list: LinkedList<T>, _ array: [T], _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
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
        
        let node5 = try XCTUnwrap(list.find(5))
        assertList(list, [3, 5, 7])
        
        let node6 = try XCTUnwrap(list.insert(6, after: node5))
        assertList(list, [3, 5, 6, 7])
        XCTAssertEqual(node6.value, 6)
        
        let node7 = try XCTUnwrap(list.find(7))
        assertList(list, [3, 5, 6, 7])
        
        let node8 = try XCTUnwrap(list.insert(8, after: node7))
        assertList(list, [3, 5, 6, 7, 8])
        XCTAssertEqual(node8.value, 8)
        
        let node4 = try XCTUnwrap(list.insert(4, before: node5))
        assertList(list, [3, 4, 5, 6, 7, 8])
        XCTAssertEqual(node4.value, 4)
        
        let node3 = try XCTUnwrap(list.find(3))
        assertList(list, [3, 4, 5, 6, 7, 8])
        
        let node2 = try XCTUnwrap(list.insert(2, before: node3))
        assertList(list, [2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(node2.value, 2)
        
        let removedNode4 = try XCTUnwrap(list.remove(4))
        assertList(list, [2, 3, 5, 6, 7, 8])
        XCTAssertEqual(removedNode4.value, 4)
        
        let notFound = list.find(99)
        XCTAssertNil(notFound)
        
        let notRemoved = list.remove(99)
        XCTAssertNil(notFound)
    }
    
    func testFindBackwards() throws {
        let list = LinkedList<Int>()
        list.append(0)
        let node5 = list.append(5)
        list.append(1)
        let node5Back = list.append(5)
        list.append(2)
        let node5Find = try XCTUnwrap(list.find(5))
        let node5BackFind = try XCTUnwrap(list.findBackwards(5))
        XCTAssertFalse(node5Find === node5BackFind)
        XCTAssertTrue(node5 === node5Find)
        XCTAssertTrue(node5Back === node5BackFind)
    }

    static var allTests = [
        ("testBasics", testBasics),
        ("testFindBackwards", testFindBackwards)
    ]
}
