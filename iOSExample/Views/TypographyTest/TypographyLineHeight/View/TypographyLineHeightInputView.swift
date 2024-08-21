//
//  TypographyLineHeightInputView.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/20/24.
//

import UIKit
import SnapKit
import Then

final class TypographyLineHeightInputView: UIView {

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
        $0.setAttributedTitle("search".localization.toAttributed(fontType: .r16px, lineHeight: 0, color: UIColor.named(.contentWhite)), for: .normal)
        $0.setAttributedTitle("search".localization.toAttributed(fontType: .r16px, lineHeight: 0, color: UIColor.named(.contentWhite)), for: .highlighted)
        $0.setAttributedTitle("search".localization.toAttributed(fontType: .r16px, lineHeight: 0, color: UIColor.named(.contentDisable)), for: .disabled)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
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
        [stackView, searchBtn].forEach {
            addSubview($0)
        }
        
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo((34 + 12 + 12))
        }

        [fontSelect, boxHeightSelect].forEach {
            stackView.addArrangedSubview($0)
        }

        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(34)
        }

        searchBtn.snp.makeConstraints {
            $0.centerY.equalTo(stackView.snp.centerY)
            $0.leading.equalTo(stackView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(54)
            $0.height.equalTo(34)
        }

        fontSelect.snp.makeConstraints {
            $0.height.equalTo(34)
        }

        boxHeightSelect.snp.makeConstraints {
            $0.height.equalTo(34)
        }
    }
}

// MARK: - extensions
extension TypographyLineHeightInputView {
    func updateUI(_ data: TypographyLineHeightSaveModel, isEnabled: Bool) {
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

