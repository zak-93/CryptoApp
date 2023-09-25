//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 25.09.2023.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "")
    let youtubeUrl = URL(string: "")
    let gitUrl = URL(string: "https://github.com/zak-93")!
    let coingeckoURL = URL(string: "https://www.coingecko.com/")!
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                List {
                    myGitSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))

                }
                .listStyle(.grouped)
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var myGitSection: some View {
        Section {
            VStack(alignment: .leading, content: {
                Image("git")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Link to my project on github. it uses MVVM architecture, SwiftUI, Combine and CoreData")
            })
            .padding(.vertical)
            Link("Github", destination: gitUrl)
        } header: {
            Text("Developer")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading, content: {
                Image("coinGecko")
                    .resizable()
                    .scaledToFit()
                Text("The cryptocurrency data that is used in this add comes from a free API from COINGecko! Prices may be slightly delayed.")
            })
            .padding(.vertical)
            Link("CoinGecko", destination: coingeckoURL)
        } header: {
            Text("CoinGecko")
        }
    }

    
}
