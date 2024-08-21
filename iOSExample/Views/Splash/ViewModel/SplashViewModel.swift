//
//  SplashViewModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import Foundation
import Combine

final class SplashViewModel: BaseViewModel {
    
//    struct Action {
//        var checkValue = PassthroughSubject<(Bool), Never>()
//    }
    
    struct State {
        var updateUI = PassthroughSubject<(Void), Never>()
    }

    // MARK: - variables
//    var action = Action()
    var state = State()
    
    // MARK: - functions
    override init() {
        super.init()
        binding()
    }
    
//    convenience init() {
//        self.init()
//    }

    private func binding() {
//        action.checkValue.sink { [weak self] isPopup in
//            guard let self = self else { return }
//            self.state.checkResult.send(self.checkValue(isPopup))
//        }.store(in: &cancellables)
    }

//    func checkValue(_ isPopup: Bool) -> (Bool, String?) {
//        // return (false, (isPopup ? "1~36 숫자만 입력 가능 합니다." : nil))
//        return (true, (isPopup ? "success" : nil) )
//    }
}

extension SplashViewModel {

}
