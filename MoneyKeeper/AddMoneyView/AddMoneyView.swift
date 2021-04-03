//
//  AddMoneyView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

struct AddMoneyView: View {
    @Environment(\.presentationMode) var presentationMode
    var category: Category

    var body: some View {
        Button(category.name) {
            presentationMode.wrappedValue.dismiss()
        }
        .font(.title)
        .padding()
        .background(Color.black)
    }
}
