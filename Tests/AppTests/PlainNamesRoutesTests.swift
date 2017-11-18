//
//  PlainNamesRoutesTests.swift
//  AppTests
//
//  Created by Walter Carli on 18/11/17.
//

import XCTest
import Testing
@testable import Vapor
@testable import App

class PlainNamesRoutesTests: TestCase {
    let drop = try! Droplet.testable()

    func testSingleNamePlain() throws {
        try drop
            .testResponse(to: .get, at: "/")
            .assertStatus(is: .ok)
            .assertBody(contains: " ")
    }

    func testManyNamesPlain() throws {
        try drop // no argument supplied
            .testResponse(to: .get, at: "list")
            .assertStatus(is: .ok)
            .assertBody(contains: "ERROR")
        try drop
            .testResponse(to: .get, at: "list/2")
            .assertStatus(is: .ok)
            .assertBody(contains: "\n")
    }
}

// MARK: - Manifest
extension PlainNamesRoutesTests {
    /// This is a requirement for XCTest on Linux
    /// to function properly.
    /// See ./Tests/LinuxMain.swift for examples
    static let allTests = [
        ("testSingleNamePlain", testSingleNamePlain),
        ("testManyNamesPlain", testManyNamesPlain),
        ]
}
