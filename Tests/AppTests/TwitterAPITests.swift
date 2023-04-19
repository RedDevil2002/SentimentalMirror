//
//  TwitterAPITests.swift
//  
//
//  Created by Brian Seo on 2023-04-19.
//

@testable import App
import XCTVapor

final class TwitterAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

// MARK: - Percent Encoding
extension TwitterAPITests {
    func testPercentEncoding() throws {
        // GIVEN
        let codablePairs = [
            ("Ladies + Gentlemen", "Ladies%20%2B%20Gentlemen"),
            ("An encoded string!", "An%20encoded%20string%21"),
            ("Dogs, Cats & Mice", "Dogs%2C%20Cats%20%26%20Mice"),
            ("☃", "%E2%98%83"),
        ]
        
        
        for (key, value) in codablePairs {
            // WHEN
            let encoded = TwitterAPI.encode(key)
            
            // THEN
            XCTAssertEqual(encoded, value, "\(key) was not encoded properly")
        }
    }
    
    func testPercentEncodingAgainstInvalid() throws {
        // GIVEN
        let codablePairs = [
            ("Ladies + Gentlemen", "Ladies%20%2B%20Gen4tlemen"),
            ("An encoded string!", "An%20encod2ed%20string%21"),
            ("Dogs, Cats & Mice", "Dogs%2C%20Cats%20%26%20Mice1"),
            ("☃", "%E2%98"),
        ]
        
        
        for (key, value) in codablePairs {
            // WHEN
            let encoded = TwitterAPI.encode(key)
            
            // THEN
            XCTAssertNotEqual(encoded, value, "\(key) shoud not match")
        }
    }

}
