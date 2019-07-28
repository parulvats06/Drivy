//
//  Double+.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import Foundation

extension Double {
    
    func decimalFormatter(countryCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: countryCode)
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.usesGroupingSeparator = true
        return formatter.string(for: self)!
    }
}
