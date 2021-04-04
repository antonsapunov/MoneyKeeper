//
//  CategoryModel.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

struct CategoryModel {
    let categoryType: CategoryType
    var category: Category
    
    init(categoryType: CategoryType) {
        self.categoryType = categoryType
        switch categoryType {
        case .food:
            category = Category(type: categoryType, color: .yellow)
        case .transport:
            category = Category(type: categoryType, color: .blue)
        case .shopping:
            category = Category(type: categoryType, color: .green)
        case .entertainment:
            category = Category(type: categoryType, color: .red)
        case .service:
            category = Category(type: categoryType, color: .gray)
        case .add:
            category = Category(type: categoryType, color: .gray)
        case .custom(let category):
            self.category = category
        }
    }
}
