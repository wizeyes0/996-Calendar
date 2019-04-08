//
//  IcuPunchManager.swift
//  ICU996
//
//  Created by Harry Duan on 2019/4/2.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class IcuPunchManager: NSObject {
    
    enum Status: Int {
        case unknown = 0
        case work = 1
        case rest = 2
    }
    
    static let shared = IcuPunchManager()
    
    var status: Status {
        get {
            return IcuCacheManager.get.todayIsPunched ? .rest : .work
        }
    }
    
    /// 当前月实际工作日
    var realDaysCount: Int {
        get {
            // 先获取当前月的天数
            let daysInCurrentMonth = getDaysInCurrentMonth()
            // 获取实际工作日
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-"
            let date = Date()
            let datePrefix = dateFormatter.string(from: date)
            var realDaysCount = 0
            for day in 1...daysInCurrentMonth {
                var dateString: String = ""
                if day / 10 <= 0 {
                    dateString = "\(datePrefix)0\(day)"
                } else {
                    dateString = "\(datePrefix)\(day)"
                }
                let res = IcuDateHelper.shared.isHoliday(dateString)
                if res.0 {
                    realDaysCount += 1
                }
            }
            return realDaysCount
        }
    }
    
    /// 下班打卡 Action
    ///
    /// - Returns: <#return value description#>
    public func offWorkPunch(_ success: (() -> Void) = {},
                             completion: ((Status) -> Void) = { _ in }) {
        IcuCacheManager.get.punchTime = Date()
        success()
        completion(self.status)
    }
    
    
    /// 计算时间间隔，返回 (小时，分钟) 元祖
    ///
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    /// - Returns: <#return value description#>
    public func calcInterval(from: Date? = nil, to: Date) -> (Int, Int) {
        var fromTime: Date? = from
        if fromTime == nil {
            let yearStr = IcuDateHelper.shared.getYearStr()
            let dateStr = IcuDateHelper.shared.getDateStr()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            fromTime = dateFormatter.date(from: "\(yearStr)-\(dateStr.0)-\(dateStr.1) 09:00:00")
        }
        if let minute = NSCalendar.current.dateComponents([.minute], from: fromTime!, to: to).minute {
            let hour = minute / 60
            let minute = minute % 60
            return (hour, minute)
        }
        return (0, 0)
    }
    
    
    /// 计算超出时长
    ///
    /// - Parameter time: <#time description#>
    /// - Returns: <#return value description#>
    public func calcOvertimeInterval(_ time: Date) -> (Int, Int) {
        let yearStr = IcuDateHelper.shared.getYearStr()
        let dateStr = IcuDateHelper.shared.getDateStr()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fromTime = dateFormatter.date(from: "\(yearStr)-\(dateStr.0)-\(dateStr.1) 18:00:00")
        let res: (Int, Int) = calcInterval(from: fromTime, to: time)
        return res
    }
    
    /// 计算时间间隔，单位小时
    ///
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    /// - Returns: <#return value description#>
    public func calcInterval(from: Date? = nil, to: Date) -> CGFloat {
        let res: (Int, Int) = calcInterval(from: from, to: to)
        // 错误处理
        if res.0 == 0 && res.1 == 0 {
            return 0.0
        }
        let hour = res.0
        let minute = res.1
        return CGFloat(hour) + CGFloat(minute) / 60.0
    }
    
    /// 计算时薪
    ///
    /// - Parameter workHours: <#workHours description#>
    /// - Returns: <#return value description#>
    public func calcHourSalary(_ workHours: CGFloat) -> CGFloat {
        if IcuCacheManager.get.hasSetSalary, let mounthSalary = IcuCacheManager.get.usersalary {
            // 日薪
            let daySalary: CGFloat = CGFloat(mounthSalary) / CGFloat(self.realDaysCount)
            return daySalary / workHours
        }
        return 0.0
    }
    
    func getDaysInCurrentMonth() -> Int {
        let calendar = NSCalendar.current
        
        let date = Date()
        let nowComps = calendar.dateComponents([.year, .month, .day], from: date)
        let year = nowComps.year ?? 0
        let month = nowComps.month ?? 0
        
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        
        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year
        
        let startDate = calendar.date(from: startComps)
        let endDate = calendar.date(from: endComps)
        
        let diff = calendar.dateComponents([.day], from: startDate!, to: endDate!)
        return diff.day!
    }
}
