class LinkedListNode <T: Comparable>: CustomDebugStringConvertible {
    var value: T
    var next: LinkedListNode<T>?
    weak var prev: LinkedListNode<T>?

    init(_ value: T) {
        self.value = value
        self.next = nil
    }
    
    var debugDescription: String {
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

class LinkedList<T: Comparable>: CustomDebugStringConvertible {

    var first: LinkedListNode<T>? = nil
    var last: LinkedListNode<T>? = nil
    var count = 0

    var debugDescription: String {
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

    /// Designated initializer
    init(head: LinkedListNode<T>? = nil) {
        first = head
        count = first?.countNodes() ?? 0
        last = first?.findLast()
    }

    /// Search node with given value. Return node if found otherwise nil.
    func find(_ value: T) -> LinkedListNode<T>? {
        var cur: LinkedListNode<T>? = first
        while cur != nil && cur?.value != value {
            cur = cur?.next
        }
        return cur
    }

    /// Search node with given value. Return node if found otherwise nil.
    func findBackwards(_ value: T) -> LinkedListNode<T>? {
        var cur: LinkedListNode<T>? = last
        while cur != nil && cur?.value != value {
            cur = cur?.prev
        }
        return cur
    }

    /// Appends a new node. Returns newly inserted node.
    @discardableResult func append(_ value: T) -> LinkedListNode<T>? {
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
    @discardableResult func insertFirst(_ value: T) -> LinkedListNode<T>? {
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
    @discardableResult func insert(_ value: T, after node: LinkedListNode<T>) -> LinkedListNode<T> {
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
    @discardableResult func insert(_ value: T, before node: LinkedListNode<T>) -> LinkedListNode<T> {
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
    @discardableResult func remove(_ value: T) -> LinkedListNode<T>? {
        if let node = find(value) {
            remove(node: node)
            return node
        }
        return nil
    }

    /// Removes given node.
    func remove(node: LinkedListNode<T>) {
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
