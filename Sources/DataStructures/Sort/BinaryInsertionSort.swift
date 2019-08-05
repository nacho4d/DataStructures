//
//  Sort.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/25.
//

import Foundation

extension Array {

    /// Binary Insertion sort implementation. Similar to Insertion Sort except it uses a binary search instead of a linear search algorithm for calculating index of each element.
    /// - Complexity: Time complexity worst case O(*n*^2).
    public mutating func sortBinaryInsertion(by compare: Comparator2) {
        if count < 2 {
            return
        }

        for i in 1..<self.count {
            var lower = 0
            var upper = i - 1

            // Binary search
            print(self)
            print("lower:\(lower) upper:\(upper)")
            let newIndex = __searchBinary(lowerIndex: &lower, upperIndex: &upper) { (element, index) in
                let res1 = compare(self[i], element)
                if index == 0 {
                    if res1 == .orderedSame || res1 == .orderedAscending {
                        return .orderedSame
                    }
                    return res1
                }
                let res2 = compare(self[index - 1], self[i])
                if res2 == .orderedSame {
                    return .orderedSame
                }
                if res1 == .orderedAscending && res2 == .orderedAscending {
                    return .orderedSame
                }
                return res1
            }

            print("newIndex:\(newIndex == nil ? "nil" : newIndex!.description)")
            if newIndex != nil && newIndex != i {
                // I wish there was better performant way of doing this in swift.
                // I think remove might release some storage and insert will allocate it again.
                insert(remove(at: i), at: newIndex!)
            }
            #if DEBUG
            // print self after each pass
            print(self)
            #endif
        }
    }
}

extension Array where Element: Comparable {

    /// Binary Insertion sort implementation with default comparator `<`. Convenience method
    /// - Note: Available when `T` conforms to `Comparable`
    public mutating func sortBinaryInsertion() {
        sortBinaryInsertion { return $0 == $1 ? .orderedSame : $0 < $1 ? .orderedAscending : .orderedDescending }
    }
}
