//
//  BaseTextField.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/20/24.
//

import UIKit
import SnapKit
import Then
import Combine
#if DEVELOP
import SwiftUI
struct BaseTextFieldPreivew: PreviewProvider {
    static var previews: some View {
        let view = BaseTextField()
        view.type = .selectBox
        view.placeholder = "시작일 선택"
        return view.preview().frame(width: 170,
                                    height: 40,
                                    alignment: .center)
    }
}
#endif

class BaseTextField: UITextField {

    enum BaseTextFieldType {
        case calender
        case text
        case selectBox
    }

    var type: BaseTextFieldType = .text {
        didSet {
            self.changeTextFieldStyle()
        }
    }

    override var isEnabled: Bool {
        didSet {
            self.changeStyle()
        }
    }

    override var placeholder: String? {
        didSet {
            let style = NSMutableParagraphStyle()
            style.alignment = .left
            style.lineBreakMode = .byTruncatingTail
            style.firstLineHeadIndent = 10
            let attributes: [NSAttributedString.Key : Any] = [.font: ComponentFont.r14px.font,
                                                              .foregroundColor: UIColor.named(.contentPlaceHolder),
                                                              .paragraphStyle: style]
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
        }
    }

    var tapItem = PassthroughSubject<(Void), Never>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func changeTextFieldStyle() {
        self.borderStyle = .none
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.named(.borderOpaque).cgColor
        self.backgroundColor = UIColor.named(.backgroundColor)
        self.font = ComponentFont.r14px.font
        self.textColor = UIColor.named(.contentPrimary)
        self.allowsEditingTextAttributes = true
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.lineBreakMode = .byTruncatingTail
        style.firstLineHeadIndent = 10
        let attributes: [NSAttributedString.Key : Any] = [.font: ComponentFont.r14px.font,
                                                          .foregroundColor: UIColor.named(.contentPrimary),
                                                          .paragraphStyle: style]
        self.defaultTextAttributes = attributes
        self.typingAttributes = attributes

        switch type {
        case .calender:
            self.addPaddingAndIcon(UIImage(named: "cal")!, padding: 10, isLeftView: false)
            self.rightViewMode = .always
        case .text:
            self.rightView = nil
            self.rightViewMode = .never
        case .selectBox:
            let image = UIImage.getSFSymbolImage(name: "arrowtriangle.down.fill", size: 12, weight: .light, color: UIColor.named(.contentTertiary))
            self.addPaddingAndIcon(image!, padding: 10, isLeftView: false)
            self.rightViewMode = .always
        }
    }

    private func changeStyle() {
        if isEnabled {
            self.backgroundColor = UIColor.named(.backgroundColor)
        } else {
            self.backgroundColor = UIColor.named(.backgroundDisable)
        }
    }
}

extension BaseTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch type {
        case .text:
            self.layer.borderColor = UIColor.named(.mainColor).cgColor
            return true
        default:
            self.tapItem.send()
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.named(.borderOpaque).cgColor
    }
}

extension BaseTextField {

    func setBorder(_ borderColor: UIColor, borderWidth: CGFloat = 1, cornerRadius: CGFloat = 8) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }

    func setPlaceholderText(_ text: String) {
        self.placeholder = text
    }
}

