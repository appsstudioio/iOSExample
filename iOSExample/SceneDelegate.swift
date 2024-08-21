//
//  SceneDelegate.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit
import FirebaseRemoteConfig
import Network

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    // MARK: - Network reachability variables
    var pathMonitor: NWPathMonitor?
    var isOnline: Bool = true

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        if let windowScene = (scene as? UIWindowScene) {
            remoteConfigFetch()
            //            FBRemoteConfig.shared.fetch()
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = SplashViewController()
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        startMonitoring()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        stopMonitoring()
    }

    private func remoteConfigFetch() {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 3600
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        remoteConfig.fetch(withExpirationDuration: TimeInterval(3600)) { (status, error) -> Void in
            if status == .success {
                print("=== Config fetched!")
                remoteConfig.activate { (_, error) in
                    print("=== Config fetched! Error: \(error?.localizedDescription ?? "No error available.")")
                }
            } else {
                print("=== Config not fetched Error: \(error?.localizedDescription ?? "No error available.")")
            }

            print("=== \(remoteConfig["TEST_DATA"].stringValue ?? "")")
        }
    }

    deinit {
        stopMonitoring()
    }
}

extension SceneDelegate {
    private func startMonitoring() {
        pathMonitor = NWPathMonitor()
        let monitoringQueue = DispatchQueue(label: "\(CommonUtils.getBundleIdentifier).NetworkConnectivityManager", qos: .utility)
        pathMonitor?.pathUpdateHandler = { path in
            DLog("## >>>> network status :: \(path.status)")
            self.isOnline = (path.status == .satisfied)
//            NotificationCenter.default.post(name: MedisayNotificationList.networkConnectivityDidChange.name, object: path)
        }
        pathMonitor?.start(queue: monitoringQueue)
    }

    private func stopMonitoring() {
        pathMonitor?.cancel()
    }
}

