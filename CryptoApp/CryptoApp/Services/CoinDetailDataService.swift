//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 24.09.2023.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: DetailModel? = nil
    var coinDetailSubscription: AnyCancellable?
    let jsonDecoder = JSONDecoder()
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: DetailModel.self, decoder: jsonDecoder)
            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: { [weak self] coin in
                self?.coinDetails = coin
                self?.coinDetailSubscription?.cancel()
            })
    }
}
