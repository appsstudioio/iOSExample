//
//  UIViewController+Extension.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import Foundation
import UIKit
import SwiftUI

extension UIViewController {
    #if canImport(SwiftUI) && DEVELOP
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
    
    func preview() -> some View {
        Preview(viewController: self)
    }
    #endif
    
    func addChildVC(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChildVC() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    /**
     화면 터치할 때 키보드 내리기
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    /**
     화면 터치할 때 키보드 내리기
     */
    func hideKeyboardWhenTappedAround(_ targetView: UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        targetView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func alertWith(title: String = "", message: String = "") {
       
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "okay".localization, style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }

    func alertWith(title: String = "", message: String = "", completionHandler: @escaping (Bool) -> Void) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "okay".localization, style: .default, handler: { (_) in
            completionHandler(true)
        }))
        present(alertView, animated: true, completion: nil)
    }

    func showActivityViewController(activityItems: [Any], sourceRect: CGRect, animated: Bool = false, completion: (() -> Void)? = nil) {
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        if #available(iOS 13.2, *) {
            activityVC.popoverPresentationController?.sourceRect = sourceRect
        }
        self.present(activityVC, animated: animated, completion: completion)
    }
}
