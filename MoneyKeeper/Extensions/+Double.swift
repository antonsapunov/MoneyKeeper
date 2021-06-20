//
//  +Double.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/10/21.
//

import Foundation

extension Double {    
    func formattedWithSeparator(_ maximumFractionDigits: Int) -> String {
        let numberFormatter = Formatter.withSeparator
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        return numberFormatter.string(for: self) ?? ""
    }
}
