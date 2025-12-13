//
//  Created by Chrissy on 12/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            HomePageView(selectedTab: $selection)
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
