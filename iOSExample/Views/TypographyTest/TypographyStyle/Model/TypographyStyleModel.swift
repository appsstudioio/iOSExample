//
//  TypographyStyleModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/22/24.
//

import Foundation

struct TypographyStyleSaveModel {
    var font: ComponentFont?
    var boxSize: Int?
    var highlightText: String?
}

enum TypographyStyleTestCase: CaseIterable {
    case changeTextColor
    case changeTextBackgroundColor
    case changeTextFont
    case changeTextUnderLine
    // case changeParagraphStyle
}

extension TypographyStyleTestCase {
    var title: String {
        switch self {
        case .changeTextColor:
            return "change_text_color".localization
        case .changeTextBackgroundColor:
            return "change_text_background_color".localization
        case .changeTextFont:
            return "change_text_font".localization
        case .changeTextUnderLine:
            return "change_text_underiine".localization
//        case .changeParagraphStyle:
//            return "change_paragraphstyle".localization
        }
    }
}

public struct TypographyStyleSectionModel {
    var font: ComponentFont
    var caseType: TypographyStyleTestCase
    var boxSize: Int
    var highlightText: String
    var data: String
}
