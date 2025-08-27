//
//  HomeStatsView.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 27/08/25.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    @Binding var showPortafolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            alignment: showPortafolio ? .trailing : .leading
        )
    }
}

#Preview {
    HomeStatsView(showPortafolio: .constant(false))
        .environmentObject(PreviewProvider.dev.homeVM)
}
