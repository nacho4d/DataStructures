//
//  ShellSort.swift
//  DataStructures
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/08/02.
//

import Foundation

extension Array {
    /// Shell Sort.
    /// - Complexity: Performance and Time complexity depends to gap sequences. For instance if gap sequence is N/(2^k) then Time Complexity Worst Case is O(*n*^2). Current implementation uses Tokuda's [A108870](https://oeis.org/A108870) gap sequence which is empirically better for the average running time than currently known sequences of increments, except Ciuras's [A102549](https://oeis.org/A102549) (and only a few terms of that sequence are known)
    public mutating func sortShell(predicate compare: Comparator2) {

        // Original N/(2^K) gap sequence. Time Complexity Worst Case is O(*n*^2)
        //let sequence = sequence(first: count / 2, next: { $0 > 0 ? $0 / 2 : nil }) {

        // Marcin Ciura's gap sequence. Best known but very few elements. [A102549](https://oeis.org/A102549)
        //let sequence = [1750, 701, 301, 132, 57, 23, 10, 4, 1]

        // Tokuda's good set of increments for Shell sort. [A108870](https://oeis.org/A108870)
        let sequence = [29414774973, 13073233321, 5810325920, 2582367076, 1147718700,
                        510097200, 226709866, 100759940, 44782196, 19903198, 8845866,
                        3931496, 1747331, 776591, 345152, 153401, 68178, 30301, 13467,
                        5985, 2660, 1182, 525, 233, 103, 46, 20, 9, 4, 1]

        for gap in sequence where gap < count {
            // Do a gapped insertion sort for this gap size.
            // The first gap elements a[0..gap-1] are already in gapped order
            // keep adding one more element until the entire array is gap sorted
            for i in stride(from: gap, to: count, by: 1) {
                let temp = self[i]
                // shift earlier gap-sorted elements up until the correct location for a[i] is found
                var j = i
                while j >= gap && compare(self[j - gap], temp) == .orderedDescending {
                    self[j] = self[j - gap]
                    j -= gap
                }
                //  put temp (the original a[i]) in its correct location
                self[j] = temp
            }
            #if DEBUG
            // print self after each pass
            print(self)
            #endif
        }
    }
}

extension Array where Element: Comparable {
    /// Shell sort implementation with default comparator using`<`, `>` and `==` . Convenience method.
    /// - Note: Available when `T` conforms to `Comparable`
    public mutating func sortShell() {
        sortShell { return $0 == $1 ? .orderedSame : $0 < $1 ? .orderedAscending : .orderedDescending }
    }
}
