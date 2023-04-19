//
//  Credential.swift
//  
//
//  Created by Brian Seo on 2023-04-19.
//

import Foundation

extension TwitterAPI {
    /// contains necessary credentials to access Twitter API
    struct Credential {
        static let clientSecret = "DYBCObdMEgPMYM0XZTEOmOnOeXlnTNvB3imywpoaS2j1rAnI9b"
        static let clientID = "em05dEJOYU5vcm9QM3VBdzFhNU46MTpjaQ"
        static let accessToken = "1648577864516657152-1cilm2vSkKL89s5DQwnWR1OsakzgD1"
        static let accessTokenSecret = "mewndqHA1e0R1LP8WQ0AY8iX7URksoc9q2ghnoCVeYAOu"
        
        // CONSUMER KEYS
        static let apiKey = "y3s8IEZoOHIsKxsowepMf9QjP"
        static let apiKeySecret = "n7YHL3RO3yptjsFrG3PQHRW1RcbDqjzvusE39myBQjwUDkxwst"
        
        // Bearer Token
        static let bearerToken = "AAAAAAAAAAAAAAAAAAAAAPxVmwEAAAAACAugkDwgJ1jQlY9%2Bki8%2BhrikCe8%3DGgAK0zDKPfagZSLQ62w8BssEnxr79OYZRcxkBwJBvg1t7PSoXo"
        
        static func signingKey() -> String {
            let encodedConsumerSecret = TwitterAPI.encode(apiKeySecret)
            let encodedAccessTokenSecret = TwitterAPI.encode(accessTokenSecret)
            return "\(encodedConsumerSecret)&\(encodedAccessTokenSecret)"
        }
    }
    
    enum METHOD: String {
        case POST
        case GET
    }
}
