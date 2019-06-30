
import XCTest
@testable import DataStructures

final class StackTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func testBasics() throws {
        let stack = Stack<Int>()
        // Test empty
        XCTAssertEqual(stack.count, 0)
        XCTAssertNil(stack.peek())

        // Test push
        stack.push(1)
        XCTAssertEqual(stack.count, 1)
        XCTAssertEqual(stack.peek(), 1)

        // Test contains
        XCTAssertFalse(stack.contains(0))
        XCTAssertTrue(stack.contains(1))
        XCTAssertFalse(stack.contains(2))

        // Test push again
        stack.push(2)
        XCTAssertEqual(stack.count, 2)
        XCTAssertEqual(stack.peek(), 2)

        // Test pop
        XCTAssertEqual(stack.pop(), 2)
        XCTAssertEqual(stack.count, 1)
        XCTAssertEqual(stack.peek(), 1)

        // Test pop again
        XCTAssertEqual(stack.pop(), 1)
        XCTAssertEqual(stack.count, 0)
        XCTAssertNil(stack.peek())

        // Test removeAll
        stack.push(4)
        stack.push(5)
        XCTAssertEqual(stack.count, 2)
        stack.removeAll()
        XCTAssertEqual(stack.count, 0)
    }

    func testInitWithSequence() throws {
        let stack = Stack(sequence: [1, 3, 5, 7])
        XCTAssertEqual(stack.pop(), 7)
        XCTAssertEqual(stack.pop(), 5)
        XCTAssertEqual(stack.pop(), 3)
        XCTAssertEqual(stack.pop(), 1)
        XCTAssertNil(stack.pop())
    }

    static var allTests = [
        ("testBasics", testBasics),
    ]
}
