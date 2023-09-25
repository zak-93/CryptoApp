//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 22.09.2023.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText = ""
    @State private var showCheckmark = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0, content: {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    
                    if (selectedCoin != nil) {
                        portfolioInputSection
                    }
                })
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavBarButton
                }
            })
            .onChange(of: viewModel.searchText, perform: { value in
                if value == "" {
                    removeSelectedCoin()
                }
            })
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.shared.homeViewModel)
}


extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing:10, content: {
                ForEach(viewModel.searchText.isEmpty ? viewModel.portfolioCoins : viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        }
                }
            })
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20, content: {
            HStack(content: {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):  )")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            })
            Divider()
            HStack {
                Text("Amount in your portfolio:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        })
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin, let amount = Double(quantityText) else { return }
        viewModel.updatePortfolio(coin: coin, amount: amount)
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}
