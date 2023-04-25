//
//  TwitterKeyChain.swift
//  
//
//  Created by Brian Seo on 2023-04-18.
//

import Vapor
import CommonCrypto

public final class TwitterBot {
    
    let sentimentalAnalyzer = SentimentalAnalyzer()
    
    let clientID: String
    let clientSecret: String
    
    let token: String
    let tokenSecret: String
    
    // CONSUMER KEYS
    let consumerKey: String
    let consumerSecret: String
    
    // Bearer Token Useless for standalone Apps
//    let bearerToken = "AAAAAAAAAAAAAAAAAAAAAPxVmwEAAAAACAugkDwgJ1jQlY9%2Bki8%2BhrikCe8%3DGgAK0zDKPfagZSLQ62w8BssEnxr79OYZRcxkBwJBvg1t7PSoXo"
    
    public init(
        clientID: String? = nil,
        clientSecret: String? = nil,
        accessToken: String? = nil,
        accessTokenSecret: String? = nil,
        apiKey: String? = nil,
        apiKeySecret: String? = nil
    ) {
        self.clientID = clientID ?? Credential.clientID
        self.clientSecret = clientSecret ?? Credential.clientSecret
        self.token = accessToken ?? Credential.token
        self.tokenSecret = accessTokenSecret ?? Credential.tokenSecret
        self.consumerKey = apiKey ?? Credential.consumerKey
        self.consumerSecret = apiKeySecret ?? Credential.consumerSecret
    }
}

extension String {
    func hmac(key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), key, key.count, self, self.count, &digest)
        let data = Data(bytes: digest, count: Int(CC_SHA1_DIGEST_LENGTH))
        return data.base64EncodedString()
    }
}

extension TwitterBot {
    func authorizationHeader(_ params: [(String, String)]) -> String {
        var result = ""
        let last = params.last
        for param in params {
            result.append(param.0)
            result.append("=\"")
            result.append(param.1)
            result.append("\"")
            if let last, param != last {
                result.append(",")
            }
        }
        return result
    }
    
    func createTweet(_ status: String) {
        // SETUP
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let nonce = String(letters.shuffled().prefix(11))
        let timestamp = String(Int64(Date().timeIntervalSince1970))
        
        var params = [
            ("oauth_consumer_key", consumerKey),
            ("oauth_token", token),
            ("oauth_signature_method", "HMAC-SHA1"),
            ("oauth_timestamp", timestamp),
            ("oauth_nonce", nonce),
            ("oauth_version", "1.0"),
        ]
        
        let endpoint: TwitterBot.EndPoint = .tweet
        // WHEN
        
        let secrets = (consumerSecret, tokenSecret)
        let signature = TwitterBot.Signature.get(.post, endpoint, params, secrets).percentEncoded
        
        params.append(("oauth_signature", signature))
        let comment = "\(status) (Sentimental Analysis: \(sentimentalAnalyzer.analyze(status)))"
        
        let content = "{\n    \"text\": \"\(comment)\"\n}"
        let contentData = content.data(using: .utf8)
        
        let authorization = authorizationHeader(params)
        
        // HTTPS REQUEST
        var request = URLRequest(url: URL(string: endpoint.description)!, timeoutInterval: Double.infinity)
        
        request.httpMethod = String(describing: METHOD.post)
        request.httpBody = contentData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("OAuth \(authorization)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                print(String(data: data, encoding: .utf8))
            }
            print(response)
        }.resume()
        
        print(request.cURL(pretty: true))
    }
}


import Foundation

extension URLRequest {
    public func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key,value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        
        return cURL
    }
}
