//
//  Sort.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/25.
//

import Foundation

extension Array {

    /// Insertion sort implementation. Insertion Sort is a simple sorting algorithm similar to when people manually sort cards in a bridge hand.
    ///
    /// -  Note: Other algorithms generally run faster than insertion sort. It is much less efficient on large lists than more advanced algorithms such as quicksort, heapsort, or merge sort. However, insertion sort provides several advantages: Efficient for small data sets (much like other quadratic sorting algorithms), it can also be useful when input array is almost sorted, only few elements are misplaced in complete big array.Other advantage is it can sort a list as it receives it. It will not be efficient in the case of a reverse-ordered collection.
    ///
    /// - Complexity: Worst-case and average time complexity is O(*n^2*)  where *n* is the length of the array. Best case time complexity is O(*n*) when array is already sorted. Space complexity is O(1).
    ///
    /// **Example**
    ///
    ///  [ **5** 1 4 2 8 ] → [ 5 **1** 4 2 8 ], 1st element, there is nothing in the left
    ///
    ///  [ 5 **1** 4 2 8 ] → [ **1** 5 4 2 8 ], 2nd element, search index within left items, move to index
    ///
    ///  [ 1 5 **4** 2 8 ] → [ 1 **4** 5 2 8 ], *n*-th element, search index within left items, move
    ///
    ///  [ 1 4 5 **2** 8 ] → [ 1 **2** 2 5 8 ], Repeat until last element is reached
    ///
    ///  [ 1 4 2 5 **8** ] → [ 1 4 2 5 **8** ], Finally Done!
    ///
    ///  Index search algorithm is a simple linear search, which checks each element from left to right until  index/element is found.
    ///
    public mutating func sortInsertion(by compare: Comparator) {
        if count < 2 {
            return
        }
        for i in 1..<self.count {
            let newIndex = __sortInsertionNewIndexForElement(index: i, compare: compare)
            if newIndex != i {
                // I wish there was better performant way of doing this in swift.
                // I think remove might release some storage and insert will allocate it again.
                insert(remove(at: i), at: newIndex)
            }
            #if DEBUG
            // print self after each pass
            print(self)
            #endif
        }
    }

    mutating func __sortInsertionNewIndexForElement(index: Int, compare: Comparator) -> Int {
        for i in 0..<index {
            if !compare(self[i], self[index]) {
                return i
            }
        }
        return index
    }

}

extension Array where Element: Comparable {

    /// Insertion sort implementation with default comparator `<`. Convenience method
    /// - Note: Available when `T` conforms to `Comparable`
    public mutating func sortInsertion() {
        sortInsertion(by: <)
    }
}
