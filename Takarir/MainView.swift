//
//  MainView.swift
//  Takarir
//
//  Created by Grizenzio Orchivillando on 05/05/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            
            ContentView()
                .tabItem {
                    Label("Generate",
                          systemImage: "film")
                }
            

            SettingsView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
        .padding(.top, 10)
    }
}

#Preview {
    MainView()
}
