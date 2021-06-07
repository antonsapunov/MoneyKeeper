//
//  TransactionsView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/8/21.
//

import SwiftUI

struct TransactionsView: View {
    
    @EnvironmentObject var viewModel: DashboardViewModel
    
    var body: some View {
        NavigationView {
            ForEach(viewModel.categories, id: \.id) { category in
                VStack {
                    Text(category.name)
                }
            }
            .navigationTitle("Transactions")
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
