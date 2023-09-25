//
//  MarketDataSevice.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 22.09.2023.
//

import Foundation
import Combine

class MarketDataSevice {
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    let jsonDecoder = JSONDecoder()
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: { [weak self] globalData in
                self?.marketData = globalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
