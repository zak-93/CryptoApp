//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 22.09.2023.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let persentagerChange: Double?
    
    init(title: String, value: String, persentagerChange: Double? = nil) {
        self.title = title
        self.value = value
        self.persentagerChange = persentagerChange
    }
}

