//
//  Double+Extensions.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import Foundation

extension Double {
    func toStringCommas(digits: Int = 2) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "ko_KR")
        numberFormatter.roundingMode = .floor
        numberFormatter.minimumFractionDigits = digits
        numberFormatter.maximumFractionDigits = digits
        return (numberFormatter.string(from: NSNumber(value: self)) ?? "")
    }
    
    var toM2: Double {
        return (self * 3.3057)
    }
    
    var toPyeong: Double {
        return (self * 0.3025)
    }
}
