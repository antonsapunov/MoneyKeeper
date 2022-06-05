//
//  +Color.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/20/21.
//

import SwiftUI

extension Color {

    static let background = Color("background")
    
    enum NavigationButton {
        static let foreground = Color("naviagation_button_foreground")
    }
    
    enum Button {
        static let foreground = Color("button_foreground")
        static let background = Color("button_background")
    }
    
    enum TextField {
        static let accent = Color("textfield_accent")
        static let foreground = Color("textfield_foreground")
        static let background = Color("textfield_background")
        static let border = Color("textfield_border")
    }
    
    enum Icon {
        static let foreground = Color("icon_foreground")
    }
    
    enum Chart {
        static let text = Color("chart_text")
    }
    
    enum CategoryType {
        static let food = Color("category_type_food")
    }
}
