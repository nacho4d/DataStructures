//
//  LinkedList.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/24.
//

/// Linked List Node protocol. Used by Linked List implementation.
/// - Note:
/// If you need to extend a node consider the following basic implementation:
/// ```
///     final class MyNode<T>: LinkedListNode {
///         typealias Value = T
///         public var value: T
///         public var next: MyNode<T>?
///         public weak var prev: MyNode<T>?
///         required init(value: T) { self.value = value }
///     }
///  ```
public protocol LinkedListNode: class {
    /// Type of element holded by node
    associatedtype Value
    /// Element holded by node
    var value: Value {get set}
    /// Reference to next element.
    /// - Note:
    /// `next` should not be changed by clients. Setter is for LinkedList interal use only. Changing value leads to undefined behaviour
    var next: Self? {get set}
    /// Reference to prev element. To avoid retain cycles. This should be defined as weak. See `BasicLinkedListNode`
    /// - Note:
    /// `next` should not be changed by clients. Setter is for LinkedList interal use only. Changing value leads to undefined behaviour
    var prev: Self? {get set}
    /// Designated initializer.
    /// - Note:
    /// Nodes are created internally by Linked List objects. Clients should not need to create Node objects by themselves unless implementing a custom node class
    init(value: Value)
}

/// Default methods
extension LinkedListNode {
    /// Internal method. A textual representation of the array and its elements, suitable for debugging.
    public var debugDescription: String {
        var desc: String = ""
        if let p = prev {
            desc += "\(p.value)"
        } else {
            desc += "nil"
        }
        desc += "<-\(value)->"
        if let n = next {
            desc += "\(n.value)"
        } else {
            desc += "nil"
        }
        return desc
    }

    /// Internal method. Count all subnodes and return last node which could be self
    func countNodesAndFindLast() -> (Int, Self) {
        var res = 1
        var cur: Self = self
        while cur.next != nil {
            cur = cur.next!
            res += 1
        }
        return (res, cur)
    }
}

/// Node implementation for two way linked list. Container for objects of type T. (Based on C# .Net Implementation)
final public class BasicLinkedListNode<T>: LinkedListNode {

    /// Value contained in this node
    public typealias Value = T

    /// Strong reference to next element.
    public var value: T

    /// Weak reference to prev element
    /// - Note:
    /// `next` should not be changed by clients. Setter is for LinkedList interal use only. Changing value leads to undefined behaviour
    public var next: BasicLinkedListNode<T>?

    /// Designated initializer. Nodes are created internally by LinkedList objects.
    /// - Note:
    /// `prev` should not be changed by clients. Setter is for LinkedList interal use only. Changing value leads to undefined behaviour.
    /// - Warning:
    ///  `prev` is defined as weak to avoid retain cycles. Other custom implementations of `LinkedListNode` should also declare `prev` as `weak`.
    public weak var prev: BasicLinkedListNode<T>?

    /// Designated initializer. Nodes are created internally by Linked List objects.
    public required init(value: T) {
        self.value = value
    }
}

/// Doubly linked list implementation. Represents a doubly linked list which uses a generic object as a nodes. Refer to `LinkedList` class which uses the basic `BasicLinkedListNode` as node which should fulfil common cases.
public class BasicLinkedList<Node: LinkedListNode> {

    /// First element (head) in the list
    public var first: Node? = nil

    /// Last element (tail) in the list
    public var last: Node? = nil

    /// The number of elements in the list
    public var count = 0

    /// Designated initializer. Creates a new instance of a list. If `head` is given it will be the head.
    public init(head: Node? = nil) {
        first = head
        if let f = first {
            (count, last) = f.countNodesAndFindLast()
        } else {
            count = 0
            last = first
        }
    }

    /// Designated initializer. Creates a new instance of a list and add elements from `sequence`.
    /// - Parameters:
    ///   - sequence: sequence containing elements to add to linked list.
    public init<S: Sequence>(sequence: S) where S.Element == Node.Value {
        first = nil
        last = nil
        for e in sequence {
            append(e)
        }
    }

