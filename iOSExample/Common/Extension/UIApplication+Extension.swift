//
//  UIApplication+Extension.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit

extension UIApplication {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            guard self.shared.windows.count > 0 else { return nil }
            return self.shared.windows.first { $0.isKeyWindow }
        } else {
            return self.shared.keyWindow
        }
    }
    
    var safeAreaInsets: UIEdgeInsets {
        if let insets = UIApplication.shared.windows.first?.safeAreaInsets {
            return insets
        } else {
            return .zero
        }
    }
    
    func topViewController(base: UIViewController? = UIApplication.key?.rootViewController) -> UIViewController? {
        if base is UITabBarController {
            let control = base as? UITabBarController
            return topViewController(base: control?.selectedViewController)
        } else if base is UINavigationController {
            let control = base as? UINavigationController
            return topViewController(base: control?.visibleViewController)
        } else if let control = base?.presentedViewController {
            return topViewController(base: control)
        }
        return base
    }
    
    func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                application.open(URL(string: url)!, options: [:], completionHandler: nil)
                return
            }
        }
    }
}
