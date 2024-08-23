//
//  TypographyCaseViewController.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class TypographyCaseViewController: BaseViewController {
    
    let subViews = TypographyCaseView()
    let viewModel = TypographyCaseViewModel()

    override func loadView() {
        super.loadView()
        setupUI()
    }

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        setBinding()

        for family in UIFont.familyNames {
            print("### : \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print(">>> : \(name)")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // AnalyticsManager.setScreenName(screenName: TypographyCase, screenClass: TypographyCaseViewController.self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override var hidesBottomBarWhenPushed: Bool {
        get { return false }
        set { super.hidesBottomBarWhenPushed = newValue }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // Trait collection has already changed
        if #available(iOS 12.0, *) {
            let userInterfaceStyle = self.traitCollection.userInterfaceStyle
            if userInterfaceStyle == .dark {
//               DLog("===== Dark Mode")
            } else {
//               DLog("===== \(userInterfaceStyle.rawValue) Mode")
            }
        }
    }

    // MARK: - functions
    private func setBinding() {
        viewModel.state.updateUI.sink { [weak self] _ in
            self?.subViews.tableView.reloadData()
        }.store(in: &cancellables)
    }

    private func setupUI() {
        view.addSubview(subViews)
        hideNavigationLeftButton(hidden: true)
        setNavigationBarTitle("typography".localization)

        subViews.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        subViews.tableView.delegate = self
        subViews.tableView.dataSource = self
    }
}

// MARK: - extensions
extension TypographyCaseViewController {

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TypographyCaseViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.lists.count > indexPath.row else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier) else { return UITableViewCell() }

        cell.backgroundColor = UIColor.named(.backgroundColor)
        cell.textLabel?.attributedText = viewModel.lists[indexPath.row].title.toAttributed(fontType: .sb15px, color: UIColor.named(.contentPrimary))

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard viewModel.lists.count > indexPath.row else { return }
        let type = viewModel.lists[indexPath.row]
        let moveVC = type.viewVC
        self.navigationController?.pushViewController(moveVC, animated: true)
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
