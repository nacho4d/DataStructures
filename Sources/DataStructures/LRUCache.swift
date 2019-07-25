//
//  LRUCache.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/07/26.
//

import Foundation

/// Node that holds value of Objects in LRUCache.
final class LRUNode<K, T>: LinkedListNode {
    typealias Value = T
    var value: T // Value of object  in LRUCache
    var next: LRUNode<K, T>?
    weak var prev: LRUNode<K, T>?
    required init(value: T) { self.value = value }
    var key: K!
}

/// Least Recenly Used Eviction Cache implementation. O(1) implementation for LRU cache eviction scheme. Implementation is based on [Sammie Bae, JavaScript Data Structures and Algorithms - Chapter 14](https://www.apress.com/gp/book/9781484239872)
public class LRUCache<Key: Hashable, Value> {

    /// Internal storage. Dictionary to get access in O(1)
    var storage =  [Key: LRUNode<Key, Value>]()

    /// Internal storage. Linked List to achieve time complexity O(1) when evicting least recently used item
    var nodes = BasicLinkedList<LRUNode<Key, Value>>()

    /// The number of key-value pairs in the cache.
    public var count: Int {
        return storage.count
    }

    /// Maximun size of internal storage. Capacity is always bigger than 0. Default is 8
    public let capacity: Int

    /// Designed initializer. Creates an empty cache that will store at most the given number of elements.
    init(capacity: Int = 8) {
        if capacity > 0 {
            self.capacity = capacity
        } else {
            self.capacity = 8
            print("Capacity must be bigger than 0. Not applying given value \(capacity)")
        }
    }

    // MARK: -

    /// Returns the value associated with a given key
    /// - Parameters:
    ///   - key: The key for which to return the corresponding value
    public func value(forKey key: Key) -> Value? {
        guard let node = storage[key] else {
            return nil
        }
        /// Move node to the tail
        nodes.remove(node: node)
        nodes.append(node: node)
        return node.value
    }

    /// Remove key-value pair from cache
    /// - Parameters:
    ///   - key: The key for which to delete the corresponding value
    @discardableResult public func removeValue(forKey key: Key) -> Value? {
        if let node = storage[key] {
            storage[key] = nil
            nodes.remove(node: node)
            return node.value
        }
        return nil
    }

    /// Updates the value stored in the cache for the given key, or adds a new key-value pair if the key does not exist.
    /// - Parameters:
    ///   - value: The value to update
    ///   - key: The key for which to update the corresponding value
    /// - Returns: The value that was replaced, or nil if a new key-value pair was added.
    @discardableResult public func updateValue(_ value: Value, forKey key: Key) -> Value? {
        if let node = storage[key] {
            // Node was found so move node to the tail
            let oldValue = node.value
            node.value = value
            nodes.remove(node: node)
            nodes.append(node: node)
            return oldValue
        }
        // Insert new node
        let node = LRUNode<Key, Value>(value: value)
        node.key = key
        storage[key] = node
        if count > capacity {
            // There is no more capacity: Delete least recently used object
            if let first = nodes.first {
                nodes.remove(node: first)
                storage.removeValue(forKey: first.key)
            }
        }
        // Insert node
        nodes.append(node: node)
        storage[key] = node
        return nil
    }

    // MARK: Subscripts

    /// Accesses the value associated with the given key for reading and writing.
    /// - Parameters:
    ///   - key: The key to find in the cache.
    public subscript(key: Key) -> Value? {
        get {
            // Get value for given key
            value(forKey: key)
        }
        set {
            guard let value = newValue else {
                // If value is nil then remove key-value pair
                removeValue(forKey: key)
                return
            }
            // Update or insert new key-value pair
            updateValue(value, forKey: key)
        }
    }
}

extension LRUCache: Sequence {
    /// Iterator implementation
    public class Iterator<Key, Value>: IteratorProtocol {
        var cur: LRUNode<Key, Value>?

        /// IteratorProtocol protocol requirement
        public func next() -> (key: Key, value: Value)? {
            let v = cur?.value
            let k = cur?.key
            cur = cur?.next
            return v != nil && k != nil ? (k!, v!) : nil
        }
    }

    /// Sequence protocol requirement
    public func makeIterator() -> Iterator<Key, Value> {
        let g = LRUCache.Iterator()
        g.cur = nodes.first
        return g
    }
}

