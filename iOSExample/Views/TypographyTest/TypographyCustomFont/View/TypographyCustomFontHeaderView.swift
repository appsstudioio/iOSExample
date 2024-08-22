//
//  TypographyCustomFontHeaderView.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/22/24.
//

import UIKit
import SnapKit
import Then

final class TypographyCustomFontHeaderView: UIView {

    let fontSelect = BaseTextField().then {
        $0.type = .selectBox
        $0.setPlaceholderText("cumstom_font_select_placeholder".localization)
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
        [fontSelect, searchBtn].forEach {
            addSubview($0)
        }

        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.greaterThanOrEqualTo((34 + 12 + 12))
        }

        fontSelect.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            // $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(34)
        }

        searchBtn.snp.makeConstraints {
            $0.centerY.equalTo(fontSelect.snp.centerY)
            $0.leading.equalTo(fontSelect.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(54)
            $0.height.equalTo(34)
        }
    }
}

// MARK: - extensions
extension TypographyCustomFontHeaderView {
    func updateUI(_ data: TypographyCustomFontSaveModel, isEnabled: Bool) {
        searchBtn.isEnabled = isEnabled

        if let font = data.font {
            fontSelect.text = "\(font.rawValue)"
        } else {
            fontSelect.text = nil
        }

    }
}

