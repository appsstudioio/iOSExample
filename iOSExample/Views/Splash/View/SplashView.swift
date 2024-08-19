//
//  SplashView.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import UIKit
import SnapKit
import Then

final class SplashView: UIView {
    
    let helloLabel = UILabel().then {
        $0.text = "Hello iOS Example"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .darkText
        $0.textAlignment = .center
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
extension SplashView {
    
}
