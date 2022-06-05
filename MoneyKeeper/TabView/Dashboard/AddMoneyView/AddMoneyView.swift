//
//  AddMoneyView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI
import Introspect

struct AddMoneyView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: DashboardViewModel
    @State private var amount: String = ""
    
    var category: Category

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Text(category.name)
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
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.TextField.border, lineWidth: 1)
                )
                .introspectTextField { textField in
                    textField.becomeFirstResponder()
                    let string =  textField.text?.trimmingCharacters(in: CharacterSet(charactersIn: " "))
                    textField.text = string
                }
            Button(action: {
                viewModel.createTransaction(category: category, direction: .outgoing, amount: amount)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(Constants.add)
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

struct AddMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        AddMoneyView(category: Category(type: .food))
    }
}
