//
//  CoinRowView.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 25/08/25.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            }
            
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CoinRowView(coin: PreviewProvider.dev.coin, showHoldingsColumn: true)
        
        CoinRowView(coin: PreviewProvider.dev.coin, showHoldingsColumn: true)
            .colorScheme(.dark)
    }
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(imageURL: coin.image )
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)
            
            Spacer()
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(.theme.accent)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(coin.priceChangePercentage24H ?? 0 >= 0 ?
                    .theme.gree :
                    .theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
