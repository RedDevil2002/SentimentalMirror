//
//  CreateTweetTest.swift
//
//
//  Created by Brian Seo on 2023-04-19.
//

@testable import App
import XCTVapor

final class CreateTweetTest: XCTestCase {

    var sut: TwitterBot = TwitterBot()

    func testExample() throws {
        let answer = "VQgoGOVs%2B0R9ghDfuael%2Fj5zBWg%3D"
        
        let nonce = "exRAVDXxwZw"
        let timestamp = "1681972633"
        
        let params = [
            ("oauth_consumer_key", sut.consumerKey),
            ("oauth_token", sut.token),
            ("oauth_signature_method", "HMAC-SHA1"),
            ("oauth_timestamp", timestamp),
            ("oauth_nonce", nonce),
            ("oauth_version", "1.0"),
        ]
        
        let endpoint: TwitterBot.EndPoint = .tweet
        // WHEN
        
        let secrets = (sut.consumerSecret, sut.tokenSecret)
        let signature = TwitterBot.Signature.get(.post, endpoint, params, secrets)
               
        print(signature)
        print(signature.percentEncoded)
        print(answer)
        XCTAssertEqual(signature.percentEncoded, answer)        
    }

    func testCreateANewTweet() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
