//
//  PortfolioDataService.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 03/09/25.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let entityName: String = "PortfolioEntity"
    private let containerName: String = "PortfolioContainer"
    
    @Published var saveEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Error loading Core Data!: \(error)")
            }
            
            self.getPortfolio()
        }
    }
    
    // MARK: - PUBLIC
    
    func updatePortfolio(coint: CoinModel, amount: Double) {
        if let entity = saveEntities.first(where: { $0.coinID == coint.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coint: coint, amount: amount)
        }
    }
    
    
    // MARK: - PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            saveEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching Portfolio Entities: \(error)")
        }
    }
    
    private func add(coint: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coint.id
        entity.amount = amount
        applyChange()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChange()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to Core Data: \(error)")
        }
    }
    
    private func applyChange() {
        save()
        getPortfolio()
    }
}
