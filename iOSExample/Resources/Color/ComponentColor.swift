//
//  ComponentColor.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/14/24.
//

import UIKit

public enum ComponentColor: String {
    case backgroundBoxColor
    case backgroundColor
    case backgroundDimm
    case backgroundDisable
    case backgroundGray
    case badgeColor
    case borderDisable
    case borderOpaque
    case borderTransparent
    case contentDisable
    case contentPlaceHolder
    case contentPrimary
    case contentSecondary
    case contentTertiary
    case contentWhite
    case error
    case mainColor
    case replyTagColor
    case shadowColor
    case success
    case textBoxDisable
    case warning
}

extension UIColor {
    public static func named(_ name: ComponentColor) -> UIColor {
        return UIColor(named: name.rawValue) ?? .clear
    }
}
