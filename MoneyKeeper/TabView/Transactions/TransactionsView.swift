//
//  TransactionsView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/8/21.
//

import SwiftUI
import PartialSheet

struct TransactionsView: View {
    
    @EnvironmentObject var viewModel: TransactionViewModel
    @State private var isSheetPresented = false
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(viewModel.currentTransactionsByDate.keys.sorted(by: >)), id: \.self) { date in
                    getSection(for: date)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.top, 16)
            .navigationTitle(Constants.transactions)
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    PSButton(
                        isPresenting: $isSheetPresented,
                        label: {
                            Text(Constants.filter)
                        }
                    )
                    .foregroundColor(Color.NavigationButton.foreground)
                    .partialSheet(isPresented: $isSheetPresented) {
                        FilterTransactionsView(isPresented: $isSheetPresented, startDate: viewModel.startDate, endDate: viewModel.endDate)
                            .environmentObject(viewModel)
                    }
                }
            }
            .attachPartialSheetToRoot()
            .sheet(item: $viewModel.transactionForUdpate) { transaction in
                UpdateTransactionView(transaction: transaction)
                    .environmentObject(UpdateTransactionViewModel())
            }
        }
    }
    
    private func getSection(for date: String) -> some View {
        return Section(header: Text(date)) {
            if let transactions = viewModel.currentTransactionsByDate[date] {
                ForEach(transactions) { transaction in
                    getSectionItem(for: transaction)
                }
            }
        }
    }
    
    private func getSectionItem(for transaction: Transaction) -> some View {
        return TransactionItemView(transaction: transaction)
            .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                viewModel.deleteTransaction(by: transaction.id)
            } label: {
                Label(Constants.delete, systemImage: "trash")
            }
            Button {
                viewModel.getTransaction(by: transaction.id)
            } label: {
                Label("Update", systemImage: "pencil")
            }
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
