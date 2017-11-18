//
//  JSONNamesRoutesTests.swift
//  AppTests
//
//  Created by Walter Carli on 18/11/17.
//

import XCTest
@testable import Vapor
@testable import App

class JSONNamesRoutesTests: TestCase {
    let drop = try! Droplet.testable()

    func testSingleNameJSON() throws {
        try drop
            .testResponse(to: .get, at: "api")
            .assertStatus(is: .ok)
    }

    func testManyNamesJSON() throws {
        try drop // amount too big
            .testResponse(to: .get, at: "api/list/99999999999999999")
            .assertStatus(is: .ok)
            .assertJSON("status", equals: "error")
            .assertJSON("errCode", equals: "1")
        try drop // no amount parameter supplied
            .testResponse(to: .get, at: "/api/list")
            .assertStatus(is: .ok)
            .assertJSON("status", equals: "error")
            .assertJSON("errCode", equals: "2")
        try drop
            .testResponse(to: .get, at: "api/list/2")
            .assertStatus(is: .ok)
    }
    
}

// MARK: - Manifest
extension JSONNamesRoutesTests {
    /// This is a requirement for XCTest on Linux
    /// to function properly.
    /// See ./Tests/LinuxMain.swift for examples
    static let allTests = [
        ("testSingleNameJSON", testSingleNameJSON),
        ("testManyNamesJSON", testManyNamesJSON),
        ]
}
