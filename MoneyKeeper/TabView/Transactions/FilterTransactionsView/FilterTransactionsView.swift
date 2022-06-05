//
//  FilterTransactionsView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/5/22.
//

import SwiftUI
import Introspect

struct FilterTransactionsView: View {
    @EnvironmentObject var viewModel: TransactionViewModel
    var isPresented: Binding<Bool>
    @State var startDate: Date
    @State var endDate: Date

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            HStack {
                Spacer()
                VStack {
                    Text("From:")
                    DatePicker(
                        "",
                        selection: $startDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.automatic)
                    .fixedSize()
                }
                Spacer()
                VStack {
                    Text("To:")
                    DatePicker(
                        "",
                        selection: $endDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.automatic)
                    .fixedSize()
                }
                Spacer()
            }
            Button(action: {
                isPresented.wrappedValue.toggle()
                viewModel.filterTransactionsByDate(startDate: startDate, endDate: endDate)
            }, label: {
                Text(Constants.filter)
                    .frame(width: 160, height: 48)
                    .font(.title)
                    .foregroundColor(Color.Button.foreground)
                    .background(Color.Button.background)
                    .cornerRadius(16)
            })
        }
        .padding()
    }
}

enum FilterState {
    case initial
    case set
}

struct FilterTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        FilterTransactionsView(isPresented: .constant(true), startDate: Date.distantPast, endDate: Date())
    }
}
