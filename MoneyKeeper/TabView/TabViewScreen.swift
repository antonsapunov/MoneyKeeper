//
//  TabViewScreen.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

struct TabViewScreen: View {
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                }
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                }
        }
    }
}
