//
//  File.swift
//  
//
//  Created by Brian Seo on 2023-04-19.
//

@testable import App
import XCTVapor

// MARK: - Percent Encoding
final class TwitterEncodingTests: XCTestCase  {
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
            let encoded = key.percentEncoded
            
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
            let encoded = key.percentEncoded
            
            // THEN
            XCTAssertNotEqual(encoded, value, "\(key) shoud not match")
        }
    }

}
