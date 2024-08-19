//
//  TypographyLineHeightViewController.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class TypographyLineHeightViewController: BaseViewController {
    
    let subViews = TypographyLineHeightView()
    let viewModel = TypographyLineHeightViewModel()

    override func loadView() {
        super.loadView()
        setupUI()
    }

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        setBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // AnalyticsManager.setScreenName(screenName: Typography, screenClass: TypographyViewController.self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override var hidesBottomBarWhenPushed: Bool {
        get { return true }
        set { super.hidesBottomBarWhenPushed = newValue }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // Trait collection has already changed
        if #available(iOS 12.0, *) {
            let userInterfaceStyle = self.traitCollection.userInterfaceStyle
            if userInterfaceStyle == .dark {
//               DLog("===== Dark Mode")
            } else {
//               DLog("===== \(userInterfaceStyle.rawValue) Mode")
            }
        }
    }

    // MARK: - functions
    private func setBinding() {

        /*
        // 공통의 서버 에러 팝업 메시지
        viewModel.baseState.apiErrorMessage.sink { [weak self] (isAlert, type, errorMessage) in
            guard let self = self else { return }
            if isAlert {
                self.alertWith(title: "알림", message: errorMessage)
            } else {
                MedisayToastView.show(.error, message: errorMessage)
            }
        }.store(in: &cancellables)

        viewModel.baseState.apiResult.sink { [weak self] (isSuccess, type, data) in
            guard let self = self else { return }
            switch type {
            default:
                break
            }
        }.store(in: &cancellables)
        */

        /*
        NotificationCenter.default
            .publisher(for: MedisayNotificationList.socketCallBack.name)
            .sink { notification in
                // guard let self = self else { return } [weak self]
                if let socketData = notification.userInfo?["socketData"] as? SocketCallBackDataModel {
                    switch socketData.type {
                    default:
                        break
                    }
                }
            }.store(in: &cancellables)

        viewModel.baseState.socketResult.sink { [weak self] (type, data) in
            guard let self = self else { return }
            switch type {
            case .connect:
                DLog(">>>>>>>> connect <<<<<<<<")
            case .reconnect:
                DLog(">>>>>>>> reconnect <<<<<<<<")
            case .joinroom:
                DLog(">>>>>>>> joinroom <<<<<<<<")
            case .disconnect:
                DLog(">>>>>>>> disConnect <<<<<<<<")
            default:
                break;
            }
        }.store(in: &cancellables)
         */

        viewModel.state.updateUI.sink { [weak self] _ in
            self?.subViews.tableView.reloadData()
        }.store(in: &cancellables)

    }

    private func setupUI() {
        view.addSubview(subViews)
        setNavigationBarTitle("타이포그라피".localization)

        subViews.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        subViews.tableView.delegate = self
        subViews.tableView.dataSource = self
    }
}

// MARK: - extensions
extension TypographyLineHeightViewController {

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TypographyLineHeightViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel.sections.count > section else { return 0 }
        return viewModel.sections[section].data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.sections.count > indexPath.section else { return UITableViewCell() }
        guard viewModel.sections[indexPath.section].data.count > indexPath.row else { return UITableViewCell() }
        let font = viewModel.sections[indexPath.section].font
        let data = viewModel.sections[indexPath.section].data[indexPath.row]

        switch data.type {
        case .label:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypographyLabelCell.identifier) as? TypographyLabelCell else { return UITableViewCell() }
            cell.updateUI(data: data, font: font)
            return cell
        case .textView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypographyTextViewCell.identifier) as? TypographyTextViewCell else { return UITableViewCell() }
            cell.updateUI(data: data, font: font)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.sections.count > section else { return nil }
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BaseTableHeaderView.identifier) as? BaseTableHeaderView else {
            return nil
        }
        // \(fontType.font.familyName)
        let fontType = viewModel.sections[section].font
        header.updateUI(title: "폰트 사이즈: \(fontType.fontSize)pt \(fontType.weight.weightName)" )
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
