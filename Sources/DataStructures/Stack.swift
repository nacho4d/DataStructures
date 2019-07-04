//
//  Stack.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/06/24.
//

/// Stack implementation. Represents a simple last-in-first-out (LIFO) collection of objects. (Based on C# .Net Implementation)
public struct Stack<T> {

    /// Internal storage.
    let storage = LinkedList<T>()

    /// Designated initializer. Creates a new instance of a stack.
    public init() {
    }

    /// Designated initializer. Creates a new instance of a stack and add elements from `sequence`.
    /// - Parameters:
    ///   - sequence: sequence containing elements to add to queue.
    public init<S: Sequence>(sequence: S) where S.Element == T {
        for s in sequence {
            storage.append(s)
        }
    }

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
}

extension Stack where T: Equatable {

    /// Determines whether an element is in the Stack.
    /// - Note: Available when `T` conforms to `Equatable`
    public func contains(_ value: T) -> Bool {
        return storage.contains(value)
    }
}
