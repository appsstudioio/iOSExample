//
//  TypographyStyleViewModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/22/24.
//

import Foundation
import Combine

final class TypographyStyleViewModel: BaseViewModel {
    
    struct Action {
        var checkValue = PassthroughSubject<(Void), Never>()
    }
    
    struct State {
        var updateUI = PassthroughSubject<(Bool), Never>()
    }

    // MARK: - variables
    var action = Action()
    var state = State()
    let fontLists = ComponentFont.allCases
    var boxSizeLists: [Int] = []
    var sections: [TypographyStyleSectionModel] = []
    var saveModel = TypographyStyleSaveModel()

    // MARK: - functions
    override init() {
        super.init()
        binding()
    }

    private func binding() {
        action.checkValue.sink { [weak self] isPopup in
            guard let self = self else { return }
            self.state.updateUI.send(self.checkValue())
        }.store(in: &cancellables)
    }

    func checkValue() -> Bool {
        return (saveModel.font != nil && saveModel.boxSize != nil && saveModel.highlightText != nil && saveModel.highlightText?.stringTrim.count ?? 0 > 0)
    }
}

extension TypographyStyleViewModel {

    func setFont(_ font: ComponentFont) {
        saveModel.font = font
        saveModel.boxSize = nil
        boxSizeLists.removeAll()
        boxSizeLists = fontLists.compactMap({ tmpFont in
            if tmpFont.fontSize >= font.fontSize {
                return Int(tmpFont.fontLineHeight)
            }
            return nil
        })
        boxSizeLists = boxSizeLists.uniqued()
        action.checkValue.send()
    }

    func setBoxSize(_ size: Int) {
        saveModel.boxSize = size
        action.checkValue.send()
    }
    
    func setHighlightText(_ text: String) {
        saveModel.highlightText = text
        action.checkValue.send()
    }

    func makeTestData() {
        sections.removeAll()
        TypographyStyleTestCase.allCases.forEach { testCase in
            sections.append(TypographyStyleSectionModel(font: saveModel.font ?? .r14px,
                                                        caseType: testCase,
                                                        boxSize: saveModel.boxSize ?? 14,
                                                        highlightText: saveModel.highlightText ?? "",
                                                        data: "lineheight_test_word_long".localization))
        }
        action.checkValue.send()
    }

    private func createTestData(text: String) -> TypographyDataModel {
        return TypographyDataModel(text: text)
    }
}
