//
//  TypographyCaseModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import Foundation
import UIKit

enum TypographyTestCaseType: CaseIterable {
    case lineHeight
    case attributedString
    case customFont
}

extension TypographyTestCaseType {
    var title: String {
        switch self {
        case .lineHeight:
            return "LineHeight"
        case .attributedString:
            return "Font Style"
        case .customFont:
            return "Custom Font"
        }
    }
}
