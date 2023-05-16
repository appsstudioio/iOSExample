//
//  Bundle+Extension.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import Foundation

extension Bundle {
    
    enum InfoPlistKey: String {
        case baseURL = "BaseURL"
        case firebaseServiceFile = "FirebaseServiceFile"
        case bundleVersion = "CFBundleVersion"
    }
    
    static func getInfoPlistValue(forKey key: InfoPlistKey) -> String {
        return (self.main.infoDictionary?[key.rawValue] as? String)?.replacingOccurrences(of: "\\", with: "") ?? ""
    }
}
