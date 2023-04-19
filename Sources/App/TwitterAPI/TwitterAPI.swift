//
//  TwitterKeyChain.swift
//  
//
//  Created by Brian Seo on 2023-04-18.
//

import Vapor

public class TwitterAPI {
    // v.1.1
    static func post(_ content: String) throws {
        let nonce = UUID().uuidString
        let timestamp = String(Int64(Date().timeIntervalSince1970))
        
        let signature = generateSignature(method: .POST, url: EndPointURL.post, nonce: nonce, timestamp: timestamp, content: content)
//        let headers = getHeaders(nonce: nonce, timestamp: timestamp, signature: signature)
//        let uri = getURI(content: content)
    }
    
    static func generateSignature(method: METHOD, url: String, nonce: String, timestamp: String, content: String) -> String {
        let fullString = "POST&\(EndPointURL.post)&"
        [
            "oauth_consumer_key": Credential.apiKey,
            "oauth_nonce": nonce,
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_timestamp": timestamp,
            "oauth_token": Credential.accessToken,
            "oauth_version": "1.0",
            "status": content
        ]
        return ""
    }

    static func getHeaders(nonce: String, timestamp: String, signature: String) -> [String: String] {
        [
            "oauth_consumer_key": Credential.apiKey,
            "oauth_nonce": nonce,
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_timestamp": timestamp,
            "oauth_token": Credential.apiKey,
            "oauth_version": "1.0",
            "oauth_signature": signature
        ]
    }

//    static func getURI(content: String) -> URI {
//        URI(string: EndPointURL.post.appending("?status=\(content.encode())"))
//    }
    
    static func encode(_ content: String) -> String {
        let reserved = CharacterSet(charactersIn: "-._~")
        let allowed: CharacterSet = .alphanumerics.union(reserved)
        return content.addingPercentEncoding(withAllowedCharacters: allowed) ?? content
    }
}

