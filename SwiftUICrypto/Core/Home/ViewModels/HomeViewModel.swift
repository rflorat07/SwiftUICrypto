//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 25/08/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    
    @Published var allCoints: [CoinModel] = []
    @Published var portfolioCoints: [CoinModel] = []
    @Published var statistics: [StatisticModel] = []
 
    private var cancellable = Set<AnyCancellable>()
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    enum SortOption {
        case rank, rankReversed, price, priceReversed, holdings, holdingsReversed
    }
 
    init () {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // Update allCoints
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoints)
            .sink{ [weak self] (returnedCoins) in
                    self?.allCoints = returnedCoins
            }
            .store(in: &cancellable)
        
        // update portfolioCoins
        $allCoints
            .combineLatest(portfolioDataService.$saveEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoints = self.sortPortfolioCointsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellable)
        
        // update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoints)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellable)
    
    }
    
    func updatePortfolio(coint: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coint: coint, amount: amount)
    }
    
    private func filterAndSortCoints(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoints(text: text, coins: coins)
        
        sortCoints(sort: sort, coins: &updatedCoins)
       
        return updatedCoins
    }
    
    private func sortCoints(sort: SortOption, coins: inout [CoinModel] ) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: {$0.rank < $1.rank})
            
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
            
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
            
        case .priceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioCointsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // will only sort by holdings or reversedholdings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default :
            return coins
        }
    }
    
    private func filterCoints(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = searchText.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoints: [CoinModel], portafolioEntities: [PortfolioEntity]) -> [CoinModel] {
        return allCoints
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portafolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
                
                return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoints: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volumen = StatisticModel(title: "24h Volumen", value: data.volumen)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoints
                                .map({$0.currentHoldingsValue})
                                .reduce(0, +)
        
        let previousValue = portfolioCoints
                                .map { (coin) -> Double in
                                    let currentValue = coin.currentHoldingsValue
                                    let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                                    let previousValue = currentValue / (1 + percentChange)
                                    return previousValue
                                }
                                .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)

        
        stats.append(contentsOf: [
            marketCap, volumen, btcDominance, portfolio
        ])
        
        return stats
    }

}
