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
    
    func removeTimeStamp() -> Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return nil
        }
        return date
    }
}
