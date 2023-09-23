//
//  PorfolioDataService.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 23.09.2023.
//

import Foundation
import CoreData

class PorfolioDataService {
    
    private let conteiner: NSPersistentContainer
    private let containerName: String = "PortfolioConteiner"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        conteiner = NSPersistentContainer(name: containerName)
        conteiner.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try conteiner.viewContext.fetch(request)
        } catch let error{
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: conteiner.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntity) {
        conteiner.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try conteiner.viewContext.save()
        } catch let error{
            print("Error saving to Core Data \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}
