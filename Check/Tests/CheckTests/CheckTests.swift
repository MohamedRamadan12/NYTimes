import XCTest
@testable import Check

final class CheckTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Check().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
