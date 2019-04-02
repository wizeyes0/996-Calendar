//
//  IcuDateHelper.swift
//  ICU996
//
//  Created by Harry Twan on 2019/3/29.
//  Copyright © 2019 Harry Duan. All rights reserved.
//
//  https://coderwall.com/p/b8pz5q/swift-4-current-year-mont-day
//

import UIKit

class IcuDateHelper: NSObject {
    
    public static let shared = IcuDateHelper()

    override init() {
        super.init()
    }
    
    
    /// 返回年份字符串
    ///
    /// - Returns: (Year): (String)
    public func getYearStr() -> String {
        let date = Date()
        let yearFormat = DateFormatter()
        yearFormat.dateFormat = "yyyy"
        let formattedYearDate = yearFormat.string(from: date)
        return formattedYearDate
    }
    
    
    /// 返回年份
    ///
    /// - Returns: (Year): (Int)
    public func getYear() -> Int {
        let year: String = getYearStr()
        return Int(year) ?? 0
    }
    
    
    /// 返回月份和日期数据的字符串
    ///
    /// - Returns: (Mounth, Day): (String, String)
    public func getDateStr() -> (String, String) {
        let date = Date()
        let mounthFormat = DateFormatter()
        mounthFormat.dateFormat = "MM"
        let dayFormat = DateFormatter()
        dayFormat.dateFormat = "dd"
        let formattedMounthDate = mounthFormat.string(from: date)
        let formattedDayDate = dayFormat.string(from: date)
        return (formattedMounthDate, formattedDayDate)
    }
    
    /// 返回月份和日期数据
    ///
    /// - Returns: (Mounth, Day): (Int, Int)
    public func getDate() -> (Int, Int) {
        let resStr = getDateStr()
        return (Int(resStr.0) ?? 0, Int(resStr.1) ?? 0)
    }

    /// 返回星期几
    ///
    /// - Returns: (Weekday): (Int)
    public func getWeekDay() -> Int {
        let date = Date()
        let weekday = Calendar.current.component(.weekday, from: date)
        return weekday
    }
    
    /// 返回小时和分钟
    ///
    /// - Returns: (Hour, Minute): (Int, Int)
    public func getHourAndMinute() -> (Int, Int) {
        let date = Date()
        let hourFormat = DateFormatter()
        hourFormat.dateFormat = "HH"
        let minuteFormat = DateFormatter()
        minuteFormat.dateFormat = "mm"
        let formattedHourDate = hourFormat.string(from: date)
        let formattedMinuteDate = minuteFormat.string(from: date)
        return (Int(formattedHourDate) ?? 0, Int(formattedMinuteDate) ?? 0)
    }
    
    
    /// 判断是否是假期
    ///
    /// - Returns: <#return value description#>
    public func isHoliday() -> (Bool, String) {
        let year = getYear()
        let dateFormat = DateFormatter()
        let date = Date()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormat.string(from: date)
        guard let plistPath = Bundle.main.path(forResource: "data_\(year)", ofType: "plist") else {
            return (false, "")
        }
        if let dic = NSMutableDictionary(contentsOfFile: plistPath) as? Dictionary<String, AnyObject> {
            if let infoDic = dic[formattedDate] as? Dictionary<String, AnyObject> {
                if let isWork: Bool = infoDic["should_work"] as? Bool,
                    let info: String = infoDic["info"] as? String {
                    return (isWork, info)
                }
            }
        }
        return (false, "")
    }
}