    // MARK: - Iterating and searching

    /// Search node that matches given predicate. Return node if found otherwise nil.
    /// - Parameters
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
    public func findFirst(where predicate: ((Node.Value) -> Bool)) -> Node? {
        var cur: Node? = first
        while cur != nil && !predicate(cur!.value) {
            cur = cur?.next
        }
        return cur
    }

    /// Search node that matches given predicate starting from the end. Return node if found otherwise nil.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    public func findLast(where predicate: ((Node.Value) -> Bool)) -> Node? {
        var cur: Node? = last
        while cur != nil && !predicate(cur!.value) {
            cur = cur?.prev
        }
        return cur
    }

    /// Searchs value and return yes if found otherwise no.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    public func contains(node: Node) -> Bool {
        var cur: Node? = first
        while cur != nil && cur !== node {
            cur = cur?.next
        }
        return cur === node
    }

    // MARK: - Inserting at head or tail

    /// Appends given node.
    /// - Complexity: O(1).
    public func append(node: Node) {
        node.prev = last
        last?.next = node
        count += 1
        last = node
        if first == nil {
            first = node
        }
    }
    /// Appends a new node. Returns newly inserted node.
    /// - Complexity: O(1).
    @discardableResult public func append(_ value: Node.Value) -> Node? {
        let new = Node(value: value)
        append(node: new)
        return new
    }

    /// Insert given node at the beggining.
    /// - Complexity: O(1).
    public func insertFirst(node: Node) {
        first?.prev?.next = node
        node.next = first
        node.prev = first?.prev
        first?.prev = node
        first = node
        if last == nil {
            last = node
        }
        count += 1
    }

    /// Insert a new node at the beggining. Returns newly inserted node.
    /// - Complexity: O(1).
    @discardableResult public func insertFirst(_ value: Node.Value) -> Node? {
        let new = Node(value: value)
        insertFirst(node: new)
        return new
    }

    // MARK: - Inserting

    /// Inserts a given node after a node.
    /// - Complexity: O(1).
    public func insert(node nodeToInsert: Node, after node: Node) {
        node.next?.prev = nodeToInsert
        nodeToInsert.prev = node
        nodeToInsert.next = node.next
        node.next = nodeToInsert
        if node === last || last == nil {
            last = nodeToInsert
        }
        count += 1
    }

    /// Inserts a new node with given value after given node. Returns newly inserted node.
    /// - Complexity: O(1).
    @discardableResult public func insert(_ value: Node.Value, after node: Node) -> Node {
        let new = Node(value: value)
        insert(node: new, after: node)
        return new
    }

    /// Inserts given node before another given node.
    public func insert(node nodeToInsert: Node, before node: Node) {
        node.prev?.next = nodeToInsert
        nodeToInsert.next = node
        nodeToInsert.prev = node.prev
        node.prev = nodeToInsert
        if node === first {
            first = nodeToInsert
        }
        count += 1
    }

    /// Inserts a new node with given value before given node. Returns newly inserted node.
    /// - Complexity: O(1).
    @discardableResult public func insert(_ value: Node.Value, before node: Node) -> Node {
        let new = Node(value: value)
        insert(node: new, before: node)
        return new
    }

    // MARK: - Removing

    /// Removes given node.
    /// - Complexity: O(1).
    public func remove(node: Node) {
        if node === first {
            first = first?.next
        }
        if node === last {
            last = last?.prev
        }
        node.next?.prev = node.prev
        node.prev?.next = node.next
        node.next = nil
        node.prev = nil
        count -= 1
    }

    /// Removes all objects from the list
    /// - Complexity: O(1).
    public func removeAll() {
        first = nil
        last = nil
        count = 0
    }

