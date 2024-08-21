//
//  TypographyLineHeightModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import Foundation
import UIKit

struct TypographyLineHeightSaveModel {
    var font: ComponentFont?
    var boxSize: Int?
}

enum TypographyTextViewType {
    case label, textView
}

extension TypographyTextViewType {
    var title: String {
        switch self {
        case .label:
            return "uilabel_title".localization
        case .textView:
            return "textview_title".localization
        }
    }
}

typealias TypographyDataModel = TypographySectionModel.DataModel
public struct TypographySectionModel {
    var font: ComponentFont
    var type: TypographyTextViewType
    var boxSize: Int
    var data: [DataModel] = []

    struct DataModel {
        var text: String
    }
}

extension UIFont.Weight  {
    var weightName: String {
        switch self {
        case .ultraLight:
            return "UltraLight"
        case .thin:
            return "Thin"
        case .light:
            return "Light"
        case .regular:
            return "Regular"
        case .medium:
            return "Medium"
        case .semibold:
            return "Semibold"
        case .bold:
            return "Bold"
        case .black:
            return "Black"
        default:
            return "None"
        }
    }
}
