//
//  ColorCaseViewModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import Foundation
import Combine

final class ColorCaseViewModel: BaseViewModel {

    struct State {
        var updateUI = PassthroughSubject<(Void), Never>()
    }

    // MARK: - variables
    var state = State()
    var lists = ColorTestCaseType.allCases
    
    // MARK: - functions
    override init() {
        super.init()

    }
}
