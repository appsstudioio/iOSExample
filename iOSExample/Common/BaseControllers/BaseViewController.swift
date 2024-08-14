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
            alertWith(title: "알림", message: "메일 앱이 없거나 메일 설정이 되지 않아 사용이 불가능합니다.")
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
