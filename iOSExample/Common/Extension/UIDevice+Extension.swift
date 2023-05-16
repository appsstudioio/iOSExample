//
//  UIDevice+Extension.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import Foundation
import AVFoundation
import UIKit

extension UIDevice {

    static func vibrate() {
        DispatchQueue.main.async {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    // https://iphonedev.wiki/index.php/AudioServices
    static func alertSound(_ inSystemSoundID: SystemSoundID = 1031) {
        DispatchQueue.main.async {
            AudioServicesPlaySystemSound(inSystemSoundID)
        }
    }
}
