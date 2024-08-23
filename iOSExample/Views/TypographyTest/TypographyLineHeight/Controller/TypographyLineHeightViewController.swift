//
//  TypographyLineHeightViewController.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import UIKit
import SnapKit
import Then
import Combine

final class TypographyLineHeightViewController: BaseViewController {
    
    let subViews = TypographyLineHeightView()
    let viewModel = TypographyLineHeightViewModel()

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
        // AnalyticsManager.setScreenName(screenName: Typography, screenClass: TypographyViewController.self)
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

        subViews.headerInputView.fontSelect.tapItem.sink { [weak self] _ in
            guard let sself = self else { return }
            sself.showFontSelectView()
        }.store(in: &cancellables)

        subViews.headerInputView.boxHeightSelect.tapItem.sink { [weak self] _ in
            guard let sself = self else { return }
            sself.showBoxHegihtSelectView()
        }.store(in: &cancellables)
        
        subViews.headerInputView.searchBtn.tapPublisher.sink { [weak self] _ in
            guard let sself = self else { return }
            sself.viewModel.makeTestData()
        }.store(in: &cancellables)

        viewModel.state.updateUI.sink { [weak self] isEnabled in
            guard let sself = self else { return }
            sself.subViews.headerInputView.updateUI(sself.viewModel.saveModel, isEnabled: isEnabled)
            sself.subViews.tableView.reloadData()
        }.store(in: &cancellables)

    }

    private func setupUI() {
        view.addSubview(subViews)
        setNavigationBarTitle("line_height".localization)

        subViews.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        subViews.tableView.delegate = self
        subViews.tableView.dataSource = self
    }
}

// MARK: - extensions
extension TypographyLineHeightViewController {
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
                           customView: subViews.headerInputView.fontSelect)
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
                           customView: subViews.headerInputView.fontSelect)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TypographyLineHeightViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel.sections.count > section else { return 0 }
        return viewModel.sections[section].data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.sections.count > indexPath.section else { return UITableViewCell() }
        guard viewModel.sections[indexPath.section].data.count > indexPath.row else { return UITableViewCell() }
        let font = viewModel.sections[indexPath.section].font
        let type = viewModel.sections[indexPath.section].type
        let boxHeight = viewModel.sections[indexPath.section].boxSize
        let data = viewModel.sections[indexPath.section].data[indexPath.row]

        switch type {
        case .label:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypographyLabelCell.identifier) as? TypographyLabelCell else { return UITableViewCell() }
            cell.updateUI(data: data, font: font, boxHeight: boxHeight)
            return cell
        case .textView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypographyTextViewCell.identifier) as? TypographyTextViewCell else { return UITableViewCell() }
            cell.updateUI(data: data, font: font, boxHeight: boxHeight)
            return cell
        }
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
        // \(fontType.font.familyName)
        let fontType = viewModel.sections[section].font
        let type = viewModel.sections[section].type
        header.updateUI(title: String(format: "font_size_title".localization, fontType.fontSize, type.title))
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
