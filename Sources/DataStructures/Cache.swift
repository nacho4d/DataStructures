//
//  Cache.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/07/15.
//

import Foundation

/// Node that holds value of Objects in LFUCache.
final class LFUNode<K, T>: LinkedListNode {
    typealias Value = T
    var value: T // Value of object  in LFUCache
    var next: LFUNode<K, T>?
    weak var prev: LFUNode<K, T>?
    required init(value: T) { self.value = value }
    /// Weak reference to FrequencyNode
    weak var frequencyNode: FrequencyNode<K, T>!
    var key: K!
}

/// Node that holds frequency and a linked list of LFUNodes with objects
final class FrequencyNode<K, T>: LinkedListNode {
    typealias Value = Int
    var value: Int // frequency
    var next: FrequencyNode<K, T>?
    weak var prev: FrequencyNode<K, T>?
    required init(value: Int) { self.value = value }
    /// Strong reference to LFUNodes
    var nodes = BasicLinkedList<LFUNode<K, T>>()
}

/// Cache implementation. [O(1) implementation for LFU cache eviction scheme](http://dhruvbird.com/lfu.pdf)
///
///  Algorithm is based on a Dictionary<Key, Value> to O1 access and a Doubly Linked List of nodes with frequencies (1, 3, 4, 7,...) and each with a linked list of nodes with the values (a, b, c, .... z) to achieve high performance eviction.
///
///  ```
///     1 ⇄ 3 ⇄ 4 ⇄ 7
///     a   b   n   y
///     ⇅   ⇅       ⇅
///     c   l       x
///     ⇅           ⇅
///     m           z
///  ```
/// - Authors: Paper authors are Prof. Ketan Shah Anirban Mitra Dhruv Matani.
/// - :
public class LFUCache<Key: Hashable, Value> {

    var nodes =  [Key: LFUNode<Key, Value>]()
    var frequencies = BasicLinkedList<FrequencyNode<Key, Value>>()

    var count = 0
    public internal(set) var capacity = 8

    init(capacity: Int = 8) {
        self.capacity = capacity
    }

    /// Increase frequency of given node .
    ///
    /// Steps
    /// 1. Check next frequency node and create a new node if its frequency is not current frequency + 1
    /// 2. Move given node to nodes of next frequency node
    /// 3. If nodes of previous frequency node is empty then remove the frequency node itself
    internal func increaseFrequency(ofNode node: LFUNode<Key, Value>) {
        let newFrequency = node.frequencyNode.value + 1
        // 1. Create a new frequency node if its next frequency is not the expected one
        if node.frequencyNode.next?.value != newFrequency {
            let newFrequencyNode = FrequencyNode<Key, Value>(value: newFrequency)
            frequencies.insert(node: newFrequencyNode, after: node.frequencyNode)
        }
        // 2. Move node from current to next list
        node.frequencyNode.nodes.remove(node: node)
        node.frequencyNode.next?.nodes.insertFirst(node: node)
        node.frequencyNode = node.frequencyNode.next
        // 3. Remove previous frequency node if its list is empty
        if let frequencyNodePrev = node.frequencyNode.prev, frequencyNodePrev.nodes.first == nil {
            frequencies.remove(node: frequencyNodePrev)
        }
    }


    /// Access value for the given key
    public func value(forKey key: Key) -> Value? {
        guard let node = nodes[key] else {
            return nil
        }
        increaseFrequency(ofNode: node)
        return node.value
    }

    /// Remove key-value pair from cache
    @discardableResult public func removeValue(forKey key: Key) -> Value? {
        if let node = nodes[key] {
            nodes[key] = nil
            let nodes = node.frequencyNode.nodes
            node.frequencyNode.nodes.remove(node: node)
            if nodes.first == nil {
                frequencies.remove(node: node.frequencyNode)
            }
            count -= 1
            return node.value
        }
        return nil
    }

    /// Updates the value stored in the cache for the given key, or adds a new key-value pair if the key does not exist.
    /// - Returns: The value that was replaced, or nil if a new key-value pair was added.
    @discardableResult public func updateValue(_ value: Value, forKey key: Key) -> Value? {
        if let node = nodes[key] {
            // Node was found so update the value
            let oldValue = node.value
            node.value = value
            increaseFrequency(ofNode: node)
            return oldValue
        } else {
            // Insert new node
            let node = LFUNode<Key, Value>(value: value)
            node.key = key
            nodes[key] = node
            if count >= capacity {
                // There is no more capacity: Delete least recently used object
                if let last = frequencies.first?.nodes.last {
                    nodes[last.key] = nil
                    frequencies.first?.nodes.remove(node: last)
                }
                if frequencies.first != nil && frequencies.first!.nodes.first == nil {
                    frequencies.remove(node: frequencies.first!)
                }
                count -= 1
            }
            // Insert node (create a new frequency node if needed)
            if frequencies.first?.value != 1 {
                frequencies.insertFirst(node: FrequencyNode<Key, Value>(value: 1))
            }
            node.frequencyNode = frequencies.first!
            frequencies.first!.nodes.insertFirst(node: node)
            count += 1
            return nil
        }
    }

    // MARK: Subscripts
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

