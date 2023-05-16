//
//  UITableViewCell+Extension.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    var tableView: UITableView? {
        var view = self.superview
        while view != nil && view!.isKind(of: UITableView.self) == false {
            view = view!.superview
        }
        return view as? UITableView
    }
}

extension UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}
