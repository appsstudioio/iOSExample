//
//  TypographyStyleHeaderView.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/22/24.
//

import UIKit
import SnapKit
import Then

final class TypographyStyleHeaderView: UIView {

    let fontSelect = BaseTextField().then {
        $0.type = .selectBox
        $0.setPlaceholderText("font_select_placeholder".localization)
    }

    let boxHeightSelect = BaseTextField().then {
        $0.type = .selectBox
        $0.setPlaceholderText("box_height_select_placeholder".localization)
        $0.isEnabled = false
    }

    let searchBtn = UIButton(type: .custom).then {
        $0.setBackgroundColor(UIColor.named(.mainColor), for: .normal)
        $0.setBackgroundColor(UIColor.named(.mainColor).withAlphaComponent(0.5), for: .highlighted)
        $0.setBackgroundColor(UIColor.named(.backgroundDisable), for: .disabled)
        $0.setAttributedTitle("test_button_title".localization.toAttributed(fontType: .r16px, lineHeight: 0, color: UIColor.named(.contentWhite)), for: .normal)
        $0.setAttributedTitle("test_button_title".localization.toAttributed(fontType: .r16px, lineHeight: 0, color: UIColor.named(.contentWhite)), for: .highlighted)
        $0.setAttributedTitle("test_button_title".localization.toAttributed(fontType: .r16px, lineHeight: 0, color: UIColor.named(.contentDisable)), for: .disabled)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    let highlightInput = BaseTextField().then {
        $0.type = .text
        $0.setPlaceholderText("hilight_input_placeholder".localization)
    }

    let textView = UITextView().then {
        $0.backgroundColor = UIColor.named(.backgroundColor)
        $0.isUserInteractionEnabled = true
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.scrollsToTop = false
        let dataDetectorTypes = UIDataDetectorTypes(rawValue: UIDataDetectorTypes.link.rawValue +
                                                    UIDataDetectorTypes.address.rawValue +
                                                    UIDataDetectorTypes.calendarEvent.rawValue +
                                                    UIDataDetectorTypes.phoneNumber.rawValue +
                                                    UIDataDetectorTypes.lookupSuggestion.rawValue)
        $0.dataDetectorTypes = dataDetectorTypes
        $0.textContainer.lineFragmentPadding = 0
        $0.contentInset = .zero
        $0.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        $0.attributedText = "lineheight_test_word_long".localization.toAttributed(fontType: .r14px, color: UIColor.named(.contentTertiary))
        $0.layer.borderColor = UIColor.named(.borderOpaque).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
    }

    let stackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 8
    }

    // MARK: - init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - functions
    private func setupUI() {
        backgroundColor = UIColor.named(.backgroundGray)
        [stackView, highlightInput, searchBtn, textView].forEach {
            addSubview($0)
        }

        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.greaterThanOrEqualTo(166)
        }

        [fontSelect, boxHeightSelect].forEach {
            stackView.addArrangedSubview($0)
        }

        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(34)
        }
        
        fontSelect.snp.makeConstraints {
            $0.height.equalTo(34)
        }

        boxHeightSelect.snp.makeConstraints {
            $0.height.equalTo(34)
        }

        highlightInput.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(34)
        }

        searchBtn.snp.makeConstraints {
            $0.centerY.equalTo(highlightInput.snp.centerY)
            $0.leading.equalTo(highlightInput.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(54)
            $0.height.equalTo(34)
        }

        textView.snp.makeConstraints {
            $0.top.equalTo(highlightInput.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
            $0.height.greaterThanOrEqualTo(68)
        }

    }
}

// MARK: - extensions
extension TypographyStyleHeaderView {
    func updateUI(_ data: TypographyStyleSaveModel, isEnabled: Bool) {
        searchBtn.isEnabled = isEnabled
        boxHeightSelect.isEnabled = (data.font != nil)
        if let font = data.font {
            fontSelect.text = "\(font.fontSize)pt \(font.weight.weightName)"
        } else {
            fontSelect.text = nil
        }

        if let boxSize = data.boxSize {
            boxHeightSelect.text = "\(boxSize)"
        } else {
            boxHeightSelect.text = nil
        }
    }
}

