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
    
    @StateObject var vm: DetailViewModel
    
    private let columns : [GridItem] = Array(repeating: GridItem(.flexible(minimum: 100)), count: 2)
    
    private let spacing: CGFloat = 30
        
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    overviewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                }
                .padding()
                
            } // VStack
            
        } // ScrollView
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailing
            }
        }
    }
}

#Preview {
    NavigationView {
        DetailView(coin: PreviewProvider.dev.coin)
    }
}

extension DetailView {
    
    private var navigationBarTrailing: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            
            
            CoinImageView(imageURL: vm.coin.image)
                .frame(width: 25, height: 25)
            
        } // HStack
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []
        ) {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []
        ) {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
}
