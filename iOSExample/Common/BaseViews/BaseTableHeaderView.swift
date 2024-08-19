//
//  BaseTableHeaderView.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import UIKit
import SnapKit
import Then
import Combine

class BaseTableHeaderView: UITableViewHeaderFooterView {

    let titleLabel = UILabel().then {
        $0.numberOfLines = 0
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layoutMargins = .zero
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.named(.backgroundGray)

        let boxView = UIView()
        boxView.backgroundColor = .clear
        contentView.addSubview(boxView)
        [titleLabel].forEach {
            boxView.addSubview($0)
        }

        boxView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.greaterThanOrEqualTo(32)
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(16)
        }
    }
}

extension BaseTableHeaderView {

    func updateUI(title: String) {
        titleLabel.attributedText = title.toAttributed(fontType: .sb14px, color: UIColor.named(.contentPrimary))
    }

    func updateAttributedUI(_ attributedText: NSAttributedString) {
        titleLabel.attributedText = attributedText
    }

}
