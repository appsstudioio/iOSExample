//
//  TypographyTextViewCell.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import UIKit
import SnapKit
import Then
import Combine
//#if DEVELOP
//import SwiftUI
//struct TypographyTextViewCellPreivew: PreviewProvider {
//    static var previews: some View {
//        let view = TypographyTextViewCell()
//        view.updateUI(text: "네네 오전에 피드백 병원에 드려야한다고 규환님께서 말씀해주셨는데~ 개발 수정할 부분이 있어서 그 부분 완료되면 말씀드리려고 했거든요~")
//        return view.preview().frame(width: UIScreen.main.bounds.width, height: 120, alignment: .center)
//    }
//}
//#endif

final class TypographyTextViewCell: UITableViewCell {

    let textView = UITextView().then {
        $0.backgroundColor = UIColor.named(.backgroundGray)
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
        $0.textContainerInset = .zero
    }

    var cancellables = Set<AnyCancellable>()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cancellables = Set<AnyCancellable>()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }

    override func prepareForReuse() {
        cancellables = Set<AnyCancellable>()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        separatorInset = .zero
        layoutMargins = .zero
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        [textView].forEach {
            contentView.addSubview($0)
        }

        textView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.greaterThanOrEqualTo(0)
        }
    }
}

extension TypographyTextViewCell {

    func updateUI(data: TypographyDataModel, font: ComponentFont, boxHeight: Int) {
        textView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.greaterThanOrEqualTo(boxHeight)
        }
        textView.attributedText = data.text.toAttributed(fontType: font, color: UIColor.named(.contentSecondary), lineBreakMode: .byCharWrapping)
    }

    func updateStyleUI(data: TypographyStyleSectionModel) {
        let font = data.font
        let testCase = data.caseType
        let boxHeight = data.boxSize
        let highlightText = data.highlightText
        let attributedText = data.data.toAttributed(fontType: font, color: UIColor.named(.contentSecondary))
        
        textView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.greaterThanOrEqualTo(boxHeight)
        }

        switch testCase {
        case .changeTextColor:
            textView.attributedText = attributedText.changeTextColor(color: UIColor.named(.mainColor), text: highlightText)
        case .changeTextBackgroundColor:
            textView.attributedText = attributedText.changeTextBackgroundColor(color: UIColor.named(.mainColor), text: highlightText)
        case .changeTextFont:
            textView.attributedText = attributedText.changeTextFont(font: UIFont.systemFont(ofSize: data.font.fontSize + 4, weight: .heavy), text: highlightText)
        case .changeTextUnderLine:
            textView.attributedText = attributedText.changeTextUnderLine(text: highlightText)
//        case .changeParagraphStyle:
//            let paragraph = NSMutableParagraphStyle()
//            paragraph.firstLineHeadIndent = 20
//            paragraph.minimumLineHeight = CGFloat(boxHeight)
//            paragraph.maximumLineHeight = CGFloat(boxHeight)
//            textView.attributedText = attributedText.changeParagraphStyle(style: paragraph, text: data.data)
        }
    }
}
