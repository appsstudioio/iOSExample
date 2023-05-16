//
//  Debug+Extension.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import Foundation

extension Data {
    var prettyString: NSString? {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue) ?? nil
    }
    
    func toPrettyString() -> String {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let jsonString = String(data: data, encoding: .utf8) else {
                return ""
            }
            return jsonString
        } catch {
            print("Error: \(error.localizedDescription)")
            return ""
        }
    }
}

extension Dictionary {
    var debugPrettyString: String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    func dump() {
        print(self as NSDictionary)
    }
}

extension Encodable {
    var debugPrettyString: String {
        do {
            let encode = JSONEncoder()
            encode.outputFormatting = .prettyPrinted
            let jsonData = try encode.encode(self)
            return String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}

extension String {
    func debugPrint(_ message: Any? = "",
                    showTime: Bool = true,
                    file: String = #file,
                    funcName: String = #function,
                    line: Int = #line) {
#if DEBUG
        let fileName: String = (file as NSString).lastPathComponent
        var fullMessage = "[\(fileName)] [\(funcName) (\(line))]\n-> \(String(describing: message))\n"

        if true == showTime {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.dateFormat = "MM.dd KK:mm:ss.SSS"
            let timeStr = dateFormatter.string(from: Date())
            fullMessage = "\(timeStr): " + fullMessage
        }
        fullMessage += "\n"
    
        print(fullMessage)
#endif
    }
}
