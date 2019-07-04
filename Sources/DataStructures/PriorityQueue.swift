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
    public internal(set) var comparator: Comparator

    /// Designated initializator. Initialize queue with given comparator
    public init(comparator: @escaping Comparator) {
        self.comparator = comparator
    }

    /// Designated initializator. Initialize queue with given comparator and add elements from given `sequence`
    /// - Parameters:
    ///   - sequence: sequence containing elements to add to queue.
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
        queue.siftDown(index: 0, count: count, comparator: comparator)
        return res
    }

    /// Inserts the specified element into this priority queue.
    public func insert(_ element: T) {
        // Do not use `queue.append(element)` so this function can be used for in-place sorting
        queue.insert(element, at: count)
        count += 1
        queue.siftUp(index: count - 1, comparator: comparator)
    }
}

extension Array {
    /// *[Internal]* Re-arrange queue. Starting with element at `index` and recursively its children nodes to ensure relation given by `comparator` is always meet. Used after removing elements from queue.
    /// - Parameters:
    ///     - index: start index. Function will recursively look at children nodes too.
    ///     - count: length of array. Usually this will be the Array.count however when using in-place heap sort it is used to constrain sift operation to some range.
    /// - Complexity: O(log *n*) where *n* is the length of the array (in this case it would be parameter `count` because array might be constrained)
    internal mutating func siftDown(index: Int, count: Index, comparator: PriorityQueue<Element>.Comparator) {
        if index >= count {
            return
        }
        let index1 = (index << 1) + 1 // index * 2 + 1
        let index2 = (index << 1) + 2 // index * 2 + 1
        let i = self[index]
        // There are two children
        if index2 < count {
            let n1 = self[index1]
            let n2 = self[index2]
            let n1i = comparator(i, n1)
            let n2i = comparator(i, n2)
            if n1i == .orderedDescending && n2i == .orderedDescending {
                // swap to smallest
                if comparator(n1, n2) == .orderedDescending {
                    // swap with right child
                    self.swapAt(index, index2)
                    siftDown(index: index2, count: count, comparator: comparator)
                } else {
                    // swap with left child
                    self.swapAt(index, index1)
                    siftDown(index: index1, count: count, comparator: comparator)
                }
            } else if n1i == .orderedDescending {
                // swap with left child
                self.swapAt(index, index1)
                siftDown(index: index1, count: count, comparator: comparator)
            } else if n2i == .orderedDescending {
                // swap with right child
                self.swapAt(index, index2)
                siftDown(index: index2, count: count, comparator: comparator)
            }
            return
        }
        // There is only one child
        if index1 < count {
            let n1 = self[index1]
            let n1i = comparator(i, n1)
            if n1i == .orderedDescending {
                // swap with  left child
                self.swapAt(index, index1)
                siftDown(index: index1, count: count, comparator: comparator)
            }
        }
    }

    /// *[Internal]* Re-arrange queue starting with element at `index`and recursively do its parents/ancestors too to ensure relation given by `comparator`is always meet. Used after adding elements to queue
    /// - Parameters:
    ///   - index: start index. Function will recursively look at parent/ancestor nodes too.
    ///   - comparator: comparator, function to determinate order of elements. Default implementation uses a min heap so comparator result is inverted.
    /// - Complexity: O(log *n*) where *n* is the length of the array.
    internal mutating func siftUp(index: Int, comparator: PriorityQueue<Element>.Comparator) {
        if index < 0 {
            return
        }
        let pIndex = (index - 1) >> 1 //  (index - 1) * 2
        if pIndex < 0 {
            return
        }
        let i = self[index]
        let p = self[pIndex]
        if comparator(p, i) == .orderedDescending {
            self.swapAt(index, pIndex)
            siftUp(index: pIndex, comparator: comparator)
            return
        }
    }
}

extension PriorityQueue where T: Comparable {

    /// Designated initializator. Initialize queue with a comparator using `<` and `>` operators
    /// - Note: Available when `T` conforms to `Comparable`
    public convenience init() {
        self.init(comparator: { lhs , rhs -> ComparisonResult in
            return lhs < rhs ? .orderedAscending: lhs > rhs ? .orderedDescending : .orderedSame
        })
    }

    /// Designated initializator. Initialize queue with a comparator using `<` and `>` operators and add elements in given `sequence`
    /// - Note: Available when `T` conforms to `Comparable`
    public convenience init<S: Sequence> (sequence: S) where S.Element == T {
        self.init(comparator: { lhs , rhs -> ComparisonResult in
            return lhs < rhs ? .orderedAscending: lhs > rhs ? .orderedDescending : .orderedSame
        }, sequence: sequence)
    }
}
