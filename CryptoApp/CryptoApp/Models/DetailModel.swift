//
//  DetailModel.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 24.09.2023.
//

import Foundation

struct DetailModel: Identifiable, Decodable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    var readableDestination: String? {
        return description?.en?.removingHTMLOccurances
    }
}

struct Description: Decodable {
    let en: String?
}

struct Links: Decodable {
    let homepage: [String]?
    let subredditURL: String?
}
