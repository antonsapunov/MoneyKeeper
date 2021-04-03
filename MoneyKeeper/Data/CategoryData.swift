//
//  CategoryData.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import Foundation
import SwiftUI

var categoryData: [Category] = [
    CategoryModel(categoryType: .food).category,
    CategoryModel(categoryType: .transport).category,
    CategoryModel(categoryType: .shopping).category,
    CategoryModel(categoryType: .entertainment).category,
    CategoryModel(categoryType: .service).category
]
