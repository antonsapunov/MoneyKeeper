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
                .padding(.leading, 16)
                .multilineTextAlignment(.leading)
            Text(transaction.categoryType.defaultName)
                .padding(.leading, 8)
                .multilineTextAlignment(.leading)
            Spacer()
            Text(getTransformedAmount(amount: transaction.amount))
                .padding(.trailing, 16)
                .multilineTextAlignment(.trailing)
        }
    }
    
    private func getTransactionImageView(direction: TransactionDirection) -> some View {
        switch direction {
        case .incoming:
            return Image(uiImage: UIImage(systemName: "arrow.down.square")!)
                        .resizable()
                        .frame(width: 20, height: 20)
        case .outgoing:
            return Image(uiImage: UIImage(systemName: "arrow.up.square")!)
                        .resizable()
                        .frame(width: 20, height: 20)
        }
    }
    
    private func getTransformedAmount(amount: Double) -> String {
        return "\(Double(round(1000*amount)/1000))$"
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
