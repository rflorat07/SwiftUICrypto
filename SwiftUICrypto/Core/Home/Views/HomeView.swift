//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 22/08/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            // Background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // Content layer
            VStack {
                homeHeader
                
                Spacer(minLength: 0)
                
            } // VStack
        } // ZStack
    }
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
}

extension HomeView {
    private var homeHeader : some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" :"Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        } // HStack
        .padding(.horizontal)
    }
}
