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
            category = Category(type: categoryType, color: Color.yellow)
        case .transport:
            category = Category(type: categoryType, color: Color.blue)
        case .shopping:
            category = Category(type: categoryType, color: Color.green)
        case .entertainment:
            category = Category(type: categoryType, color: Color.red)
        case .service:
            category = Category(type: categoryType, color: Color.gray)
        case .add:
            category = Category(type: categoryType, color: .gray)
        case .custom(let category):
            self.category = category
        }
    }
}
