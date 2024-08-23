//
//  UIViewController+Extension.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/14/24.
//

import Foundation
import UIKit
import Combine
import Photos
import PhotosUI

// MARK: - Alert
extension UIViewController {
    func alertWith(title: String = CommonUtils.getAppName,
                   message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "ok".localization, style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }

    func alertConfirmWith(title: String = CommonUtils.getAppName,
                          message: String,
                          cancleButton: String = "cancel".localization,
                          okayButton: String = "ok".localization,
                          cancleButtonStyle: UIAlertAction.Style = .cancel,
                          okayButtonStyle: UIAlertAction.Style = .default,
                          completionHandler: @escaping (Bool) -> Void) {
        var titleStr = title
        if titleStr == "" {
            titleStr = CommonUtils.getAppName
        }

        let alertView = UIAlertController(title: titleStr, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: cancleButton, style: cancleButtonStyle, handler: { (_) in
            completionHandler(false)
        }))
        alertView.addAction(UIAlertAction(title: okayButton, style: okayButtonStyle, handler: { (_) in
            completionHandler(true)
        }))
        present(alertView, animated: true, completion: nil)
    }

    func alertWith(title: String = CommonUtils.getAppName,
                   message: String,
                   okayButton: String = "ok".localization,
                   completionHandler: @escaping (Bool) -> Void) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "ok".localization, style: .default, handler: { (_) in
            completionHandler(true)
        }))
        present(alertView, animated: true, completion: nil)
    }
}