//    /// Search self for insertion position of given linked node and inserts it. This method has been removed. Please use `findFirst()` or `findLast()` to find insert position  and then `insert(_:before:)` or `insert(_:after:)`to really insert it.
//    /// - Parameters
//    ///  - node: A linked node to insert.
//    func insert(_ node: LinkedListNode<T>, evaluate: ((T) -> Bool)) {
//        // search position
//        var cur: LinkedListNode<T>? = first
//        while cur != nil && !evaluate(cur!.value) {
//            cur = cur?.next
//        }
//        // insert
//        node.next = cur?.next
//        cur?.next = node
//        if first == nil {
//            first = node
//        }
//        count += 1
//    }
//
//    /// Same as insert(_ node: LinkedNode). This method has been removed. Please use `findFirst()` or `findLast()` to find insert position  and then `insert(_:before:)` or `insert(_:after:)`to really insert it.
//    func insert(nodeWithValue value: T, evaluate: ((T) -> Bool)) {
//        insert(LinkedListNode(value), evaluate: evaluate)
//    }
}

extension BasicLinkedList where Node.Value: Equatable {

    /// Searchs value and return yes if found otherwise no.
    /// - Parameters:
    ///   - value: A value to search/compare
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    /// - Note: Available when `T` conforms to `Equatable`
    public func contains(_ value: Node.Value) -> Bool {
        return findFirst(where: { $0 == value }) != nil
    }

    /// Search node with given value. Return node if found otherwise nil.
    /// - Parameters:
    ///   - value: A value to search
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    /// - Note: Available when `T` conforms to `Equatable`
    public func findFirst(_ value: Node.Value) -> Node? {
        return findFirst(where: { $0 == value })
    }

    /// Search node with given value. Return node if found otherwise nil.
    /// - Parameters
    ///   - value: A value to search
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    /// - Note: Available when `T` conforms to `Equatable`
    public func findLast(_ value: Node.Value) -> Node? {
        return findLast(where: { $0 == value })
    }

    /// Removes node with given value. Returns removed node.
    /// - Parameters
    ///   - value: A linked node to remove
    /// - Complexity: O(1).
    /// - Note: Available when `T` conforms to `Equatable`
    @discardableResult public func remove(_ value: Node.Value) -> Node? {
        if let node = findFirst(value) {
            remove(node: node)
            return node
        }
        return nil
    }


}

extension BasicLinkedList: CustomDebugStringConvertible {
    /// A textual representation of the array and its elements, suitable for debugging.
    public var debugDescription: String {
        var cur = first
        var descs = [String]()
        while cur != nil {
            descs.append(cur!.debugDescription)
            cur = cur?.next
        }
        var descs2 = [String]()
        cur = last
        while cur != nil {
            descs2.insert(cur!.debugDescription, at: 0)
            cur = cur?.prev
        }
        return "First: \(first == nil ? "nil": first!.debugDescription)\nLast: \(last == nil ? "nil": last!.debugDescription)\nNexts: \(descs.joined(separator: ", "))\nPrevs: \(descs.joined(separator: ", "))\nCount: \(count)"
    }
}

/// Sequence protocol adoption. It allows `for ... in` and a bunch of other methods too.
extension BasicLinkedList: Sequence {

    /// Iterator implementation
    public class It<T>: IteratorProtocol { // This used to be Iterator<T> but leads to compiler error: "invalid redeclaration of 'Iterator'"
        var cur: Node?

        /// IteratorProtocol protocol requirement
        public func next() -> Node.Value? {
            let res = cur?.value
            cur = cur?.next
            return res
        }
    }

    /// Sequence protocol requirement
    public func makeIterator() -> It<Node.Value> {
        let g = BasicLinkedList.Iterator()
        g.cur = first
        return g
    }
}

/// Doubly linked list implementation that uses default `BasicLinkedList` node.
/// - Note:
/// If you need to use a linked list with a custom node object Refer to protocl `LinkedListNode`, implement it and use  `BasicLinkedList` with your class.
/// If you need to customize the list itself then BasicLinkedList can be subclassed too.
public class LinkedList<T>: BasicLinkedList<BasicLinkedListNode<T>> {
}
