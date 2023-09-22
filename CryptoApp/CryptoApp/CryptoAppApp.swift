//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 21.09.2023.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject private var viewModel = HomeViewModel()
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(viewModel)
        }
    }
}
