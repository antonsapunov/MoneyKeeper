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
                Text(getTransformedAmount(amount: category.amount))
                    .font(.caption)
                    .frame(width: 80)
                    .lineLimit(1)
            }
        } icon: {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(category.color))
                .frame(width: 48, height: 48)
                .overlay(getTransformedImageView())
        }
        .labelStyle(VerticalLabelStyle())
    }
    
    private func getTransformedAmount(amount: Double) -> String {
        return "\(Double(round(1000*amount)/1000))$"
    }
    
    private func getTransformedImageView() -> some View {
        switch category.type {
        case .food:
            return AnyView(Image(uiImage: category.icon)
                            .resizable()
                            .frame(width: 40, height: 40))
        default:
            return AnyView(Image(uiImage: category.icon)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24))
        }
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(category: Category(type: .entertainment, color: .blue, order: 1))
    }
}
