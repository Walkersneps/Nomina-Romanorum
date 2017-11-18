//
//  EasterEggsTests.swift
//  AppTests
//
//  Created by Walter Carli on 18/11/17.
//

import XCTest
@testable import Vapor
@testable import App

class EasterEggsTests: TestCase {
    let drop = try! Droplet.testable()

    func testBrusky() throws {
        try drop
            .testResponse(to: .get, at: "brusky")
            .assertStatus(is: .ok)
            .assertBody(contains: "PARACADUTE")
    }

    func testWalter() throws {
        try drop
            .testResponse(to: .get, at: "w")
            .assertStatus(is: .ok)
            .assertBody(contains: "Walter")
    }
    
}

// MARK: - Manifest
extension EasterEggsTests {
    /// This is a requirement for XCTest on Linux
    /// to function properly.
    /// See ./Tests/LinuxMain.swift for examples
    static let allTests = [
        ("testBrusky", testBrusky),
        ("testWalter", testWalter),
        ]
}
