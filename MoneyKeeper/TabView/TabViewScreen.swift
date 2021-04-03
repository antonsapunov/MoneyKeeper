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
                    Image(systemName: "phone.fill")
                    Text("First Tab")
                }
            StatisticsView()
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Second Tab")
                }
        }
    }
}
