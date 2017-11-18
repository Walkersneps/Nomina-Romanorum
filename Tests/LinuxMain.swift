#if os(Linux)

import XCTest
@testable import AppTests

XCTMain([
    // AppTests
    // testCase(PostControllerTests.allTests),
    testCase(InfoRoutesTests.allTests),
    testCase(PlainNamesRoutesTests.allTests),
    testCase(JSONNamesRoutesTests.allTests),
    testCase(EasterEggsTests.allTests)
])

#endif
