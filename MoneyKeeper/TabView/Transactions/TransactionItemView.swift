//
//  TransactionItemView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/9/21.
//

import SwiftUI

struct TransactionItemView: View {
    var transaction: Transaction

    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 24, height: 24)
                .overlay(getTransactionImageView(direction: transaction.direction))
                .multilineTextAlignment(.leading)
            Text(transaction.categoryType.defaultName)
                .padding(.leading, 8)
                .multilineTextAlignment(.leading)
            Spacer()
            Text(transaction.amount.formattedWithSeparator(2) + "$")
                .multilineTextAlignment(.trailing)
        }
    }
    
    private func getTransactionImageView(direction: TransactionDirection) -> some View {
        switch direction {
        case .incoming:
            return Image(systemName: "arrow.down.square")
                        .resizable()
                        .frame(width: 20, height: 20)
        case .outgoing:
            return Image(systemName: "arrow.up.square")
                        .resizable()
                        .frame(width: 20, height: 20)
        }
    }
    
}

struct TransactionItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionItemView(
            transaction: Transaction(
                categoryType: .food,
                direction: .outgoing,
                comment: "Test transaction",
                amount: 10,
                currency: "$",
                time: Date()
            )
        )
    }
}