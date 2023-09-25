//
//  String.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 25.09.2023.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
