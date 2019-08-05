//
//  Sort.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/25.
//

import Foundation

extension Array {

    /// Merge Sort implementaion. Merge Sort is a Divide and Conquer algorithm. It divides input array in two halves, calls itself for the two halves and then merges the two sorted halves
    /// - Complexity: Time complexity for all 3 cases (worst, average and best) is O(*n* log *n*) as merge sort always divides the array in two halves and take linear time to merge two halves
    /// - Note: This is NOT an in-place sort
    public mutating func sortMerge(by compare: Comparator) {
        if count < 2 {
            return
        }
        __sortMerge(low: 0, high: count - 1, compare: compare)
    }

    mutating func __sortMerge(low: Int, high: Int, compare: Comparator) {
        if (low < high) {
            var store = self
            let mid = (low + high) / 2
            __sortMerge(low: low, high: mid, compare: compare)
            __sortMerge(low: mid + 1, high: high, compare: compare)
            __sortMerging(low: low, mid: mid, high: high, compare: compare, store: &store)
        } else {
            return
        }
    }

    mutating func __sortMerging(low: Int, mid: Int, high: Int, compare: Comparator, store b: inout Array) {
        var l1 = low
        var l2 = mid + 1
        var i = low
        while l1 <= mid && l2 <= high {
            if compare(self[l1], self[l2]) {
                b[i] = self[l1]
                l1 += 1
            } else {
                b[i] = self[l2]
                l2 += 1
            }
            i += 1
        }
        while l1 <= mid {
            b[i] = self[l1]
            i += 1
            l1 += 1
        }
        while l2 <= high {
            b[i] = self[l2]
            i += 1
            l2 += 1
        }
        i = low
        while i <= high {
            self[i] = b[i]
            i += 1
        }
    }
}

extension Array where Element: Comparable {

    /// Merge sort implementation with default comparator `<`. Convenience method
    /// - Note: Available when `T` conforms to `Comparable`
    public mutating func sortMerge() {
        sortMerge(by: <)
    }
}
