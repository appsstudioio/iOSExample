//
//  Int+Extensions.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import Foundation

extension Int {
    func withCommas(_ locale: Locale = .current) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = locale
        return (numberFormatter.string(from: NSNumber(value: self)) ?? "")
    }
    
    func withCurrencySpellOut(_ locale: Locale = .current) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.spellOut
        numberFormatter.locale = locale
        return (numberFormatter.string(from: NSNumber(value: self)) ?? "")
    }
}

// MARK: - Int64
extension Int64 {
    func withCommas(_ locale: Locale = .current) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = locale
        return (numberFormatter.string(from: NSNumber(value: self)) ?? "")
    }
    
    func withCurrencySpellOut(_ locale: Locale = .current) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.spellOut
        numberFormatter.locale = locale
        return (numberFormatter.string(from: NSNumber(value: self)) ?? "")
    }
}
