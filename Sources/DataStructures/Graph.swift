//
//  Graph.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/07/07.
//

import Foundation

/// Object to represent a vertex in a graph
public class GraphVertex<T: Hashable>: Hashable, CustomDebugStringConvertible {

    /// Element object represented as a vertex
    public internal(set) var value: T

    /// List of edges (adjacent vertices)
    public internal(set) var edges: LinkedList<GraphEdge<T>>?

    /// Reference to next vertex. Order is not necesarily according to graph structure. Order depends on add timing
    public internal(set) var next: GraphVertex<T>?

    /// Designed initializer.
    /// - Parameter:
    ///    - value: Element object to be represented as a vertex
    public init(value: T) {
        self.value = value
    }

    /// Hashable implementation. Vertex must be hashable to be added into a temporal dictionary to calculate reachability
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }

    /// Equatable implementation. Vertex must be equatable to be compared when calculating reachability
    public static func == (lhs: GraphVertex<T>, rhs: GraphVertex<T>) -> Bool {
        return lhs.value == rhs.value
    }

    /// String representation for debugging purposes
    public var debugDescription: String {
        return "[\(value)->\(String(describing: next?.value))]"
    }
}

/// Object to represent an edge in a graph. Edge objects are referenced by a Vertex object which is the start point and have a connectsTo reference which is the end point of the edge
public class GraphEdge<T: Hashable> {

    /// End point of the edge.
    /// - Note: Weak to avoid retain cycles
    public internal(set) weak var connectsTo: GraphVertex<T>! // weak to avoid retain cycles

    /// Designated initializer. Clients should not need to create edges directly. This initializer is for Graph class internal usage.
    public init(connectsTo vertex: GraphVertex<T>) {
        self.connectsTo = vertex
    }
}

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
///     let a = graph.addVertex(value: "A")
///     let b = graph.addVertex(value: "B")
///     let c = graph.addVertex(value: "C")
///     let d = graph.addVertex(value: "D")
///     let e = graph.addVertex(value: "E")
///     let f = graph.addVertex(value: "F")
///     graph.addEdge(from: a, to: d)
///     graph.addEdge(from: a, to: b)
///     graph.addEdge(from: c, to: f)
///     graph.addEdge(from: d, to: b)
///     graph.addEdge(from: d, to: e)
///     graph.addEdge(from: e, to: b)
///     graph.addEdge(from: f, to: c)
///
public class Graph<T: Hashable> {

    /// Number of vertices
    public var count: Int {
        return vertices.count
    }

    /// Internal storage of vertices. Each vertex contains a linked list of edges
    public internal(set) var vertices = LinkedList<GraphVertex<T>>()
}

extension Graph {
    /// Add a new vertex with given value. For better performance vertex will be added at the head of vertices
    /// - Complexity: Time Complexity is O(1)
    @discardableResult public func addVertex(value: T) -> GraphVertex<T> {
        let new = GraphVertex(value: value)
        vertices.append(new)
        return new
    }

    /// Remove a vertex from the graph.
    /// - Complexity: Time Complexity is O(*n*^2) where n is number of vertices. Removing vertex it self is O(1) but all edges refering such vertex need to be removed so it becomes O(*n*^2).
    public func removeVertex(_ vertex: GraphVertex<T>) {
        vertices.remove(vertex)
        for vertex in vertices where vertex.edges != nil {
            vertex.edges = LinkedList(sequence: vertex.edges!.filter({ (edge) -> Bool in
                return edge.connectsTo !== vertex
            }))
        }
    }

    // MARK: -

    /// Iterate through vertices until `predicate` returns true.
    /// - Returns: returns found object or `nil` if not found
    /// - Complexity: Since search is linear time complexity is O(*n*)
    public func findVertex(where predicate: ((GraphVertex<T>)-> Bool)) -> GraphVertex<T>? {
        for vertex in vertices {
            if predicate(vertex) {
                return vertex
            }
        }
        return nil
    }

    /// Iterate through edges until `predicate` returns true.
    /// - Returns: returns found object or `nil` if not found
    /// - Complexity: Since search is linear time complexity is O(*m*) where m is the number of edges given vertex has
    public func findEdge(from: GraphVertex<T>, where predicate: ((GraphVertex<T>)-> Bool)) -> GraphEdge<T>? {
        for edge in from.edges ?? LinkedList<GraphEdge<T>>() {
            if predicate(edge.connectsTo) {
                return edge
            }
        }
        return nil
    }

    // MARK: -

    /// Add an edge from `from` vertex to `to` vertex.
    /// - Returns: returns added vertex
    /// - Complexity: O(1)
    @discardableResult public func addEdge(from: GraphVertex<T>, to: GraphVertex<T>) -> GraphEdge<T> {
        let edge = GraphEdge(connectsTo: to)
        if from.edges == nil {
            from.edges = LinkedList(sequence: [edge])
        } else {
            from.edges?.append(edge)
        }
        return edge
    }

    /// Remove edge from `from` vertex to `to` vertex. For better performance edge will be added at the head of edges
    /// - Complexity: Since search is linear time complexity is O(*m*) where m is the number of edges given vertex has
    @discardableResult public func removeEdge(from: GraphVertex<T>, to: GraphVertex<T>) -> GraphEdge<T>? {
        guard let toRemove = from.edges?.findFirst(where: { return $0.connectsTo === to }) else { return nil }
        from.edges?.remove(node: toRemove)
        return toRemove.value
    }

    // MARK: -

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
        for edge in from.edges ?? LinkedList<GraphEdge<T>>() {
            if isReachable(from: edge.connectsTo, to: to, visited: &visited) {
                return true
            }
        }
        return false
    }

    /// Check if there is a path from one vertex to another.
    /// - Parameters
    ///    - from: Start point vertex.
    ///    - from: End point vertex.
    public func isReachable(from: GraphVertex<T>, to: GraphVertex<T>) -> Bool {
        var visited = [GraphVertex<T>: Bool]()
        return isReachable(from: from, to: to, visited: &visited)
    }
}
