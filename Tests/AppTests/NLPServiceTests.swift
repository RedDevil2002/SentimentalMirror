//
//  NLPServiceTests.swift
//  
//
//  Created by Brian Seo on 2023-04-25.
//

@testable import App
import XCTVapor

final class NLPServiceTests: XCTestCase {

    var sut: SentimentalAnalyzer = SentimentalAnalyzer()
    
    func testAnalysis() throws {
        // ANSWER
        let answer = 0.6
        
        // GIVEN
        let text = "This is fucking awesome!"
        
        // WHEN
        let result = sut.analyze(text)
        
        // THEN
        XCTAssertEqual(answer, result)
    }
    
    func testBadAnalysis() throws {
        // ANSWER
        let answer = -1.0
        
        // GIVEN
        let text = "This is fantastically disgusting and bad at the same time!"
        
        // WHEN
        let result = sut.analyze(text)
        
        // THEN
        XCTAssertEqual(answer, result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
