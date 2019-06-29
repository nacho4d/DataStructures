//
//  Search.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/27.
//

import Foundation

extension Array {

    /// Linear search. assumes array is sorted. It sequentially checks each element of the list until a match is found or the whole list has been searched.
    ///
    /// Usage: In below example index is 1
    ///
    ///      let index = [1, 3, 5].searchLinear { return 3 - $0 }
    ///
    /// - Returns: Index of found element. If not found then it returns nil
    /// - Complexity: Time complexity worst and average case O(*n*), best case O(1). Space complexity: O(1)
    ///
    public func searchLinear(predicate: Comparate1) -> Int? {
        for (index, element) in self.enumerated() {
            let res = predicate(element, index)
            if res == .orderedSame {
                return index
            }
            if res == .orderedAscending {
                return nil
            }
        }
        return nil
    }

    /// Binary search, assumes array is sorted. Binary search compares the target value to the middle element of the array. If they are not equal, the half in which the target cannot lie is eliminated and the search continues on the remaining half, again taking the middle element to compare to the target value, and repeating this until the target value is found.
    ///
    /// Usage: In below example index is 1
    ///
    ///      let index = [1, 3, 5].searchBinary { return 3 - $0 }
    ///
    /// - Returns: Index of found element. If not found then it returns nil
    /// - Complexity: Time complexity worst and average case O(log *n*), best case O(1). Space complexity: O(1)
    public func searchBinary(predicate: Comparate1) -> Int? {
        if isEmpty {
            return nil
        }
        var lowerIndex = 0
        var upperIndex = count - 1
        return __searchBinary(lowerIndex: &lowerIndex, upperIndex: &upperIndex, predicate: predicate)
    }

    func __searchBinary(lowerIndex: inout Int, upperIndex: inout Int, predicate: Comparate1) -> Int? {
        while true {
            let currentIndex = (lowerIndex + upperIndex)/2
            let res = predicate(self[currentIndex], currentIndex)
            if res == .orderedSame {
                return currentIndex
            }
            if res == .orderedAscending {
                upperIndex = currentIndex - 1
            } else {
                lowerIndex = currentIndex + 1
            }
            if lowerIndex > upperIndex {
                return nil
            }

        }
    }
}
