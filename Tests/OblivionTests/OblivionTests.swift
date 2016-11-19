import XCTest
@testable import Oblivion

class OblivionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Oblivion().text, "Hello, World!")
    }


    static var allTests : [(String, (OblivionTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
