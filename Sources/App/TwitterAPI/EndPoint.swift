//
//  File.swift
//  
//
//  Created by Brian Seo on 2023-04-19.
//

import Foundation

extension TwitterBot {
    enum EndPoint: String, CustomStringConvertible {
        var description: String {
            self.rawValue
        }
        
        case post = "https://api.twitter.com/1.1/statuses/update.json"
        case tweet = "https://api.twitter.com/2/tweets"
    }
    
    enum METHOD: String, CustomStringConvertible {
        var description: String {
            self.rawValue
        }
        
        case post = "POST"
        case get = "GET"
    }
}
