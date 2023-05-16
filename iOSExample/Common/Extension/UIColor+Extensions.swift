//
//  UIColor+Extensions.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import UIKit

extension UIColor {
    // notaTODO: - Computed Properties
    var toHex: String? {
        return toHex()
    }

    // notaTODO: - From UIColor to String
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }

        let red = Float(components[0])
        let green = Float(components[1])
        let black = Float(components[2])
        var alpha = Float(1.0)

        if components.count >= 4 {
            alpha = Float(components[3])
        }

        if alpha > 0 {
            return String(format: "%02lX%02lX%02lX%02lX",
                          lroundf(red * 255), lroundf(green * 255), lroundf(black * 255), lroundf(alpha * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(black * 255))
        }
    }
}
