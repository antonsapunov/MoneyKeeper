//
//  TabViewScreen.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI
import RealmSwift

struct TabViewScreen: View {
    
    private var realm: Realm!
    
    init() {
        do {
            realm = try Realm()
        } catch let error {
            fatalError("Failed to open Realm. Error: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                }
                .environmentObject(DashboardViewModel())
            TransactionsView()
                .tabItem {
                    Image(systemName: "arrow.left.arrow.right.circle")
                }
                .environmentObject(TransactionViewModel())
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                }
                .environmentObject(StatisticsViewModel())
        }
    }
}
