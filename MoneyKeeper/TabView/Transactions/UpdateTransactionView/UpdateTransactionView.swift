//
//  UpdateTransactionView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 9/12/21.
//

import SwiftUI

struct UpdateTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: UpdateTransactionViewModel
    @State private var amount: String = ""
    
    var transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
        self._amount = State(wrappedValue: "\(transaction.amount)") // _amount is State<String>
    }

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Text(transaction.categoryType.defaultName)
                .font(.title)
            Spacer()
            TextField(Constants.spentAmountHint, text: $amount)
                .keyboardType(.decimalPad)
                .frame(height: 48)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.TextField.foreground)
                .accentColor(Color.TextField.accent)
                .background(Color.TextField.background)
                .cornerRadius(16)
                .introspectTextField { textField in
                    textField.becomeFirstResponder()
                    let string = textField.text?.trimmingCharacters(in: CharacterSet(charactersIn: " "))
                    textField.text = string
                }
            Button(action: {
                viewModel.updateTransaction(transactionID: transaction.id, amount: amount)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(Constants.update)
                    .frame(width: 160, height: 48)
                    .font(.title)
                    .foregroundColor(Color.Button.foreground)
                    .background(Color.Button.background)
                    .cornerRadius(16)
            })
            Spacer()
        }
        .padding()
    }
}

struct UpdateTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTransactionView(transaction: Transaction(categoryType: .food))
    }
}