// MARK: - BaseViewController Functions
extension UIViewController {
    func showActivityViewController(activityItems: [Any], sourceRect: CGRect, animated: Bool = false, completion: (() -> Void)? = nil) {
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        if #available(iOS 13.2, *) {
            activityVC.popoverPresentationController?.sourceRect = sourceRect
        }
        self.present(activityVC, animated: animated, completion: completion)
    }

    func showCameraView(allowsEditing: Bool = false, mediaTypes: [String] = []) {

       DispatchQueue.main.async {
           let imagePicker = UIImagePickerController()
           imagePicker.sourceType = .camera
           imagePicker.showsCameraControls = true
           if mediaTypes.count == 0 {
               if #available(iOS 14.0, *) {
                   imagePicker.mediaTypes = [UTType.image.identifier]
               } else {
                   imagePicker.mediaTypes = ["public.image"]
               }
           } else {
               imagePicker.mediaTypes = mediaTypes
               imagePicker.videoMaximumDuration = 60
               imagePicker.videoQuality = .typeMedium
           }
           imagePicker.allowsEditing = allowsEditing
           imagePicker.delegate = self as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
           imagePicker.modalPresentationStyle = .overFullScreen
           self.present(imagePicker, animated: true)
       }

    }

    @available(iOS 14.0, *)
    func showMutiSelectionPhotoView(selectionLimit: Int, filter: [PHPickerFilter]?) {
        CommonUtils.photoLibraryPermissionCheck(isReadFlag: true) { isAccess, status in
            switch status {
            case .authorized, .limited:
                DispatchQueue.main.async { [weak self] in
                    var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                    configuration.selectionLimit = selectionLimit
                    if let filter = filter {
                        configuration.filter = .any(of: filter)
                    }
                    let picker = PHPickerViewController(configuration: configuration)
                    picker.delegate = (self as? PHPickerViewControllerDelegate)
                    picker.modalPresentationStyle = .overFullScreen
                    self?.present(picker, animated: true)
                }
            default:
                self.alertWith(message: "photo_access_noti_msg".localization)
                break
            }
        }
    }

    func showImagePickerView(allowsEditing: Bool = false, mediaTypes: [String] = []) {
        CommonUtils.photoLibraryPermissionCheck(isReadFlag: true) { isAccess, status in
            switch status {
            case .authorized, .limited:
                DispatchQueue.main.async {
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .photoLibrary
                    if mediaTypes.count == 0 {
                        if #available(iOS 14.0, *) {
                            imagePicker.mediaTypes = [UTType.image.identifier]
                        } else {
                            imagePicker.mediaTypes = ["public.image"]
                        }
                    } else {
                        imagePicker.mediaTypes = mediaTypes
                    }
                    imagePicker.allowsEditing = allowsEditing
                    imagePicker.delegate = self as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
                    imagePicker.modalPresentationStyle = .overFullScreen
                    self.present(imagePicker, animated: true)
                }
            default:
                self.alertWith(message: "photo_access_noti_msg".localization)
                break
            }
        }
    }

    func hideNavigationLeftButton(hidden: Bool,
                                  target: Any? = nil,
                                  action: Selector? = nil){
        if hidden {
            self.navigationItem.setLeftBarButton(nil, animated: true)
        } else {
            var backImage: UIImage? = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysTemplate)
            if (self.presentingViewController != nil) {
                if navigationController?.viewControllers.count == 1 || navigationController == nil {
                    backImage = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
                }
            }
            navigationItem.hidesBackButton = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: backImage?.resized(to: CGSize(width: 24, height: 24)),
                style: .plain,
                target: target,
                action: action
            )
        }
    }

    func hideNavigationRightButton(hidden: Bool,
                                   image: UIImage? = nil,
                                   target: Any? = nil,
                                   action: Selector? = nil){
        if hidden {
            self.navigationItem.setRightBarButton(nil, animated: true)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: image?.resized(to: CGSize(width: 24, height: 24)),
                style: .plain,
                target: target,
                action: action
            )
        }
    }

    func hideNavigationLeftButton(hidden: Bool,
                                  button: UIButton,
                                  buttonSize: CGSize) {
        if hidden {
            self.navigationItem.setLeftBarButton(nil, animated: true)
        } else {
            button.frame = CGRectMake(0, 0, buttonSize.width, buttonSize.height)
            navigationItem.leftBarButtonItem = UIBarButtonItem.buttonToBarButtonItem(button)
        }
    }

    func hideNavigationRightButton(hidden: Bool, button: UIButton, buttonSize: CGSize) {
        if hidden {
            self.navigationItem.setRightBarButton(nil, animated: true)
        } else {
            button.frame = CGRectMake(0, 0, buttonSize.width, buttonSize.height)
            navigationItem.rightBarButtonItem = UIBarButtonItem.buttonToBarButtonItem(button)
        }
    }

    func setNavigationBarTitle(_ titleText: String = "") {
        self.navigationItem.title = titleText
    }

    func hideNavigationBar(hidden: Bool, animate: Bool = true, titleText: String = "") {
        hideNavigationBar(hidden: hidden, animate: animate)
        if hidden == false && titleText != "" {
            setNavigationBarTitle(titleText)
        }
    }

    func setNavigationBarStyle(_ backgroundColor: UIColor, fontColor foregroundColor: UIColor) {
        navigationController?.navigationBar.setNavigationBarStyle(backgroundColor, fontColor: foregroundColor)
    }

    func hideNavigationBar(hidden: Bool,
                           animate: Bool = true) {
        self.navigationController?.setNavigationBarHidden(hidden, animated: animate)
    }

    func setDefaultNavigationBarStyle() {
        navigationController?.navigationBar.setDefaultNavigationBarStyle()
    }

    // https://eunjin3786.tistory.com/409
    func presentNaviView(_ viewVC: UIViewController,
                     modalStyle: UIModalPresentationStyle = .fullScreen,
                     animated: Bool = true) {
        self.presentView(BaseNavigationController(rootViewController: viewVC), modalStyle: modalStyle, animated: animated)
    }

    func presentView(_ viewVC: UIViewController,
                     modalStyle: UIModalPresentationStyle = .overFullScreen,
                     animated: Bool = true) {
        viewVC.modalPresentationStyle = modalStyle
        self.present(viewVC, animated: animated)

    }

    func pushView(_ moveVC: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(moveVC, animated: animated)
    }

    func popView(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }

    func dismissModalView(_ animated: Bool = true) {
        self.dismiss(animated: animated)
    }

    func dismissAllControllers(_ animated: Bool = true) {
        guard let rootVC = UIApplication.key?.rootViewController else { return }
        rootVC.dismiss(animated: animated, completion: nil)
    }

    @objc func moveBack(_ animated: Bool = true) {
        if self.presentingViewController != nil {
            if navigationController?.viewControllers.count == 1 || navigationController == nil {
                self.dismissModalView()
                return
            }
        }
        self.popView(animated: true)
    }
}
