//
//  Queue.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/24.
//

import Foundation

/// Queue implementation. Represents a first-in, first-out (FIFO) collection of objects.
public struct Queue<T> {

    /// Internal storage.
    let storage = LinkedList<T>()

    public init() {
    }

    public init<S: Sequence>(sequence: S) where S.Element == T {
        for s in sequence {
            storage.append(s)
        }
    }

    /// Gets the number of elements contained in the Stack.
    public var count: Int {
        return storage.count
    }

    /// Removes and returns the object at the beginning of the Queue.
    public func dequeue() -> T? {
        if let f = storage.first {
            storage.remove(node: f)
            return f.value
        }
        return nil
    }

    /// Adds an object to the end of the Queue.
    public func enqueue(_ value: T) {
        storage.append(value)
    }

    /// Returns the object at the top of the Stack without removing it.
    public func peek() -> T? {
        return storage.first?.value
    }

    /// Removes all objects from the Stack.
    public func removeAll() {
        storage.removeAll()
    }

}

extension Queue where T: Equatable {

    /// Determines whether an element is in the Stack.
    /// - Note: Available when `T` conforms to `Equatable`
    public func contains(_ value: T) -> Bool {
        return storage.contains(value)
    }

}
