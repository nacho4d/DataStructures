//
//  Sort.swift
//  
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/25.
//

import Foundation

extension Array {

    /// Compare predicate block. Expected to returns true when left element should be placed(sorted) first than right element
    /// - Returns: Return true when left element should be placed(sorted) first than right element otherwise false
    public typealias Comparator = (Element, Element) -> Bool

    /// Compare predicate block. Expected to returns true when left element should be placed(sorted) first than right element
    /// - Returns: Return true when left element should be placed(sorted) first than right element otherwise false
    public typealias Comparator2 = (Element, Element) -> ComparisonResult

    /// Compare predicate block.
    /// - Parameters element: element to be compared
    /// - Parameters index: index of the element
    /// - Returns: Zero when element is found. Positive when target is possibly at the right of the element. And negative when target is possibly at the left of the target
    public typealias Comparate1 = ((Element, Int) -> ComparisonResult)

}
