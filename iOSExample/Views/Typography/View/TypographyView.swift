//
//  TypographyView.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import UIKit
import SnapKit
import Then

final class TypographyView: UIView {
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = UIColor.named(.backgroundColor)
        $0.separatorStyle = .singleLine
        $0.separatorColor = UIColor.named(.borderOpaque)
        $0.separatorInset = .zero
        $0.layoutMargins = .zero
        $0.register(BaseTableHeaderView.self, forHeaderFooterViewReuseIdentifier: BaseTableHeaderView.identifier)
        $0.register(TypographyLabelCell.self, forCellReuseIdentifier: TypographyLabelCell.identifier)
        $0.register(TypographyTextViewCell.self, forCellReuseIdentifier: TypographyTextViewCell.identifier)
        $0.showsVerticalScrollIndicator = true
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = .leastNonzeroMagnitude
        }
        $0.sectionHeaderHeight = .leastNonzeroMagnitude
        $0.sectionFooterHeight = .leastNonzeroMagnitude
        $0.bounces = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }

    // MARK: - init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

    }

//    convenience init(frame: CGRect) {
//        self.init(frame: frame)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - functions
    private func setupUI() {
        backgroundColor = UIColor.named(.backgroundGray)
        [tableView].forEach {
            addSubview($0)
        }

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extensions
extension TypographyView {
    
}
