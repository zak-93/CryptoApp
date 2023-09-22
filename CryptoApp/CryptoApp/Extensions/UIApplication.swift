//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 21.09.2023.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
