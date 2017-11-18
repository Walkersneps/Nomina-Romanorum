import XCTest
import Foundation
import Testing
import HTTP
@testable import Vapor
@testable import App

/// This file shows an example of testing
/// routes through the Droplet.

class InfoRouteTests: TestCase {
    let drop = try! Droplet.testable()

    func testHelloPlain() throws {
        try drop
            .testResponse(to: .get, at: "hello")
            .assertStatus(is: .ok)
            .assertBody(equals: "Hello World!")
    }

    func testHelloJSON() throws {
        try drop
            .testResponse(to: .get, at: "hello/json")
            .assertStatus(is: .ok)
            .assertJSON("hello", equals: "world")
        try drop // bad request
            .testResponse(to: .get, at: "hello/badreq")
            .assertStatus(is: .ok)
            .assertJSON("error", equals: "Bad Request")
    }

    func testInfo() throws {
        try drop
            .testResponse(to: .get, at: "info")
            .assertStatus(is: .ok)
            .assertBody(contains: "0.0.0.0")
    }
    
}


// MARK: - Manifest
extension InfoRouteTests {
    /// This is a requirement for XCTest on Linux
    /// to function properly.
    /// See ./Tests/LinuxMain.swift for examples
    static let allTests = [
        ("testHelloPlain", testHelloPlain),
        ("testHelloJSON", testHelloJSON),
        ("testInfo", testInfo),
    ]
}
