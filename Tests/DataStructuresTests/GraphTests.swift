//
//  GraphTests.swift
//
//
//  Created by Guillermo Ignacio Enriquez Gutierrez on 2019/07/07.
//

import Foundation

import XCTest
@testable import DataStructures

final class GraphTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        super.setUp()
    }

    func testBasics() throws {
        ///    A → D
        ///    ↓ ↙︎ ↓    C ⇄ F
        ///    B ← E
        let graph = Graph<String>()
        XCTAssertEqual(graph.count, 0)
        let f = graph.addVertex(value: "F")
        XCTAssertEqual(graph.count, 1)
        let e = graph.addVertex(value: "E")
        XCTAssertEqual(graph.count, 2)
        let d = graph.addVertex(value: "D")
        XCTAssertEqual(graph.count, 3)
        let c = graph.addVertex(value: "C")
        XCTAssertEqual(graph.count, 4)
        let b = graph.addVertex(value: "B")
        XCTAssertEqual(graph.count, 5)
        let a = graph.addVertex(value: "A")
        XCTAssertEqual(graph.count, 6)

        graph.vertices.forEach { v in
            print(v.debugDescription)
        }

        XCTAssertEqual(graph.findVertex(where: { $0.value == "A" }), a)
        XCTAssertEqual(graph.findVertex(where: { $0.value == "B" }), b)
        XCTAssertEqual(graph.findVertex(where: { $0.value == "C" }), c)
        XCTAssertEqual(graph.findVertex(where: { $0.value == "D" }), d)
        XCTAssertEqual(graph.findVertex(where: { $0.value == "E" }), e)
        XCTAssertEqual(graph.findVertex(where: { $0.value == "F" }), f)
        XCTAssertNil(graph.findVertex(where: { $0.value == "G" }))

        graph.addEdge(from: a, to: d)
        graph.addEdge(from: a, to: b)
        graph.addEdge(from: c, to: f)
        graph.addEdge(from: d, to: b)
        graph.addEdge(from: d, to: e)
        graph.addEdge(from: e, to: b)
        graph.addEdge(from: f, to: c)

        XCTAssertEqual(graph.isReachable(from: a, to: b), true) // a -> b
        XCTAssertEqual(graph.isReachable(from: a, to: e), true)  // a -> d -> e
        XCTAssertEqual(graph.isReachable(from: e, to: a), false)

        graph.removeEdge(from: a, to: d)
        ///    A      D
        ///    ↓ ↙︎ ↓    C ⇄ F
        ///    B ← E
        XCTAssertEqual(graph.isReachable(from: a, to: b), true) // a -> b
        XCTAssertEqual(graph.isReachable(from: a, to: e), false)

        graph.addEdge(from: a, to: d)
        graph.addEdge(from: b, to: e)
        ///    A → D
        ///    ↓ ↙︎ ↓    C ⇄ F
        ///    B ⇄ E
        XCTAssertEqual(graph.isReachable(from: a, to: d), true)
        XCTAssertEqual(graph.isReachable(from: a, to: e), true)

        graph.removeVertex(d)
        ///    A
        ///    ↓          C ⇄ F
        ///    B ⇄ E
        XCTAssertEqual(graph.isReachable(from: a, to: e), true)
        XCTAssertNil(graph.removeEdge(from: a, to: e))


    }

    func testFindEdges() throws {
        let graph = Graph<String>()
        let _ = graph.addVertex(value: "D")
        let _ = graph.addVertex(value: "C")
        let b = graph.addVertex(value: "B")
        let a = graph.addVertex(value: "A")

        let aToNone = graph.findEdge(from: a) { _ in return true }
        XCTAssertNil(aToNone)

        let edge = graph.addEdge(from: a, to: b)

        let ab = try XCTUnwrap(graph.findEdge(from: a) { v -> Bool in
            return true
        })
        XCTAssertEqual(ab.connectsTo, b)
        XCTAssertTrue(ab === edge)

    }

    func testLoop() throws {
        ///           F
        ///         ↙︎ ⇅
        ///    A → D → C
        ///     ↙︎ ⇅
        ///    B     E
        let graph = Graph<String>()
        let f = graph.addVertex(value: "F")
        let e = graph.addVertex(value: "E")
        let d = graph.addVertex(value: "D")
        let c = graph.addVertex(value: "C")
        let b = graph.addVertex(value: "B")
        let a = graph.addVertex(value: "A")
        graph.addEdge(from: a, to: d)
        graph.addEdge(from: c, to: f)
        graph.addEdge(from: d, to: b)
        graph.addEdge(from: d, to: e)
        graph.addEdge(from: d, to: c)
        graph.addEdge(from: e, to: d)
        graph.addEdge(from: f, to: c)
        graph.addEdge(from: f, to: d)
        XCTAssertEqual(graph.isReachable(from: a, to: e), true)
        XCTAssertEqual(graph.isReachable(from: e, to: a), false)
    }

//    func testFind() throws {
//        ///           F
//        ///         ↙︎ ⇅
//        ///    A → D → C
//        ///     ↙︎ ⇅
//        ///    B     E
//        let graph = Graph<String>()
//        graph.addVertex(value: "F")
//        graph.addVertex(value: "E")
//        graph.addVertex(value: "D")
//        graph.addVertex(value: "C")
//        graph.addVertex(value: "B")
//        graph.addVertex(value: "A")
//        graph.addEdge(from: a, to: d)
//        graph.addEdge(from: c, to: f)
//        graph.addEdge(from: d, to: b)
//        graph.addEdge(from: d, to: e)
//        graph.addEdge(from: d, to: c)
//        graph.addEdge(from: e, to: d)
//        graph.addEdge(from: f, to: c)
//        graph.addEdge(from: f, to: d)
//        XCTAssertEqual(graph.isReachable(from: a, to: e), true)
//        XCTAssertEqual(graph.isReachable(from: e, to: a), false)
//    }

    static var allTests = [
        ("testBasics", testBasics),
        ("testLoop", testLoop),
    ]
}
