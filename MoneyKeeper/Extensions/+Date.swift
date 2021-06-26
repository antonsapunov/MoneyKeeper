//
//  +Date.swift
//  MoneyKeeper
//
//  Created by Anton Sapunov on 6/26/21.
//

import Foundation

extension Date {
    func transform(with formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
}
