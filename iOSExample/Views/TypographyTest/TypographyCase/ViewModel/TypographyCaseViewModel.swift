//
//  TypographyCaseViewModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import Foundation
import Combine

final class TypographyCaseViewModel: BaseViewModel {

    struct State {
        var updateUI = PassthroughSubject<(Void), Never>()
    }

    // MARK: - variables
    var state = State()
    var lists = TypographyTestCaseType.allCases
    
    // MARK: - functions
    override init() {
        super.init()

    }
}

extension TypographyCaseViewModel {

}
