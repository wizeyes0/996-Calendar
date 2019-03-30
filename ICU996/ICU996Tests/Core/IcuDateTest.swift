//
//  IcuDateTest.swift
//  ICU996Tests
//
//  Created by Harry Twan on 2019/3/30.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import XCTest
import Nimble
@testable import ICU996

class IcuDateTest: XCTestCase {

    /// 测试月份和日期数据
    func testMounthAndDay() {
        let res: (Int, Int) = IcuDateHelper.shared.getDate()
        let mounth = res.0
        let day = res.1
        expect(mounth).to(beGreaterThan(0), description: "月份有误")
        expect(mounth).to(beLessThan(13), description: "月份有误")
        expect(day).to(beGreaterThan(0), description: "日期有误")
        expect(day).to(beLessThan(32), description: "日期有误")
    }
    
    
    /// 测试星期数据
    func testWeekDay() {
        let weekday = IcuDateHelper.shared.getWeekDay()
        expect(weekday).to(beGreaterThan(0), description: "星期数有误")
        expect(weekday).to(beLessThan(8), description: "星期数有误")
    }
    
    /// 测试小时和分钟
    func testHourAndMinute() {
        let res: (Int, Int) = IcuDateHelper.shared.getHourAndMinute()
        let hour = res.0
        let minute = res.1
        print(hour, minute)
        expect(hour).to(beGreaterThan(-1), description: "小时有误")
        expect(hour).to(beLessThan(24), description: "小时有误")
        expect(minute).to(beGreaterThan(-1), description: "分钟有误")
        expect(minute).to(beLessThan(60), description: "分钟有误")
    }
}
