//
//  ContentView.swift
//  split
//
//  Created by Chrissy on 12/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomePageView()
                .tabItem {
                    Label("計畫", systemImage: "house.fill")
                }.tag(0)
            SettingsView()
                .tabItem {
                    Label("設定", systemImage: "gearshape.fill")
                }.tag(1)
        }
    }
}

#Preview {
    ContentView()
}
