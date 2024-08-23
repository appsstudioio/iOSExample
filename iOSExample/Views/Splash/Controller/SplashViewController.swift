//
//  SplashViewController.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class SplashViewController: BaseViewController {
    
    let subViews = SplashView()
    let viewModel = SplashViewModel()

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
//        AnalyticsManager.setScreenName(screenName: "Splash", screenClass: SplashViewController.self)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            guard let windows = UIApplication.key else { return }
            windows.rootViewController = BaseTabBarController()
            windows.makeKeyAndVisible()
        }
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

        // 공통의 서버 에러 팝업 메시지
        /*
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

        viewModel.state.updateUI.sink { _ in
        }.store(in: &cancellables)

    }

    private func setupUI() {
        view.addSubview(subViews)
        setNavigationBarTitle("")

        subViews.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extensions
extension SplashViewController {

}

extension SplashViewController {

}
