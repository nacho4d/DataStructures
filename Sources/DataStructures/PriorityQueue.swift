//
//  PriorityQueue.swift
//  DataStructures
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/07/02.
//

import Foundation

/// Priority Queue (Heap) implementation. Represents a first-in, first-out (FIFO) collection of objects. (Based on C# .Net Implementation)
public class PriorityQueue<T> {

    /// Priority queue represented as a balanced binary heap: the two children of `queue[n]` are `queue[2*n+1]` and `queue[2*(n+1)]`.
    /// The priority queue is ordered by comparator. The element with the lowest value is in `queue[0]` or nil if queue is empty.
    internal var queue = Array<T>()

    /// The number of elements in the priority queue.
    public var count: Int = 0

    /// Defines the signature for a block object used for comparison operations.
    public typealias Comparator = (T, T) -> ComparisonResult

    /// The comparator, function to determinate order of elements
    var comparator: Comparator

    public init(comparator: @escaping Comparator) {
        self.comparator = comparator
    }

    public init<S: Sequence>(comparator: @escaping Comparator, sequence: S) where S.Element == T {
        self.comparator = comparator
        for elem in sequence {
            insert(elem)
        }
    }

    /// Reserves enough space to store the specified number of elements.
    ///
    /// - Parameter minimumCapacity: The requested number of elements to store.
    ///
    /// - Complexity: O(*n*), where *n* is the number of elements in the array.
    public func reserveCapacity(_ minimunCapacity: Int) {
        queue.reserveCapacity(minimunCapacity)
    }

    /// Retrieves, but does not remove, the head of this queue, or returns null if this queue is empty.
    public func peek() -> T? {
        if count == 0 {
            return nil
        }
        return queue[0]
    }

    /// Retrieves and removes the head of this queue, or returns null if this queue is empty.
    public func poll() -> T? {
        if count == 0 {
            return nil
        }
        if count == 1 {
            count = 0
            return queue.popLast()
        }
        let i = count - 1
        let res = queue[0]
        queue[0] = queue[i]
        queue.removeLast()
        count -= 1
        siftDown(index: 0)
        return res
    }

    /// Inserts the specified element into this priority queue.
    public func insert(_ element: T) {
        if count == 0 {
            queue.append(element)
            count = 1
            return
        }
        queue.append(element)
        count += 1
        siftUp(index: count - 1)
    }

    /// *Internal* Re-arrange queue to element at `index` to ensure it is smallest. Usually used after removing the smallest
    internal func siftDown(index: Int) {
        if index >= count {
            return
        }
        let index1 = (index << 1) + 1 // index * 2 + 1
        let index2 = (index << 1) + 2 // index * 2 + 1
        let i = queue[index]
        // There are two children
        if index2 < count {
            let n1 = queue[index1]
            let n2 = queue[index2]
            let n1i = comparator(i, n1)
            let n2i = comparator(i, n2)
            if n1i == .orderedDescending && n2i == .orderedDescending {
                // swap to smallest
                if comparator(n1, n2) == .orderedDescending {
                    // swap with right child
                    queue.swapAt(index, index2)
                    siftDown(index: index2)
                } else {
                    // swap with left child
                    queue.swapAt(index, index1)
                    siftDown(index: index1)
                }
            } else if n1i == .orderedDescending {
                // swap with left child
                queue.swapAt(index, index1)
                siftDown(index: index1)
            } else if n2i == .orderedDescending {
                // swap with right child
                queue.swapAt(index, index2)
                siftDown(index: index2)
            }
            return
        }
        // There is only one child
        if index1 < count {
            let n1 = queue[index1]
            let n1i = comparator(i, n1)
            if n1i == .orderedDescending {
                // swap with  left child
                queue.swapAt(index, index1)
                siftDown(index: index1)
            }
        }
    }

    /// *Internal* Re-arrange queue to element at `index`to ensure it is parent/ancestors are not bigger. Usually used after adding elements to queue
    internal func siftUp(index: Int) {
        if index < 0 {
            return
        }
        let i = queue[index]
        let pIndex = (index - 1) >> 1 //  (index - 1) * 2
        if pIndex < 0 {
            return
        }
        let p = queue[pIndex]
        if comparator(p, i) == .orderedDescending {
            queue.swapAt(index, pIndex)
            siftUp(index: pIndex)
            return
        }
    }
}

extension PriorityQueue where T: Comparable {

    public convenience init() {
        self.init(comparator: { lhs , rhs -> ComparisonResult in
            return lhs < rhs ? .orderedAscending: lhs > rhs ? .orderedDescending : .orderedSame
        })
    }

    public convenience init<S: Sequence> (sequence: S) where S.Element == T {
        self.init(comparator: { lhs , rhs -> ComparisonResult in
            return lhs < rhs ? .orderedAscending: lhs > rhs ? .orderedDescending : .orderedSame
        }, sequence: sequence)
    }
}
