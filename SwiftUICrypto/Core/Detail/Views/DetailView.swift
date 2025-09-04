//
//  DetailView.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 04/09/25.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    let coin: CoinModel
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: PreviewProvider.dev.coin)
}
