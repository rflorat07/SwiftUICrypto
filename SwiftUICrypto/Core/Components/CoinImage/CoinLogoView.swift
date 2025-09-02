//
//  CoinLogoView.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 02/09/25.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(imageURL: coin.image)
                .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinLogoView(coin: PreviewProvider.dev.coin)
}
