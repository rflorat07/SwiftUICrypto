//
//  CoinImageView.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 25/08/25.
//

import SwiftUI

struct CoinImageView: View {
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    CoinImageView(imageURL: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")
}
