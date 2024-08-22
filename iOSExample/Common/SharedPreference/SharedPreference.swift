//
//  SharedPreference.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/22/24.
//

import Foundation

class SharedPreference {
    // 이전 프로젝트에서 사용한 Keys를 가져와 사용하지만 앱 설정 부분은 별도로 구성해서 사용한다.
    enum PreferenceKeys: String {
        case kSettingFontFamilyName = "kSettingFontFamilyName"
    }

    static var shared = SharedPreference()

    func setObjectValues(values: AnyObject, forKey: PreferenceKeys){
        UserDefaults.standard.set(values, forKey: forKey.rawValue)
        UserDefaults.standard.synchronize()
    }

    func getObjectValues(forKey: PreferenceKeys) -> AnyObject? {
        return UserDefaults.standard.object(forKey: forKey.rawValue) as AnyObject?
    }

    func setStringValue(value: String, forKey: PreferenceKeys) {
        UserDefaults.standard.set(value, forKey: forKey.rawValue)
        UserDefaults.standard.synchronize()
    }

    func getStringtValue(forKey: PreferenceKeys) -> String? {
        return UserDefaults.standard.value(forKey: forKey.rawValue) as? String
    }

    func setIntegerValue(forKey: PreferenceKeys, value: Int) {
        UserDefaults.standard.set(value, forKey: forKey.rawValue)
        UserDefaults.standard.synchronize()
    }

    func getIntegerValue(forKey: PreferenceKeys) -> Int? {
        return UserDefaults.standard.value(forKey: forKey.rawValue) as? Int
    }

    func setBoolValue(forKey: PreferenceKeys, value: Bool) {
        UserDefaults.standard.set(value, forKey: forKey.rawValue)
        UserDefaults.standard.synchronize()
    }

    func getBoolValue(forKey: PreferenceKeys) -> Bool? {
        return UserDefaults.standard.value(forKey: forKey.rawValue) as? Bool
    }

    func removeValues(forKey: PreferenceKeys){
        UserDefaults.standard.removeObject(forKey: forKey.rawValue)
        UserDefaults.standard.synchronize()
    }
}

