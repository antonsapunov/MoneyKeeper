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
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(transaction.categoryType.defaultColor))
                .frame(width: 24, height: 24)
                .overlay(Image(uiImage: transaction.categoryType.defaultImage)
                            .resizable()
                            .frame(width: 20, height: 20))
                .padding(.leading, 16)
                .multilineTextAlignment(.leading)
            Text(transaction.categoryType.defaultName)
                .padding(.leading, 8)
                .multilineTextAlignment(.leading)
            Spacer()
            Text("\(transaction.amount)")
                .padding(.trailing, 16)
                .multilineTextAlignment(.trailing)
        }
    }
    
    private func getTransformedAmount(amount: Double) -> String {
        return "\(Double(round(1000*amount)/1000))$"
    }
}

struct TransactionItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionItemView(transaction: Transaction(categoryType: .food, amount: 10, currency: "$", time: Date()))
    }
}
