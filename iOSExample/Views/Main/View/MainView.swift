//
//  MainView.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit
import SnapKit
import Then

final class MainView: UIView {
    
    let helloLabel = UILabel().then {
        $0.text = "Hello iOS Example"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .darkText
        $0.textAlignment = .center
    }
    
    // MARK: - init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - functions
    private func setView() {
        addSubview(helloLabel)
        backgroundColor = .white
        helloLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.greaterThanOrEqualTo(20)
        }
    }
}

// MARK: - extensions
