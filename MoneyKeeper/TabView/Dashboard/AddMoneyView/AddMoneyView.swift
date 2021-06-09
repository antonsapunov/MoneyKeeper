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
            TextField("Spent Amount", text: $amount)
                .keyboardType(.decimalPad)
                .frame(height: 48)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .accentColor(.white)
                .background(Color.gray)
                .cornerRadius(16)
                .introspectTextField { textField in
                    textField.becomeFirstResponder()
                    let string =  textField.text?.trimmingCharacters(in: CharacterSet(charactersIn: " "))
                    textField.text = string
                }
            Button(action: {
                viewModel.createTransaction(category: category, amount: amount)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("ADD")
                    .frame(width: 160, height: 48)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.green)
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
