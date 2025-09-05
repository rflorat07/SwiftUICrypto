//
//  SettingsView.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 05/09/25.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/@SwiftfulThinking")!
    let coffeeURL  = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://rogerflorat.com")!
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                swiftfulThinkingSection
                coinGeckoSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismiss: dismiss)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}


extension SettingsView {
    
    private var swiftfulThinkingSection: some View {
        Section(header: Text("Swiftful Thinking")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
                
            } // VStack
            .padding(.vertical)
            
            Link("Subscribe on YouTube 🥳", destination: youtubeURL)
            
            Link("Support his coffee addiction ☕️", destination: coffeeURL)
            
            
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame( height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may by slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
                
            } // VStack
            .padding(.vertical)
            
            Link("Visit CoinGecko 🦎", destination: coingeckoURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developed by Roger Florat. It uses SwiftUI an is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistence.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
                
            } // VStack
            .padding(.vertical)
            
            Link("Visit Website 🤙", destination: personalURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
    
}
