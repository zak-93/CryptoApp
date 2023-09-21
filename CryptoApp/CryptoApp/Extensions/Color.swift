//
//  Color.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 21.09.2023.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColorTheme")
    let red = Color("RedColorTheme")
    let secondaryText = Color("SecondaryTextColor")
}
