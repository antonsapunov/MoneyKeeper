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
            VStack {
                Text(category.name)
                    .font(.caption)
                    .frame(width: 80)
                    .lineLimit(1)
                Text(category.amount.formattedWithSeparator(2) + "$")
                    .font(.caption)
                    .frame(width: 80)
                    .lineLimit(1)
            }
        } icon: {
            getTransformedImageView()
                .frame(width: 48, height: 48)
        }
        .labelStyle(VerticalLabelStyle())
    }
    
    private func getTransformedImageView() -> some View {
        switch category.type {
        case .food:
            return AnyView(
                category.icon
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.Icon.foreground)
            )
            
        default:
            return AnyView(
                category.icon
                    .resizable()
                    .frame(width: 24, height: 24)
            )
        }
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(category: Category(type: .entertainment, order: 1))
    }
}
