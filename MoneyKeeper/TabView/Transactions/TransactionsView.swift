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
            VStack {
                ForEach(viewModel.transactions) { transaction in
                    TransactionItemView(transaction: transaction)
                }
                Spacer()
            }
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
