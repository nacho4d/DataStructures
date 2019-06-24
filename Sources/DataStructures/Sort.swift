//
//  File.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/25.
//

import Foundation

extension Array {

    public typealias Comparator = (Element, Element) -> Bool

    /// Bubble sort implementation
    public mutating func sortBubble(by compare: Comparator) {
        if count < 2 {
            return
        }
        var swapped = false
        repeat {
            swapped = false
            for i in 1..<count {
                if compare(self[i], self[i-1]) {
                    swapAt(i, i-1)
                    swapped = true
                }
            }
            //print(self)
        } while swapped
    }

    // ==================================================================================================

    public mutating func sortQuick(by compare: Comparator) {
        if count < 2 {
            return
        }
        __sortQuick(low: 0, high: count - 1, by: compare)
    }

    mutating func __sortQuick(low: Int, high: Int, by compare: Comparator) {
        if low < high {
            let p = __sortQuickPartition(low: low, high: high, by: compare)
            __sortQuick(low: low, high: p, by: compare)
            __sortQuick(low: p + 1, high: high, by: compare)
        }
    }

    mutating func __sortQuickPartition(low: Int, high: Int, by compare: Comparator) -> Int {
        let pivot = self[(low + high) / 2]
        var i = low - 1
        var j = high + 1
        repeat {
            repeat {
                i =  i + 1
            } while compare(self[i], pivot)
            repeat {
                j  = j - 1
            } while compare(pivot, self[j])
            if i >= j {
                return j
            }
            swapAt(i, j)
            //print(self)
        } while true
    }

    // ==================================================================================================

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
                l1 = l1 + 1
            } else {
                b[i] = self[l2]
                l2 = l2 + 1
            }
            i = i + 1
        }
        while l1 <= mid {
            b[i] = self[l1]
            i = i + 1
            l1 = l1 + 1
        }
        while l2 <= high {
            b[i] = self[l2]
            i = i + 1
            l2 = l2 + 1
        }
        i = low
        while i <= high {
            self[i] = b[i];
            i = i + 1
        }
    }
}

extension Array where Element: Comparable {

    public mutating func sortBubble() {
        sortBubble(by: <)
    }

    public mutating func sortMerge() {
        sortMerge(by: <)
    }

    public mutating func sortQuick() {
        sortQuick(by: <)
    }
}
