//
//  BaseViewController.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit
import Combine
import SnapKit
import Then
import SafariServices
import MessageUI

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {

    var cancellables: Set<AnyCancellable> = []
    
    override func loadView() {
        super.loadView()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.named(.backgroundGray)
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = .leastNonzeroMagnitude
            UITableView.appearance().fillerRowHeight = .leastNonzeroMagnitude
        }
        hideNavigationLeftButton(hidden: false, target: self, action: #selector(moveBack))
        hideNavigationRightButton(hidden: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func onActionSheet(title: String? = nil,
                       message: String = "",
                       buttons: [UIAlertAction],
                       customView: UIView? ) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        buttons.forEach {
            actionSheet.addAction($0)
        }
        let cancel = UIAlertAction(title: "cancel".localization, style: .cancel, handler: nil)
        actionSheet.addAction(cancel)
        if (UIDevice().userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            actionSheet.popoverPresentationController?.sourceView = customView
            actionSheet.popoverPresentationController?.sourceRect = customView?.frame ?? .zero
            actionSheet.popoverPresentationController?.permittedArrowDirections = []
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - SFSafariViewControllerDelegate
extension BaseViewController: SFSafariViewControllerDelegate {
    func showSafariView(urlString: String, modalPresentationStyle: UIModalPresentationStyle = .overFullScreen) {
        guard let url = URL(string: urlString), url.scheme != nil else {
            DLog(">>> 정상적인 링크가 아닙니다.!! :: \(urlString)", level: .error)
            return
        }

        if url.scheme?.lowercased() == "http" || url.scheme?.lowercased() == "https" {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            safariVC.modalPresentationStyle = modalPresentationStyle
            self.present(safariVC, animated: true)
        } else {
            UIApplication.shared.openURL(url: urlString, completion: nil)
        }
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension BaseViewController: MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }

    func showEmailView(address: [String], subject: String, message: String, isHTML: Bool = false ) {
        if !MFMailComposeViewController.canSendMail() {
            alertWith(title: "alert_tile".localization, message: "mail_none_noti_msg".localization)
            return
        }

        let composeVC = MFMailComposeViewController()
        composeVC.setToRecipients(address)
        composeVC.setSubject(subject)
        composeVC.setMessageBody(message, isHTML: isHTML)
        composeVC.modalPresentationStyle = .overFullScreen
        composeVC.mailComposeDelegate = self
        self.present(composeVC, animated: true, completion: nil)
    }
}
