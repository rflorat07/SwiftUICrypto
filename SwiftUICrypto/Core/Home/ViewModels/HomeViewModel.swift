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
   
    @Published var allCoints: [CoinModel] = []
    @Published var portfolioCoints: [CoinModel] = []
    @Published var statistics: [StatisticModel] = []
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init () {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // Update allCoints
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoints)
            .sink{ [weak self] (returnedCoins) in
                    self?.allCoints = returnedCoins
            }
            .store(in: &cancellable)
        
        // update marketData
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellable)
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
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volumen = StatisticModel(title: "24h Volumen", value: data.volumen)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)

        
        stats.append(contentsOf: [
            marketCap, volumen, btcDominance, portfolioValue
        ])
        
        return stats
    }

}
