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
                .frame(width: 80)
                .lineLimit(1)
        } icon: {
            RoundedRectangle(cornerRadius: 20)
                .fill(category.color)
                .frame(width: 48, height: 48)
                .overlay(getTransformedImageView())
        }
        .labelStyle(VerticalLabelStyle())
    }
    
    private func getTransformedImageView() -> some View {
        switch category.type {
        case .food:
            return AnyView(category.icon
                            .resizable()
                            .frame(width: 40, height: 40))
        default:
            return AnyView(category.icon
                            .resizable()
                            .frame(width: 24, height: 24))
        }
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(category: Category(type: .food, color: .blue))
    }
}


