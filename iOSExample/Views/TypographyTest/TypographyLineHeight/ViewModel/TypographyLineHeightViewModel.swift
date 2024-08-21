//
//  TypographyLineHeightViewModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import Foundation
import Combine

final class TypographyLineHeightViewModel: BaseViewModel {

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
    var sections: [TypographySectionModel] = []
    var saveModel = TypographyLineHeightSaveModel()

    // MARK: - functions
    override init() {
        super.init()
        binding()
    }

    private func binding() {
        action.checkValue.sink { [weak self] _ in
            guard let self = self else { return }
            self.state.updateUI.send(self.checkValue())
        }.store(in: &cancellables)
    }

    func checkValue() -> Bool {
        return (saveModel.font != nil && saveModel.boxSize != nil)
    }
}

extension TypographyLineHeightViewModel {
    
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
    
    func makeTestData() {
        sections.removeAll()
        var testData: [TypographyDataModel] = []
        testData.append(self.createTestData(text: "lineheight_test_word_shot".localization))
        testData.append(self.createTestData(text: "lineheight_test_word_long".localization))
        sections.append(TypographySectionModel(font: saveModel.font ?? .r14px, type: .label, boxSize: saveModel.boxSize ?? 14, data: testData))

        testData.removeAll()
        testData.append(self.createTestData(text: "lineheight_test_word_shot".localization))
        testData.append(self.createTestData(text: "lineheight_test_word_long".localization))

        sections.append(TypographySectionModel(font: saveModel.font ?? .r14px, type: .textView, boxSize: saveModel.boxSize ?? 14, data: testData))
        action.checkValue.send()
    }

    private func createTestData(text: String) -> TypographyDataModel {
        return TypographyDataModel(text: text)
    }
}
