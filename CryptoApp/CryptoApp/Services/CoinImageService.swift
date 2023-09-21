//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 21.09.2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.shared
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let saveImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = saveImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image ) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleComplition, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadImage = returnedImage else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadImage, imageName: imageName, folderName: folderName)
            })
    }
}
