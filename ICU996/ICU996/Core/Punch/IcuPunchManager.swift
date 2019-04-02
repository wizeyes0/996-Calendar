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
            let current = IcuCacheManager.get.punchStatus
            if current == 1 {
                return .work
            }
            else if current == 2 {
                return .rest
            }
            return .unknown
        }
    }
    
    /// 下班打卡 Action
    ///
    /// - Returns: <#return value description#>
    public func offWorkPunch(_ success: (() -> Void) = {},
                             completion: ((Status) -> Void) = { _ in }) {
        switch status {
        case .work:
            // 记录打卡状态
            IcuCacheManager.get.punchStatus = Status.rest.rawValue
            // 记录打卡时间
            IcuCacheManager.get.punchTime = Date()
            success()
        default:
            break
        }
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
            // 先获取当前月的天数
            let calendar = Calendar.current
            guard let range = calendar.range(of: .calendar, in: .month, for: Date()) else {
                return 0.0
            }
            let daysInCurrentMonth = range.count
            // 日薪
            let daySalary: CGFloat = CGFloat(mounthSalary) / CGFloat(daysInCurrentMonth)
            return daySalary / workHours
        }
        return 0.0
    }
}
