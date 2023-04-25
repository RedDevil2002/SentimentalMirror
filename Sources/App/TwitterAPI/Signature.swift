//
//  File.swift
//  
//
//  Created by Brian Seo on 2023-04-19.
//

import Foundation
import CommonCrypto

extension String {
    var percentEncoded: String {
        let reserved = CharacterSet(charactersIn: "-._~")
        let allowed: CharacterSet = .alphanumerics.union(reserved)
        return self.addingPercentEncoding(withAllowedCharacters: allowed) ?? self
    }
    
    func sign(with key: String) -> String {
        let length = Int(CC_SHA1_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), key, key.count, self, self.count, &digest)
        let sig = Data(bytes: digest, count: length)
        return sig.base64EncodedString()
    }
}

extension TwitterBot {
    
    struct Signature {
        static func parameterString(_ params: [(String, String)]) -> String {
            let sortedParams = params.sorted{ $0.0 < $1.0 }
            
            var result: String = ""
            var first = true
            for param in sortedParams {
                if !first {
                    result.append("&")
                }
                result.append(param.0.percentEncoded)
                result.append("=")
                result.append(param.1.percentEncoded)
                
                first = false
            }
            return result
        }
                
        static func base(_ method: METHOD, _ endpoint: EndPoint, _ params: [(String, String)]) -> String {
            
            let methodString = String(describing: method)
            let encodedURL = String(describing: endpoint).percentEncoded
            let encodedParameters = parameterString(params).percentEncoded
            
            return "\(methodString)&\(encodedURL)&\(encodedParameters)"
        }
        
        static func signingKey(consumerSecret: String, accessTokenSecret: String) -> String {
            let encodedConsumerSecret = consumerSecret.percentEncoded
            let encodedAccessTokenSecret = accessTokenSecret.percentEncoded
            return "\(encodedConsumerSecret)&\(encodedAccessTokenSecret)"
        }
        
        // Secrets (consumerSecret, accessTokenSecret)
        static func get(_ method: METHOD, _ endpoint: EndPoint, _ params: [(String, String)], _ secrets: (String, String) = (Credential.consumerSecret, Credential.tokenSecret)) -> String {
            let base = Signature.base(method, endpoint, params)
            let signingKey = signingKey(consumerSecret: secrets.0, accessTokenSecret: secrets.1)
            
            let signature = base.sign(with: signingKey)
            return signature
        }
    }
}
