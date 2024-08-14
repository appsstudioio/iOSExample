//
//  AnalyticsManager.swift
//  iOSExample
//
//  Created by 10-N3344 on 7/5/24.
//

import Foundation
import UIKit
#if canImport(FirebaseAnalytics)
import Firebase
import FirebaseAnalytics
#endif

public class AnalyticsManager {
    enum AnalyticsEventLogType {
        case joinGroup, login, search, selectContent, share, signUp
    }
    
    enum UserPropertyType: String {
        case none = ""
    }

    static func customLogEvent(eventName: String, parameters: [String: NSObject]) {
#if canImport(FirebaseAnalytics)
        Analytics.logEvent(eventName, parameters: parameters)
#endif
    }

    static func setScreenName(screenName: String, screenClass: AnyClass) {
        // These strings must be <= 36 characters long in order for setScreenName:screenClass: to succeed.
        DLog("==== screenName :: \(screenName) /// screenClass :: \(String(describing: screenClass.self))")
#if canImport(FirebaseAnalytics)
        let parameters = [AnalyticsParameterScreenName: screenName, AnalyticsParameterScreenClass: String(describing: screenClass.self)]
        Analytics.logEvent(AnalyticsEventScreenView, parameters: parameters)
#endif
    }

    // 사용자 속성, 설정값 추적
    // https://firebase.google.com/docs/analytics/user-properties?hl=ko&authuser=0&platform=ios
    static func setUserProperty(value: String, type: UserPropertyType) {
#if RELEASE && canImport(FirebaseAnalytics)
        Analytics.setUserProperty(value, forName: type.rawValue)
#endif
    }

    static func setUserID(_ userId: String) {
#if RELEASE && canImport(FirebaseAnalytics)
        Analytics.setUserID(userId)
#endif
    }
}
