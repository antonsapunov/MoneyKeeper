//
//  DashboardView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var viewModel: DashboardViewModel
    @State private var selectedCategory: Category?
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.categories) { category in
                        CategoryItemView(category: category)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                .padding()
                .sheet(item: $selectedCategory) { category in
                    AddMoneyView(category: category)
                        .environmentObject(viewModel)
                }
                Spacer()
            }
            .navigationTitle("Categories")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
