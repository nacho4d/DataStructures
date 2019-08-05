//
//  Sort.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/25.
//

import Foundation

extension Array {

    /// Heap Sort implementaion. Heap Sort is a comparison algorithm. It makes a heap from input array then returns a sorted array by extracting element one by one.
    /// - Complexity: Time complexity O(*n* log *n*). Sift operations take O(log *n*) and they are needed *n* times. Space Complexity O(1).
    /// - Note: This is an in-place sort
    public mutating func sortHeap(by compare: PriorityQueue<Element>.Comparator) {
        // Invert comparator so a MAX heap is built.
        // Extracted objects will stored at the right in the opposite order. So inverting the comparator will lead to expected sort order
        let comparator: PriorityQueue<Element>.Comparator = { a, b in
            let c = compare(a, b)
            return c == .orderedAscending ? .orderedDescending : c == .orderedDescending ? .orderedAscending : .orderedSame
        }
        // Build heap at left of self (in place)
        for i in 0..<count {
            siftUp(index: i, comparator: comparator)
        }
        // Extract each element into the right of self (in place) and re-build heap
        for i in 0..<count {
            swapAt(count - 1 - i, 0)
            siftDown(index: 0, count: count - 1 - i, comparator: comparator)
        }
    }

}

extension Array where Element: Comparable {

    /// Heap sort implementation with default comparator using `<` and `>`. Convenience method
    /// - Note: Available when `T` conforms to `Comparable`
    public mutating func sortHeap() {
        sortHeap { return $0 > $1 ? .orderedDescending : $0 < $1 ? .orderedAscending : .orderedSame }
    }
}
