//
//  AuthorizationHeaderTests.swift
//  
//
//  Created by Brian Seo on 2023-04-20.
//

@testable import App
import XCTVapor

final class AuthorizationHeaderTests: XCTestCase {

    var sut: TwitterBot = TwitterBot()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testAuthorization() throws {
//        // ANSWER
//        let answer = "OAuth oauth_consumer_key=\"y3s8IEZoOHIsKxsowepMf9QjP\",oauth_token=\"1648577864516657152-1cilm2vSkKL89s5DQwnWR1OsakzgD1\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1681957597\",oauth_nonce=\"9dQMd3ZDIh2\",oauth_version=\"1.0\",oauth_signature=\"WMEsVCbmzNsfan%2FFOufyJTgpaYE%3D\""
//        // GIVEN
//        let nonce = "kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg"
//        let timestamp = "1318622958"
//        
//        let endpoint: TwitterAPI.EndPoint = .post
//
//        var params = [
//            ("oauth_consumer_key", sut.consumerKey),
//            ("oauth_token", sut.accessToken),
//            ("oauth_signature_method", "HMAC-SHA1"),
//            ("oauth_timestamp", timestamp),
//            ("oauth_nonce", nonce),
//            ("oauth_version", "1.0"),
//        ]
//        let secrets = (sut.consumerSecret, sut.accessTokenSecret)
//        let signature = TwitterAPI.Signature.get(.post, endpoint, params, secrets)
//        
//        params.append(("oauth_signature", signature))
//        // WHEN
//        let result = "OAuth \(sut.authorizationHeader(params))"
//        
////        print()
////        print(result)
////        print()
////        print(answer)
////        print()
//        
//        XCTAssertEqual(answer, result)
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
