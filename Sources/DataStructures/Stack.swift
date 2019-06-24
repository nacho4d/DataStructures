//
//  Stack.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/24.
//

/// Stack implementation. Represents a simple last-in-first-out (LIFO) collection of objects.
public struct Stack<T: Comparable> {

    /// Internal storage.
    let storage = LinkedList<T>()

    /// Gets the number of elements contained in the Stack.
    public var count: Int {
        return storage.count
    }

    /// Inserts an object at the top of the Stack.
    public func push(_ value: T) {
        storage.append(value)
    }

    /// Removes and returns the object at the top of the Stack.
    public func pop() -> T? {
        guard let last = storage.last else { return nil }
        storage.remove(node: last)
        return last.value
    }

    /// Returns the object at the top of the Stack without removing it.
    public func peek() -> T? {
        return storage.last?.value
    }

    /// Removes all objects from the Stack.
    public func removeAll() {
        storage.removeAll()
    }

    /// Determines whether an element is in the Stack.
    public func contains(_ value: T) -> Bool {
        return storage.contains(value)
    }
}
