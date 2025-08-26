//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 25/08/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoints: [CoinModel] = []
    @Published var portfolioCoints: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init () {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // Update allCoints
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoints)
            .sink{ [weak self] (returnedCoins) in
                    self?.allCoints = returnedCoins
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

}
