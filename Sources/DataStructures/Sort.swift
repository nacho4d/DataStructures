//
//  File.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/25.
//

import Foundation

extension Array {

    /// Comparator block. Return tru when left element should be first, otherwise return false
    public typealias Comparator = (Element, Element) -> Bool

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

    // MARK: -

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

    // MARK: -

    /// TODO. Binary Insertion sort implementation. Similar to Insertion Sort except it uses a binary search instead of a linear search algorithm for calculating index of each element.
    public mutating func sortBinaryInsertion(by compare: Comparator) {
        // TODO: implement this when binary search algorithm is implemented.
        sortInsertion(by: compare)
    }

    // MARK: -

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

    // MARK: -

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
