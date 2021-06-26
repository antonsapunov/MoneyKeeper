//
//  TransactionsView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/8/21.
//

import SwiftUI

struct TransactionsView: View {
    
    @EnvironmentObject var viewModel: TransactionViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(viewModel.transactionsByDate.keys.sorted(by: >)), id: \.self) { date in
                    Section(header: Text(date)) {
                        if let transactions = viewModel.transactionsByDate[date] {
                            ForEach(transactions) { transaction in
                                TransactionItemView(transaction: transaction)
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.top, 16)
            .navigationTitle(Constants.transactions)
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
