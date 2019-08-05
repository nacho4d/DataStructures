//
//  Sort.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/25.
//

import Foundation

extension Array {

    /// Quick sort implementation.  Quick Sort is a Divide and Conquer algorithm.
    /// It picks an element as pivot and divides (partitions) the given array around the picked pivot. Then repeat the same for each partition until the entire array is sorted. In this implementation the middle element is chosen as the pivot. Hence it leads to
    /// - Complexity: Worst-case and average time complexity is O(*n^2*)  where *n* is the length of the array. Best case time complexity is O(*n* log *n*) when array is already sorted. Space complexity is O(1).
    /// -  Note: The key of Quick sort algorithm is pivot. Original Hoare's implementation chooses middle element which produces O(*n* log *n*) in best case. Lomuto's implementations chooses last element because is easier to implement and understand however it might lead to O(*n*^2) in best case. algorithms generally run faster than insertion sort. It is much less efficient on large lists than more advanced algorithms such as quicksort, heapsort, or merge sort. However, insertion sort provides several advantages: Efficient for small data sets (much like other quadratic sorting algorithms), it can also be useful when input array is almost sorted, only few elements are misplaced in complete big array.Other advantage is it can sort a list as it receives it. It will not be efficient in the case of a reverse-ordered collection.
    ///
    /// **Example**
    ///
    ///  Input is [ 5 1 4 2 8 ] then algorithm choses middle element (4) as pivot and partitions the array into two. Swap first left (search from left to right) item bigger than pivot with first element on the right smaller than pivot (search from right t,o left). Repeat until each partition cannot be partioned anymore (lenght is 1)
    ///
    ///  [ 5 1 **4** 2 8 ] → [ 2 1 4 ][ 5 8 ]
    ///
    ///  [ 2 **1** 4 ][ 5 8 ] → [ 1 2 ][ 4 ][ 5 8 ]
    ///
    ///  [ **1** 2 ][ 4 ][ 5 8 ]  → [ 1 ][ 2 ][ 4 ][ 5 8 ]
    ///
    ///  [ 1 ][ **2** ][ 4 ][ 5 8 ] → [ 1 ][ 2 ][ 4 ][ 5 8 ]
    ///
    ///  [ 1 ][ 2 ][ **4** ][ 5 8 ] → [ 1 ][ 2 ][ 4 ][ 5 8 ]
    ///
    ///  [ 1 ][ 2 ][ 4 ][ **5** 8 ] → [ 1 ][ 2 ][ 4 ][ 5 ][ 8 ]
    ///
    ///  [ 1 ][ 2 ][ 4 ][ **5** ][ 8 ] → [ 1 ][ 2 ][ 4 ][ 5 ][ 8 ]
    ///
    ///  [ 1 ][ 2 ][ 4 ][ 5 ][ **8** ] → [ 1 ][ 2 ][ 4 ][ 5 ][ 8 ], Finally Done!
    ///
    public mutating func sortQuick(by compare: Comparator) {
        if count < 2 {
            #if DEBUG
            defer {
                print(self)
            }
            #endif
            return
        }
        __sortQuick(low: 0, high: count - 1, by: compare)
    }

    /// Recursive function, calls internally quick sort partition and divide the array into two groups.
    /// Then call quick sort function again for each group.
    mutating func __sortQuick(low: Int, high: Int, by compare: Comparator) {
        if low < high {
            let p = __sortQuickPartition(low: low, high: high, by: compare)
            __sortQuick(low: low, high: p, by: compare)
            __sortQuick(low: p + 1, high: high, by: compare)
        }
    }

    /// Calculate partition at the middle of the given range.
    /// Then compare each element in the range and divide it into 2 groups: smaller than pivot and bigger than pivot
    mutating func __sortQuickPartition(low: Int, high: Int, by compare: Comparator) -> Int {
        #if DEBUG
        defer {
            print(self)
        }
        #endif
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
        } while true
    }
}

extension Array where Element: Comparable {

    /// Quick sort implementation with default comparator `<`. Convenience method
    /// - Note: Available when `T` conforms to `Comparable`
    public mutating func sortQuick() {
        sortQuick(by: <)
    }
}
