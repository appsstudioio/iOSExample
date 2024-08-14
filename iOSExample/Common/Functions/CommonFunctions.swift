//
//  CommonFunctions.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/14/24.
//

import Foundation
import UIKit
#if canImport(Firebase)
@_exported import CommonUtils
#endif
#if canImport(SnapKit)
@_exported import SnapKit
#endif
#if canImport(Then)
@_exported import Then
#endif
#if canImport(Network)
@_exported import Network
#endif

func DLog(_ message: Any? = "",
          level: DebugLogLevel = .info,
          file: String = #file,
          funcName: String = #function,
          line: Int = #line,
          param: [String: Any] = [:]) {
#if DEVELOP
    DebugLog(message, level: level, file: file, funcName: funcName, line: line, param: param)
#else
    if level == .error {
        let logMessage = message
        let reasonParam: [String: Any] = param
        CrashlyticsManager.crashlyticLog(.error,
                                         message: logMessage as? String,
                                         param: reasonParam,
                                         file: file,
                                         funcName: funcName,
                                         line: line)
    }

#endif
}

class CommonFunctions {
    static func showAlertGoToSetting() {
        guard let viewVC = UIApplication.shared.topViewController() else { return }
        viewVC.alertConfirmWith(title: "알림",
                                message: "현재 카메라 사용에 대한 접근 권한이 없습니다.\n설정에서 접근을 활성화 할 수 있습니다.",
                                cancleButton: "닫기",
                                okayButton: "설정") { isOkay in
            if isOkay {
                CommonUtils.openSetting()
            }
        }
    }
}
