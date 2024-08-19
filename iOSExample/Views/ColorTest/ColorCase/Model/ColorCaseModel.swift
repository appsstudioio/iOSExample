//
//  ColorCaseModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import Foundation

enum ColorTestCaseType: CaseIterable {
    case colorPalette
}

extension ColorTestCaseType {
    var title: String {
        switch self {
        case .colorPalette:
            return "팔레트"
        }
    }
}
