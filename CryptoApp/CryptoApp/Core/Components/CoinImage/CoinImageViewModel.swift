//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 21.09.2023.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    
    private let coin: CoinModel
    private var imageSubscription = Set<AnyCancellable>()
    private let dataService: CoinImageService
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            }, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            })
            .store(in: &imageSubscription)
    }
}
