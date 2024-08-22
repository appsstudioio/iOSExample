//
//  TypographyCustomFontViewController.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/22/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class TypographyCustomFontViewController: BaseViewController {
    
    let subViews = TypographyCustomFontView()
    let viewModel = TypographyCustomFontViewModel()

    override func loadView() {
        super.loadView()
        setupUI()
    }

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        setBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // AnalyticsManager.setScreenName(screenName: TypographyCustomFont, screenClass: TypographyCustomFontViewController.self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override var hidesBottomBarWhenPushed: Bool {
        get { return true }
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
        
        subViews.headerView.fontSelect.tapItem.sink { [weak self] _ in
            guard let sself = self else { return }
            sself.showFontSelectView()
        }.store(in: &cancellables)
        
        subViews.headerView.searchBtn.tapPublisher.sink { [weak self] _ in
            guard let sself = self else { return }
            sself.viewModel.makeTestData()
        }.store(in: &cancellables)
        
        viewModel.state.updateUI.sink { [weak self] isEnabled in
            guard let sself = self else { return }
            sself.subViews.headerView.updateUI(sself.viewModel.saveModel, isEnabled: isEnabled)
            sself.subViews.tableView.reloadData()
        }.store(in: &cancellables)

    }

    private func setupUI() {
        view.addSubview(subViews)
        setNavigationBarTitle("custom_font".localization)

        subViews.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        subViews.tableView.delegate = self
        subViews.tableView.dataSource = self
        subViews.headerView.updateUI(viewModel.saveModel, isEnabled: true)
    }
}

// MARK: - extensions
extension TypographyCustomFontViewController {
    func handlerSelectFont(_ alert: UIAlertAction) {
        if let selectFont = viewModel.familyFonts.filter({ $0.rawValue == alert.title }).first {
            viewModel.setFont(selectFont)
        }
    }

    func showFontSelectView() {
        var buttons: [UIAlertAction] = []

        viewModel.familyFonts.forEach { familyFont in
            buttons.append(UIAlertAction(title: familyFont.rawValue, style: .default, handler: handlerSelectFont))
        }
        self.onActionSheet(title: "",
                           buttons: buttons,
                           customView: subViews.headerView.fontSelect)
    }
}

extension TypographyCustomFontViewController {

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TypographyCustomFontViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.sections.count > indexPath.section else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TypographyLabelCell.identifier) as? TypographyLabelCell else { return UITableViewCell() }
        cell.updateCustomFont(data: viewModel.sections[indexPath.section])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
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
        guard viewModel.sections.count > section else { return nil }
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BaseTableHeaderView.identifier) as? BaseTableHeaderView else {
            return nil
        }
        let fontType = viewModel.sections[section].font
        header.updateUI(title: String(format: "font_size_title".localization, fontType.fontSize, fontType.weight.weightName))
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
