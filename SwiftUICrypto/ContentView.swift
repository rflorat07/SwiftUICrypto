//
//  ContentView.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 22/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                Text("Hello, World!")
                    .font(.largeTitle)
                    .foregroundColor(.theme.accent)
                
                Text("SwiftUI Crypto")
                    .font(.headline)
                    .foregroundColor(.theme.secondaryText)
            }
        }
    }
}

#Preview {
    ContentView()
}
