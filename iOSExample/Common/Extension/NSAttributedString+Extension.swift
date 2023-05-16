//
//  NSAttributedString+Extension.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import Foundation
import UIKit

extension NSAttributedString {
    func setStrikethroughStyle() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, self.string.count))
        return attributedString
    }
    
    func changeTextColor(color: UIColor, text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)

        var range = NSRange(location: 0, length: self.length)
        while (range.location != NSNotFound) {
            range = (self.string as NSString).range(of: text, options: [], range: range)
            if (range.location != NSNotFound) {
                attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: range.location, length: text.count))
                range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
            }
        }

        return attributedString
    }
    
    func changeTextFont(font: UIFont, text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)

        var range = NSRange(location: 0, length: self.length)
        while (range.location != NSNotFound) {
            range = (self.string as NSString).range(of: text, options: [], range: range)
            if (range.location != NSNotFound) {
                attributedString.addAttribute(.font, value: font, range: NSRange(location: range.location, length: text.count))
                range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
            }
        }

        return attributedString
    }
    
    func changeTextsColor(color: UIColor, texts: [String]) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        
        texts.forEach {
            var range = NSRange(location: 0, length: self.length)
            while (range.location != NSNotFound) {
                range = (self.string as NSString).range(of: $0, options: [], range: range)
                if (range.location != NSNotFound) {
                    attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: range.location, length: $0.count))
                    range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
                }
            }
        }
        
        return attributedString
    }
    
    func changeTextsFont(font: UIFont, texts: [String]) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        
        texts.forEach {
            var range = NSRange(location: 0, length: self.length)
            while (range.location != NSNotFound) {
                range = (self.string as NSString).range(of: $0, options: [], range: range)
                if (range.location != NSNotFound) {
                    attributedString.addAttribute(.font, value: font, range: NSRange(location: range.location, length: $0.count))
                    range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
                }
            }
        }

        return attributedString
    }
    
    func changeTextUnderLine(text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        
        var range = NSRange(location: 0, length: self.length)
        while (range.location != NSNotFound) {
            range = (self.string as NSString).range(of: text, options: [], range: range)
            if (range.location != NSNotFound) {
                attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: range.location, length: text.count))
                range = NSRange(location: range.location + range.length, length: self.string.count - (range.location + range.length))
            }
        }

        return attributedString
    }
    
    public func width(_ height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            context: nil)
        return ceil(boundingBox.width)
    }

    public func height(_ width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            context: nil)
        return ceil(boundingBox.height)

    }
}
