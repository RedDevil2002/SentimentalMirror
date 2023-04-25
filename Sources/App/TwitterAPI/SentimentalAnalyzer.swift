//
//  NLPService.swift
//  
//
//  Created by Brian Seo on 2023-04-25.
//

import NaturalLanguage

class SentimentalAnalyzer {
    
    let defaultValue = 0.0
    
    func analyze(_ text: String) -> Double {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        let (sentiment, _) = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)
        guard let value = sentiment?.rawValue, let result = Double(value) else { return defaultValue }
        return result
//        Double(from: sentiment?.rawValue ?? 0.0)
    }
}

