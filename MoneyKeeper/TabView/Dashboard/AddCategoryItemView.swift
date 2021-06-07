//
//  AddCategoryItemView.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 4/4/21.
//

//import SwiftUI
//
//struct AddCategoryItemView: View {
//
//    private let category = Category(type: .add, color: .gray)
//    
//    var body: some View {
//        Label {
//            VStack {
//                Text(category.name)
//                    .font(.caption)
//                    .frame(width: 80)
//                    .lineLimit(1)
//                Text("")
//                    .font(.caption)
//                    .frame(width: 80)
//                    .lineLimit(1)
//            }
//        } icon: {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color(category.color))
//                .frame(width: 48, height: 48)
//                .overlay(
//                    Image(uiImage: category.icon)
//                        .resizable()
//                        .foregroundColor(.white)
//                        .frame(width: 24, height: 24)
//                )
//        }
//        .labelStyle(VerticalLabelStyle())
//    }
//}
//
//struct AddCategoryItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCategoryItemView()
//    }
//}
