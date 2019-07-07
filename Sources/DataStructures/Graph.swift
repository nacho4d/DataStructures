//
//  Graph.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/07/07.
//

import Foundation

/// Graph implementation. Graph implementation backed by a linked list of vertices and each vertex has a linked list for all connections (edges). Implementation is based on Boston university CS class: https://www.cs.bu.edu/teaching/c/graph/linked/
///
/// Example:
///
///     A → D
///     ↓ ↙︎ ↓    C ⇄ F
///     B ← E
///
/// Above graph can be representated with a linked list of vertex and each vertex will contain a linked list of edges.
///
///        ↓
///        A ⇨ [ B → D ]
///        ↓
///        B
///        ↓
///        C ⇨ [ F ]
///        ↓
///        D ⇨ [ E → B ]
///        ↓
///        E ⇨ [ B ]
///        ↓
///        F ⇨ [ C ]
///
/// This will be expressed in code as:
///
///     let graph = Graph<String>()
///     let f = graph.addVertex(value: "F")
///     let e = graph.addVertex(value: "E")
///     let d = graph.addVertex(value: "D")
///     let c = graph.addVertex(value: "C")
///     let b = graph.addVertex(value: "B")
///     let a = graph.addVertex(value: "A")
///     graph.addEdge(from: a, to: d)
///     graph.addEdge(from: a, to: b)
///     graph.addEdge(from: c, to: f)
///     graph.addEdge(from: d, to: b)
///     graph.addEdge(from: d, to: e)
///     graph.addEdge(from: e, to: b)
///     graph.addEdge(from: f, to: c)
///
public class GraphVertex<T: Hashable>: Hashable, CustomDebugStringConvertible {
    public internal(set) var value: T
    public internal(set) var edges: GraphEdge<T>?
    public internal(set) var next: GraphVertex<T>?
    public init(value: T) {
        self.value = value
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    public static func == (lhs: GraphVertex<T>, rhs: GraphVertex<T>) -> Bool {
        return lhs.value == rhs.value
    }
    public var debugDescription: String {
        return "[\(value)->\(String(describing: next))]"
    }
}
public class GraphEdge<T: Hashable> {
    public internal(set) weak var connectsTo: GraphVertex<T>! // weak to avoit retain cycles
    public internal(set) var next: GraphEdge<T>?
    public init(connectsTo vertex: GraphVertex<T>) {
        self.connectsTo = vertex
    }
}
public class Graph<T: Hashable> {
    /// Number of vertices
    var count = 0

    /// Simple linked list of vertices
    public internal(set) var vertices: GraphVertex<T>?
}

extension Graph {
    /// Add a new vertex with given value. For better performance vertex will be added at the head of vertices
    /// - Complexity: Time Complexity is O(1)
    @discardableResult public func addVertex(value: T) -> GraphVertex<T> {
        let new = GraphVertex(value: value)
        if vertices != nil {
            new.next = vertices
        }
        vertices = new
        count += 1
        return new
    }

    /// Iterate through vertices until `predicate` returns true.
    /// - Returns: returns found object or `nil` if not found
    public func findVertex(where predicate: ((GraphVertex<T>)-> Bool)) -> GraphVertex<T>? {
        var cur: GraphVertex<T>? = vertices
        while cur != nil {
            if predicate(cur!) {
                return cur
            }
            cur = cur?.next
        }
        return nil
    }

    /// Iterate through edges until `predicate` returns true.
    /// - Returns: returns found object or `nil` if not found
    public func findEdge(from: GraphVertex<T>, where predicate: ((GraphVertex<T>)-> Bool)) -> GraphVertex<T>? {
        var cur: GraphVertex<T>? = vertices
        while cur != nil {
            if predicate(cur!) {
                return cur
            }
            cur = cur?.next
        }
        return nil
    }

    /// Add an edge from `from` vertex to `to` vertex. For better performance edge will be added at the head of edges
    /// - Returns: returns added vertex
    @discardableResult public func addEdge(from: GraphVertex<T>, to: GraphVertex<T>) -> GraphEdge<T> {
        let edge = GraphEdge(connectsTo: to)
        edge.next = from.edges
        from.edges = edge
        return edge
    }

    func isReachable(from: GraphVertex<T>, to: GraphVertex<T>, visited: inout [GraphVertex<T>: Bool]) -> Bool {
        print("isReachable: from \(from.value) to  \(to.value)")
        // Have we been here already?
        if visited[from] == true {
            return false
        }
        // Don't come here again.
        visited[from] = true

        // Is this the destination?  If so, we've reached it!
        if from === to {
            return true
        }

        // See if we can get there from each of the vertices we connect to.
        // If we can get there from at least one of them, it is reachable.
        var edge = from.edges
        while edge != nil {
            if isReachable(from: edge!.connectsTo, to: to, visited: &visited) {
                return true
            }
            edge = edge?.next
        }
        return false
    }

    public func isReachable(from: GraphVertex<T>, to: GraphVertex<T>) -> Bool {
        var visited = [GraphVertex<T>: Bool]()
        return isReachable(from: from, to: to, visited: &visited)
    }
}