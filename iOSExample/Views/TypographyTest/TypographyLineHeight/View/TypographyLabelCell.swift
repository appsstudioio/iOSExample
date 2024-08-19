//
//  TypographyLabelCell.swift
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
//struct TypographyLabelCellPreivew: PreviewProvider {
//    static var previews: some View {
//        let view = TypographyLabelCell()
//        view.updateUI(text: "네네 오전에 피드백 병원에 드려야한다고 규환님께서 말씀해주셨는데~ 개발 수정할 부분이 있어서 그 부분 완료되면 말씀드리려고 했거든요~")
//        return view.preview().frame(width: UIScreen.main.bounds.width, height: 120, alignment: .center)
//    }
//}
//#endif

final class TypographyLabelCell: UITableViewCell {

    let label = UILabel().then {
        $0.backgroundColor = UIColor.named(.backgroundGray)
        $0.numberOfLines = 0
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

        [label].forEach {
            contentView.addSubview($0)
        }

        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.greaterThanOrEqualTo(0)
        }
    }
}

extension TypographyLabelCell {

    func updateUI(data: TypographyDataModel, font: ComponentFont) {

        label.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.greaterThanOrEqualTo(font.font.lineHeight)
        }

        label.attributedText = data.text.toAttributed(fontType: font, color: UIColor.named(.contentSecondary), lineBreakMode: .byCharWrapping)
    }
}

