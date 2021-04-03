//
//  Category.swift
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
        case .base(let category):
            self.category = category
        case .add:
            category = Category(name: "Add", color: .gray)
        }
    }
}

enum CategoryType {
    case base(Category)
    case add
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}


