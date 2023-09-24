//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 23.09.2023.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
