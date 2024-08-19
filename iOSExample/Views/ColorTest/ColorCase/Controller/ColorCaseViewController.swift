//
//  ColorCaseViewController.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class ColorCaseViewController: BaseViewController {
    
    let subViews = ColorCaseView()
    let viewModel = ColorCaseViewModel()

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
        // AnalyticsManager.setScreenName(screenName: ColorCase, screenClass: ColorCaseViewController.self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override var hidesBottomBarWhenPushed: Bool {
        get { return false }
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
        setNavigationBarTitle("컬러".localization)

        subViews.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        subViews.tableView.delegate = self
        subViews.tableView.dataSource = self
    }
}

// MARK: - extensions
extension ColorCaseViewController {

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ColorCaseViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier) else { return UITableViewCell() }

        cell.backgroundColor = UIColor.named(.backgroundColor)
        cell.textLabel?.attributedText = viewModel.lists[indexPath.row].title.toAttributed(fontType: .sb15px, color: UIColor.named(.contentPrimary))

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
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
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
