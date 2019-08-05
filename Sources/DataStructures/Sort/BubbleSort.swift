//
//  Sort.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/25.
//

import Foundation

extension Array {

    /// Bubble sort implementation. Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in wrong order.
    ///
    /// -  Note: Other algorithms generally run faster than bubble sort, and are no more complex. Therefore, bubble sort is not a practical sorting algorithm. The only significant advantage that bubble sort has over most other algorithms, even quicksort, but not insertion sort, is that the ability to detect that the list is sorted efficiently is built into the algorithm. It will not be efficient in the case of a reverse-ordered collection.
    ///
    /// - Complexity:Worst-case and average time complexity is O(*n^2*)  where *n* is the length of the array. Best case time complexity is O(*n*) when array is already sorted. Space complexity is O(1).
    ///
    /// **Example**
    ///
    /// 1. First Pass:
    ///
    ///     [ **5 1** 4 2 8 ] → [ **1 5** 4 2 8 ], Swap since 5 > 1
    ///
    ///     [ 1 **5 4** 2 8 ] → [ 1 **4 5** 2 8 ], Swap since 5 > 4
    ///
    ///     [ 1 4 **5 2** 8 ] → [ 1 4 **2 5** 8 ], Swap since 5 > 2
    ///
    ///     [ 1 4 2 **5 8** ] → [ 1 4 2 **5 8** ], Do not swap since elements are already in order 8 > 5
    ///
    /// 2. Second Pass:
    ///
    ///     [ **1 4** 2 5 8 ] → [ **1 4** 2 5 8 ]
    ///
    ///     [ 1 **4 2** 5 8 ] → [ 1 **2 4** 5 8 ], Swap since 4 > 2
    ///
    ///     [ 1 2 **4 5** 8 ] → [ 1 2 **4 5** 8 ]
    ///
    ///     [ 1 2 4 **5 8** ] → [ 1 2 4 **5 8** ]
    ///
    ///     Now, the array is already sorted, but algorithm does not know so. The algorithm needs one whole pass without any swap to figure it out.
    ///
    /// 3. Third Pass:
    ///
    ///     [ **1 2** 4 5 8 ] → [ **1 2** 4 5 8 ]
    ///
    ///     [ 1 **2 4** 5 8 ] → [ 1 **2 4** 5 8 ]
    ///
    ///     [ 1 2 **4 5** 8 ] → [ 1 2 **4 5** 8 ]
    ///
    ///     [ 1 2 4 **5 8** ] → [ 1 2 4 **5 8** ] Finally Done!
    ///
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
            #if DEBUG
            // print self after each pass
            print(self)
            #endif
        } while swapped
    }
}

extension Array where Element: Comparable {

    /// Bubble sort implementation with default comparator `<`. Convenience method
    /// - Note: Available when `T` conforms to `Comparable`
    public mutating func sortBubble() {
        sortBubble(by: <)
    }
}
