//
//  TypographyLineHeightViewModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import Foundation
import Combine

final class TypographyLineHeightViewModel: BaseViewModel {

    //    struct Action {
    //        var checkValue = PassthroughSubject<(Bool), Never>()
    //    }

        struct State {
            var updateUI = PassthroughSubject<(Void), Never>()
        }

        // MARK: - variables
    //    var action = Action()
        var state = State()
        var sections: [TypographySectionModel] = []
        // MARK: - functions
        override init() {
            super.init()
            createSection()
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

extension TypographyLineHeightViewModel {
    private func createTestData(type: TypographyTextViewType, text: String) -> TypographyDataModel {
        return TypographyDataModel(type: type, text: text)
    }

    private func createSection() {
        sections = ComponentFont.allCases.map { fontType in
            var testData: [TypographyDataModel] = []
            testData.append(self.createTestData(type: .label, text: "작은 변화가 큰 기적을 만든다."))
            testData.append(self.createTestData(type: .label, text: "매일 조금씩 성장하자. 어제보다 나은 오늘을 만들기 위해, 그리고 내일은 더 밝게 빛나기 위해. 도전은 두렵지만, 그 두려움 속에서 우리는 진정한 자신을 발견한다. 실패는 배움의 시작일 뿐, 성공으로 가는 길의 일부다."))
            testData.append(self.createTestData(type: .textView, text: "작은 변화가 큰 기적을 만든다."))
            testData.append(self.createTestData(type: .textView, text: "매일 조금씩 성장하자. 어제보다 나은 오늘을 만들기 위해, 그리고 내일은 더 밝게 빛나기 위해. 도전은 두렵지만, 그 두려움 속에서 우리는 진정한 자신을 발견한다. 실패는 배움의 시작일 뿐, 성공으로 가는 길의 일부다."))
            return TypographySectionModel(font: fontType, data: testData)
        }
        state.updateUI.send()
    }
}
