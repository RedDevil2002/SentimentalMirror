//
//  Post.swift
//  
//
//  Created by Brian Seo on 2023-04-19.
//

import Foundation
import Vapor

extension TwitterBot {
    struct Post: Codable {
        var text: String
        
        func content() -> String {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            guard let data = try? encoder.encode(self) else { return "" }
            guard let content = String(data: data, encoding: String.Encoding.utf8) else { return "" }
            return content
        }
    }
    
    struct Tweet: Content {
        var status: String
    }
}
