//
//  UIButton+Extension.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor?,
                            for state: UIControl.State,
                            alpha: CGFloat = 1.0) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setFillColor(color?.cgColor ?? UIColor.white.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        context.setAlpha(alpha)
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    func underlineText(titleColor : UIColor? , font : UIFont) {
        guard let title = title(for: .normal), let titleColor = titleColor else { return }
        
        let titleString = NSMutableAttributedString(string: title)
        titleString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: title.count)
        )
        
        titleString.addAttribute(NSAttributedString.Key.foregroundColor, value: titleColor, range: NSRange(location: 0, length: title.count))
        titleString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: title.count))
        setAttributedTitle(titleString, for: .normal)
    }
}
