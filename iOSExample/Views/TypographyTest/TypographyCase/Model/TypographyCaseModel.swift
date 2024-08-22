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
            return "line_height".localization
        case .attributedString:
            return "font_style".localization
        case .customFont:
            return "custom_font".localization
        }
    }

    var viewVC: UIViewController {
        switch self {
        case .lineHeight:
            return TypographyLineHeightViewController()
        case .attributedString:
            return TypographyStyleViewController()
        case .customFont:
            return UIViewController()
        }
    }
}
