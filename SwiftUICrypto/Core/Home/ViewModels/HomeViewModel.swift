//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 25/08/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoints: [CoinModel] = []
    @Published var portfolioCoints: [CoinModel] = []
    
    init () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoints.append(DeveloperPreview.instance.coin)
            self.portfolioCoints.append(DeveloperPreview.instance.coin)
        }
    }
}
