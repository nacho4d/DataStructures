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
        continueAfterFailure = true
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

        XCTAssertEqual(graph.isReachable(from: a, to: e), true) // a -> d -> e
        XCTAssertEqual(graph.isReachable(from: e, to: a), false)
    }

    static var allTests = [
        ("testBasics", testBasics),
    ]
}
