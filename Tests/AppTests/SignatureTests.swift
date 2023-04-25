//
//  SignatureTests.swift
//  
//
//  Created by Brian Seo on 2023-04-19.
//

@testable import App
import XCTVapor

final class SignatureTests: XCTestCase {
    
    var sut: TwitterBot = TwitterBot()
    
//    "OAuth
//    oauth_consumer_key=\"y3s8IEZoOHIsKxsowepMf9QjP\",
//    oauth_token=\"1648577864516657152-1cilm2vSkKL89s5DQwnWR1OsakzgD1\",
//    oauth_signature_method=\"HMAC-SHA1\",
//    oauth_timestamp=\"1681972633\",
//    oauth_nonce=\"exRAVDXxwZw\",
//    oauth_version=\"1.0\",
//    oauth_signature=\"VQgoGOVs%2B0R9ghDfuael%2Fj5zBWg%3D\""
    func testSignature() throws {
        // ANSWER
        let answer = "VQgoGOVs%2B0R9ghDfuael%2Fj5zBWg%3D"
        // GIVEN
        let nonce = "exRAVDXxwZw"
        let timestamp = "1681972633"
        let oauth_token = TwitterBot.Credential.token
        
        let params = [
            ("oauth_consumer_key", sut.consumerKey),
            ("oauth_token", sut.token),
            ("oauth_signature_method", "HMAC-SHA1"),
            ("oauth_timestamp", timestamp),
            ("oauth_nonce", nonce),
            ("oauth_version", "1.0"),
        ]
        
        let endpoint: TwitterBot.EndPoint = .tweet
        let secrets = (sut.consumerSecret, sut.tokenSecret)
        // WHEN

        let signature = TwitterBot.Signature.get(.post, endpoint, params, secrets)
        
        print(signature)
        print(signature.percentEncoded)
        print(answer)
        
        XCTAssertEqual(signature.percentEncoded, answer)
    }
    
    func testSignature3() throws {
        // ANSWER
        let answer = "lLze3lpvkoKuXhNwvWf3Tfm%2BW%2FA%3D"
        // GIVEN
        let nonce = "zrgQjyCBXmG"
        let timestamp = "1681972633"
        let oauth_token = TwitterBot.Credential.token
        
        let params = [
            ("oauth_consumer_key", sut.consumerKey),
            ("oauth_token", sut.token),
            ("oauth_signature_method", "HMAC-SHA1"),
            ("oauth_timestamp", "1681978887"),
            ("oauth_nonce", "DffMmmxISU4"),
            ("oauth_version", "1.0"),
        ]
        
        let endpoint: TwitterBot.EndPoint = .tweet
        let secrets = (sut.consumerSecret, sut.tokenSecret)
        // WHEN

        let signature = TwitterBot.Signature.get(.post, endpoint, params, secrets)
        
        print(signature)
        print(signature.percentEncoded)
        print(answer)
        
        XCTAssertEqual(signature.percentEncoded, answer)
    }
//    oauth_consumer_key="y3s8IEZoOHIsKxsowepMf9QjP",oauth_token="1648577864516657152-1cilm2vSkKL89s5DQwnWR1OsakzgD1",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1681978887",oauth_nonce="DffMmmxISU4",oauth_version="1.0",oauth_signature="lLze3lpvkoKuXhNwvWf3Tfm%2BW%2FA%3D"' \
    func testSignature2() throws {
        // ANSWER
        let answer = "lLze3lpvkoKuXhNwvWf3Tfm%2BW%2FA%3D"
        // GIVEN
        let nonce = "exRAVDXxwZw"
        let timestamp = "1681972633"
        let oauth_token = TwitterBot.Credential.token
        
        let params = [
            ("oauth_consumer_key", sut.consumerKey),
            ("oauth_token", sut.token),
            ("oauth_signature_method", "HMAC-SHA1"),
            ("oauth_timestamp", "1681978887"),
            ("oauth_nonce", "DffMmmxISU4"),
            ("oauth_version", "1.0"),
        ]
        
        let endpoint: TwitterBot.EndPoint = .tweet
        let secrets = (sut.consumerSecret, sut.tokenSecret)
        // WHEN

        let signature = TwitterBot.Signature.get(.post, endpoint, params, secrets)
        
        print(signature)
        print(signature.percentEncoded)
        print(answer)
        
        XCTAssertEqual(signature.percentEncoded, answer)
    }
    
    func testSigningKey() throws {
        // ANSWER
        let answer = TwitterBot.Signature.signingKey(consumerSecret: sut.consumerSecret, accessTokenSecret: sut.tokenSecret)
        
        // WHEN
        let result = TwitterBot.Signature.signingKey(consumerSecret: sut.consumerSecret, accessTokenSecret: sut.tokenSecret)
        
        XCTAssertEqual(answer, result)
        
    }
    
    func testParameterString() throws {
        // GIVEN
        let nonce = "kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg"
        let timestamp = "1318622958"
        
        // Answer
        let answer = "include_entities=true&oauth_consumer_key=\(sut.consumerKey)&oauth_nonce=\(nonce)&oauth_signature_method=HMAC-SHA1&oauth_timestamp=\(timestamp)&oauth_token=\(sut.token)&oauth_version=1.0&status=Hello%20Ladies%20%2B%20Gentlemen%2C%20a%20signed%20OAuth%20request%21"
        
        let params = [
            ("include_entities", "true"),
            ("oauth_consumer_key", sut.consumerKey),
            ("oauth_nonce", nonce),
            ("oauth_signature_method", "HMAC-SHA1"),
            ("oauth_timestamp", timestamp),
            ("oauth_token", sut.token),
            ("oauth_version", "1.0"),
            ("status", "Hello Ladies + Gentlemen, a signed OAuth request!")
        ]
        
        // WHEN
        let result = TwitterBot.Signature.parameterString(params)
        
        // THEN
        XCTAssertEqual(answer, result)
    }
    
    func testSignatureBaseString() throws {
        // ANSWER
        let answer = """
    POST&https%3A%2F%2Fapi.twitter.com%2F1.1%2Fstatuses%2Fupdate.json&include_entities%3Dtrue%26oauth_consumer_key%3Dy3s8IEZoOHIsKxsowepMf9QjP%26oauth_nonce%3DkYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1318622958%26oauth_token%3D1648577864516657152-1cilm2vSkKL89s5DQwnWR1OsakzgD1%26oauth_version%3D1.0%26status%3DHello%2520Ladies%2520%252B%2520Gentlemen%252C%2520a%2520signed%2520OAuth%2520request%2521
    """.trimmingCharacters(in: .whitespaces)
        
        // GIVEN
        let nonce = "kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg"
        let timestamp = "1318622958"
        
        let params = [
            ("include_entities", "true"),
            ("oauth_consumer_key", sut.consumerKey),
            ("oauth_nonce", nonce),
            ("oauth_signature_method", "HMAC-SHA1"),
            ("oauth_timestamp", timestamp),
            ("oauth_token", sut.token),
            ("oauth_version", "1.0"),
            ("status", "Hello Ladies + Gentlemen, a signed OAuth request!")
        ]
        
        let endpoint: TwitterBot.EndPoint = .post
        
        // WHEN
        let result = TwitterBot.Signature.base(.post, endpoint, params)
        
        // THEN
        XCTAssertEqual(result, answer)
        
    }
}
