//
//  CategoryData.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import Foundation
import SwiftUI

var categoryData: [Category] = [
    CategoryModel(categoryType: .base(Category(name: "Food", color: Color.yellow))).category,
    CategoryModel(categoryType: .base(Category(name: "Transport", color: Color.blue))).category,
    CategoryModel(categoryType: .base(Category(name: "Shopping", color: Color.green))).category,
    CategoryModel(categoryType: .base(Category(name: "Entertainment", color: Color.red))).category,
    CategoryModel(categoryType: .base(Category(name: "Service", color: Color.gray))).category
]
