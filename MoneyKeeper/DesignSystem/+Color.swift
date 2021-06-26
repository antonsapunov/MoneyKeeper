//
//  +Color.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/20/21.
//

import SwiftUI

extension Color {

    static let background = Color("background")
    
    enum Button {
        static let foreground = Color("button_foreground")
        static let background = Color("button_background")
    }
    
    enum TextField {
        static let foreground = Color("textfield_foreground")
        static let accent = Color("textfield_accent")
        static let background = Color("textfield_background")
    }
    
    enum Icon {
        static let foreground = Color("icon_foreground")
    }
    
    enum Chart {
        static let lines = Color("chart_lines")
    }
}
