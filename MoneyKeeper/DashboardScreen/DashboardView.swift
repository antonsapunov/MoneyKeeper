//
//  DashboardView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var selectedCategory: Category?
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)
    private let addCategory = CategoryModel(categoryType: .add).category
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(categoryData, id: \.id) { category in
                        CategoryItemView(category: category)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                    CategoryItemView(category: addCategory)
                        
                    .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                }
                .padding()
                .sheet(item: $selectedCategory) { category in
                    AddMoneyView(category: category)
                }
                Spacer()
            }
            .navigationTitle("Categories")
            .toolbar {
                Button(action: {
                    print(1)
                }) {
                    Image(systemName: "plus")
                        .accessibilityLabel("User Profile")
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
        }
    }
}
