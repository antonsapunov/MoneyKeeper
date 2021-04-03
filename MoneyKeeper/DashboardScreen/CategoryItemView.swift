//
//  CategoryItemView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/3/21.
//

import SwiftUI

struct CategoryItemView: View {
    var category: Category

    var body: some View {
        Label {
            Text(category.name)
                .font(.caption)
                .frame(width: 60)
                .lineLimit(1)
        } icon: {
            RoundedRectangle(cornerRadius: 20)
                .fill(category.color)
                .frame(width: 60, height: 60)
        }
        .labelStyle(VerticalLabelStyle())
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(category: Category(name: "Preview Testing", color: .blue))
    }
}


