//
//  DetailViewModel.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 04/09/25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init (coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails.sink { (returnedCoinDetails) in
            print("RECIEVED COIN DETAIL DATA")
            print(returnedCoinDetails)
        }
        .store(in: &cancellables)
    }
}
