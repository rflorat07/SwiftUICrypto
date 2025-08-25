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
    
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init () {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoints = returnedCoins
            }
            .store(in: &cancellable)
    }

}
