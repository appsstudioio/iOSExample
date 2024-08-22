//
//  TypographyCustomFontViewModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/22/24.
//

import Foundation
import Combine

final class TypographyCustomFontViewModel: BaseViewModel {
    
    struct Action {
        var checkValue = PassthroughSubject<(Void), Never>()
    }
    
    struct State {
        var updateUI = PassthroughSubject<(Bool), Never>()
    }

    // MARK: - variables
    var action = Action()
    var state = State()
    let familyFonts = ComponentFontCustomFamilyName.allCases
    let fontLists = ComponentFont.allCases
    var sections: [TypographyCustomFontSectionModel] = []
    var saveModel = TypographyCustomFontSaveModel()

    // MARK: - functions
    override init() {
        super.init()
        binding()
        // makeTestData()
        if let font = SharedPreference.shared.getStringtValue(forKey: .kSettingFontFamilyName) {
            saveModel.font = ComponentFontCustomFamilyName(rawValue: font)
        }
    }
    

    private func binding() {
        action.checkValue.sink { [weak self] isPopup in
            guard let self = self else { return }
            self.state.updateUI.send(self.checkValue())
        }.store(in: &cancellables)
    }

    func checkValue() -> Bool {
        return saveModel.font != nil
    }
}

extension TypographyCustomFontViewModel {
    func setFont(_ font: ComponentFontCustomFamilyName) {
        saveModel.font = font
        SharedPreference.shared.setStringValue(value: font.rawValue, forKey: .kSettingFontFamilyName)
        action.checkValue.send()
    }

    func makeTestData() {
        sections.removeAll()
        fontLists.forEach { sizeT in
            if sizeT.fontSize >= 14 {
                sections.append(TypographyCustomFontSectionModel(font: sizeT, data: "lineheight_test_word_shot".localization))
            }

        }
        action.checkValue.send()
    }
}
