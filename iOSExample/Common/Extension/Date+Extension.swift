//
//  Date+Extension.swift
//  iOSExample
//
//  Created by dongju.lim on 2023/02/13.
//

import Foundation

extension Date {
    
    public enum DateWeekType: Int {
        case sunday = 1
        case monday = 2
        case tuesday = 3
        case wednesday = 4
        case thursday = 5
        case friday = 6
        case saturday = 7
    }

    // returns an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
    func dayOfWeek(timeZone: TimeZone = TimeZone.autoupdatingCurrent, locale: Locale? = Locale.current) -> DateWeekType? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        calendar.locale = locale
        guard let weekday = calendar.dateComponents([.weekday], from: self).weekday else { return nil }
        
        return (DateWeekType(rawValue: weekday) ?? nil)
    }

    func toString(format: String, timeZone: TimeZone = .current, locale: Locale = Locale.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setKSTFormatter(format: format)
        return dateFormatter.string(from: self)
    }
    
    // D-Day
    func betweenDates(toDate: Date, component: [Calendar.Component]) -> DateComponents? {
        let calendar = Calendar(identifier: .gregorian)
    //    calendar.locale = Locale(identifier: "ko_KR")
        let unitFlags = Set<Calendar.Component>(component)
        let components = calendar.dateComponents(unitFlags, from: self, to: toDate)
        return components
    }

    func afterMonthDate(month: Int) -> Date? {
        let monthOffset = DateComponents(month: month)
        let calendar = Calendar(identifier: .gregorian)
        if let afterMonth = calendar.date(byAdding: monthOffset, to: self) {
            return afterMonth
        }
        return nil
    }

    func afterHourhDate(hour: Int) -> Date? {
        let hourOffset = DateComponents(hour: hour)
        let calendar = Calendar(identifier: .gregorian)
        if let afterHour = calendar.date(byAdding: hourOffset, to: self) {
            return afterHour
        }
        return nil
    }

    func afterDayDate(day: Int) -> Date? {
        let dayOffset = DateComponents(day: day)
        let calendar = Calendar(identifier: .gregorian)
        if let afterDay = calendar.date(byAdding: dayOffset, to: self) {
            return afterDay
        }
        return nil
    }

    var dateKST: Date? {
        return datetime_KST()
    }
    
    func datetime_KST() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.setKSTFormatter(format: "yyyy-MM-dd HH:mm:ss")
        let dateStr = dateFormatter.string(from: self)
        return dateFormatter.date(from: dateStr)!
    }
}

// MARK: - DateFormatter
extension DateFormatter {
    func setFormatter(format: String = "yyyy-MM-dd HH:mm:ss",
                      timeZone: TimeZone? = TimeZone.current,
                      locale: Locale? = Locale.current) {
        self.dateFormat = format
        self.calendar   = Calendar(identifier: .gregorian)
        if let setTimeZone = timeZone {
            self.timeZone = setTimeZone
        }
        if locale != nil {
            self.locale = locale
        }
    }

    func setKSTFormatter(format: String = "yyyy-MM-dd HH:mm:ss") {
        self.setFormatter(format: format,
                          timeZone: TimeZone(abbreviation: "KST"),
                          locale: Locale(identifier: "ko_kr"))
    }
}
