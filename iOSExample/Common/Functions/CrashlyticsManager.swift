//
//  CrashlyticsManager.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/14/24.
//

import Foundation
#if canImport(FirebaseCrashlytics)
import Firebase
import FirebaseCrashlytics
#endif

// MARK: - Firebase Crashlytics Event
public class CrashlyticsManager {

    static func setUserInfo(_ userId: String, keysAndValues: [String : Any]) {
#if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().setUserID("\(userId)")
        AnalyticsManager.setUserID(userId)



        Crashlytics.crashlytics().setCustomKeysAndValues(keysAndValues)
#endif
    }

    static func crashlyticLog(_ level: DebugLogLevel = .info,
                                message: String?,
                                param: [String: Any]? = nil,
                                file: String = #file,
                                funcName: String = #function,
                                line: Int = #line) {
#if canImport(FirebaseCrashlytics)
        var userInfo: [String: Any] = [:]
        var nameMsg: String = "[\(level.rawValue)]"
        let fileName = (file as NSString).lastPathComponent

        if let params = param, params.count > 0 {
            for (key, value) in params {
                userInfo[key] = value
            }
        }

        nameMsg += " \(message ?? "nil")"
        let exception = ExceptionModel.init(name: nameMsg, reason: userInfo.toString())
        exception.stackTrace = [
            StackFrame.init(symbol: funcName, file: fileName, line: line)
        ]
        Crashlytics.crashlytics().record(exceptionModel: exception)
#endif
    }
}
