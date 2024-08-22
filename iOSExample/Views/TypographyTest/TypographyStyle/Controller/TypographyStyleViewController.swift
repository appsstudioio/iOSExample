//
//  TypographyStyleViewController.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/22/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class TypographyStyleViewController: BaseViewController {
    
    let subViews = TypographyStyleView()
    let viewModel = TypographyStyleViewModel()

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
        // AnalyticsManager.setScreenName(screenName: TypographyStyle, screenClass: TypographyStyleViewController.self)
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

        subViews.headerView.boxHeightSelect.tapItem.sink { [weak self] _ in
            guard let sself = self else { return }
            sself.showBoxHegihtSelectView()
        }.store(in: &cancellables)

        subViews.headerView.searchBtn.tapPublisher.sink { [weak self] _ in
            guard let sself = self else { return }
            sself.viewModel.makeTestData()
        }.store(in: &cancellables)

        subViews.headerView.highlightInput.textPublisher.sink { [weak self] txt in
            guard let sself = self, let text = txt else { return }
            sself.viewModel.setHighlightText(text)
        }.store(in: &cancellables)

        viewModel.state.updateUI.sink { [weak self] isEnabled in
            guard let sself = self else { return }
            sself.subViews.headerView.updateUI(sself.viewModel.saveModel, isEnabled: isEnabled)
            sself.subViews.tableView.reloadData()
        }.store(in: &cancellables)

    }

    private func setupUI() {
        view.addSubview(subViews)
        setNavigationBarTitle("font_style".localization)

        subViews.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        subViews.tableView.delegate = self
        subViews.tableView.dataSource = self
    }
}

// MARK: - extensions
extension TypographyStyleViewController {
    func handlerSelectFontSize(_ alert: UIAlertAction) {
        if let selectFont = viewModel.fontLists.filter({ "\($0.fontSize)pt \($0.weight.weightName)" == alert.title }).first {
            viewModel.setFont(selectFont)
        }
    }

    func showFontSelectView() {
        var buttons: [UIAlertAction] = []

        viewModel.fontLists.forEach { font in
            buttons.append(UIAlertAction(title: "\(font.fontSize)pt \(font.weight.weightName)", style: .default, handler: handlerSelectFontSize))
        }
        self.onActionSheet(title: "",
                           buttons: buttons,
                           customView: subViews.headerView.fontSelect)
    }

    func handlerSelectBoxHeight(_ alert: UIAlertAction) {
        if let selectHeight = viewModel.boxSizeLists.filter({ "\($0)" == alert.title }).first {
            viewModel.setBoxSize(selectHeight)
        }
    }

    func showBoxHegihtSelectView() {
        guard viewModel.boxSizeLists.count > 0 else {
            self.alertWith(message: "font_size_noti_msg".localization)
            return
        }
        var buttons: [UIAlertAction] = []

        viewModel.boxSizeLists.forEach { size in
            buttons.append(UIAlertAction(title: "\(size)", style: .default, handler: handlerSelectBoxHeight))
        }
        self.onActionSheet(title: "",
                           buttons: buttons,
                           customView: subViews.headerView.fontSelect)
    }
}

extension TypographyStyleViewController {

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TypographyStyleViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel.sections.count > section else { return 0 }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.sections.count > indexPath.section else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TypographyTextViewCell.identifier) as? TypographyTextViewCell else { return UITableViewCell() }
        cell.updateStyleUI(data: viewModel.sections[indexPath.section])
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
        let type = viewModel.sections[section].caseType
        header.updateUI(title: "\(type.title)")
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
