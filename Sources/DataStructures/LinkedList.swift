//
//  LinkedList.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/24.
//

/// Node implementation for two way linked list. Container for objects of type T.
public class LinkedListNode <T: Comparable>: CustomDebugStringConvertible {

    /// Value contained in this node
    public var value: T

    /// Strong reference to next element
    public var next: LinkedListNode<T>?

    /// Weak reference to prev element
    public weak var prev: LinkedListNode<T>?

    /// Designated initializer. Nodes are created internally by LinkedList objects.
    internal init(_ value: T) {
        self.value = value
        self.next = nil
    }

    /// A textual representation of the array and its elements, suitable for debugging.
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
    #if DEBUG
    func countNodes() -> Int {
        var res = 0
        var cur: LinkedListNode<T>? = self
        while cur != nil {
            cur = cur?.next
            res += 1
        }
        return res
    }
    
    func findLast() -> LinkedListNode<T> {
        var cur: LinkedListNode<T> = self
        while cur.next != nil {
            cur = cur.next!
        }
        return cur
    }
    #endif
}

/// Linked List implementation. Represents a doubly linked list.
public class LinkedList<T: Comparable>: CustomDebugStringConvertible {

    /// First element (head) in the list
    public var first: LinkedListNode<T>? = nil

    /// Last element (tail) in the list
    public var last: LinkedListNode<T>? = nil

    /// The number of elements in the list
    public var count = 0

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

    /// Designated initializer. Creates a new instance of a list. If `head` is given it will be the head.
    public init(head: LinkedListNode<T>? = nil) {
        first = head
        count = first?.countNodes() ?? 0
        last = first?.findLast()
    }

    /// Search node with given value. Return node if found otherwise nil.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    public func find(_ value: T) -> LinkedListNode<T>? {
        var cur: LinkedListNode<T>? = first
        while cur != nil && cur?.value != value {
            cur = cur?.next
        }
        return cur
    }

    /// Search node with given value. Return node if found otherwise nil.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    public func findBackwards(_ value: T) -> LinkedListNode<T>? {
        var cur: LinkedListNode<T>? = last
        while cur != nil && cur?.value != value {
            cur = cur?.prev
        }
        return cur
    }

    /// Appends a new node. Returns newly inserted node.
    /// - Complexity: O(1).
    @discardableResult public func append(_ value: T) -> LinkedListNode<T>? {
        let new = LinkedListNode(value)
        new.prev = last
        last?.next = new
        count += 1
        last = new
        if first == nil {
            first = new
        }
        return new
    }

    /// Appends a new node. Returns newly inserted node.
    /// - Complexity: O(1).
    @discardableResult public func insertFirst(_ value: T) -> LinkedListNode<T>? {
        let new = LinkedListNode(value)
        new.next = first
        first?.prev = new
        count += 1
        first = new
        if last == nil {
            last = new
        }
        return new
    }

    /// Inserts a new node with given value after given node. Returns newly inserted node.
    /// - Complexity: O(1).
    @discardableResult public func insert(_ value: T, after node: LinkedListNode<T>) -> LinkedListNode<T> {
        let new = LinkedListNode(value)
        new.prev = node
        new.next = node.next
        new.next?.prev = new
        node.next = new
        count += 1
        if node === last || last == nil {
            last = new
        }
        return new
    }

    /// Inserts a new node with given value before given node. Returns newly inserted node.
    /// - Complexity: O(1).
    @discardableResult public func insert(_ value: T, before node: LinkedListNode<T>) -> LinkedListNode<T> {
        let new = LinkedListNode(value)
        new.prev = node.prev
        new.prev?.next = new
        new.next = node
        new.next?.prev = new
        count += 1
        if node === first {
            first = new
        }
        return new
    }

    /// Removes node with given value. Returns removed node.
    /// - Parameters
    ///   - value: A linked node to remove
    /// - Complexity: O(1).
    @discardableResult public func remove(_ value: T) -> LinkedListNode<T>? {
        if let node = find(value) {
            remove(node: node)
            return node
        }
        return nil
    }

    /// Removes given node.
    /// - Complexity: O(1).
    public func remove(node: LinkedListNode<T>) {
        node.next?.prev = node.prev
        node.prev?.next = node.next
        count -= 1
        if node === first {
            first = first?.next
        }
        if node === last {
            last = last?.prev
        }
    }

    /// Removes all objects from the list
    /// - Complexity: O(1).
    public func removeAll() {
        first = nil
        last = nil
        count = 0
    }

    /// Searchs value and return yes if found otherwise no.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    public func contains(_ value: T) -> Bool {
        return find(value) != nil
    }

    /// Search self for insertion position of given linked node and inserts it.
    /// - Parameters
    ///  - node: A linked node to insert.
    func insert(_ node: LinkedListNode<T>, evaluate: ((T) -> Bool)) {
        // search position
        var cur: LinkedListNode<T>? = first
        while cur != nil && !evaluate(cur!.value) {
            cur = cur?.next
        }
        // insert
        node.next = cur?.next
        cur?.next = node
        if first == nil {
            first = node
        }
        count += 1
    }

    /// Same as insert(_ node: LinkedNode)
    func insert(nodeWithValue value: T, evaluate: ((T) -> Bool)) {
        insert(LinkedListNode(value), evaluate: evaluate)
    }
}
