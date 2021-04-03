//
//  AddMoneyViewModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//



struct AddMoneyViewModel {
    
    func saveTransaction(categoryType: CategoryType, amount: String) {
        if let amountInt = Int(amount) {
            RealmManager.shared.addTransaction(categoryType: categoryType, amount: amountInt)
        }
    }
}
