//
//  AppDelegate.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAnalytics
import FirebaseCrashlytics

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupFirebase()
        
        Analytics.setAnalyticsCollectionEnabled(true)
        Crashlytics.crashlytics().checkForUnsentReports { hasUnsentReport in
            let hasUserConsent = false
            // ...get user consent.
            if hasUserConsent && hasUnsentReport {
                Crashlytics.crashlytics().sendUnsentReports()
            } else {
                Crashlytics.crashlytics().deleteUnsentReports()
            }
        }
        
        // Detect when a crash happens during your app's last run.
        if Crashlytics.crashlytics().didCrashDuringPreviousExecution() {
          // ...notify the user.
            print("11 notify the user. didCrashDuringPreviousExecution")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    func setupFirebase() {
        // Firebase service file
        let fileName = Bundle.getInfoPlistValue(forKey: .firebaseServiceFile)
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "plist"),
            let options = FirebaseOptions(contentsOfFile: filePath) {
            print("filePath = \(filePath)")
            FirebaseApp.configure(options: options)
        } else {
            print("filePath = FirebaseApp.configure()")
            FirebaseApp.configure()
        }
    }
}
