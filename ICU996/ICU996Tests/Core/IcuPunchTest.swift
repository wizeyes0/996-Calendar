//
//  IcuPunchTest.swift
//  ICU996Tests
//
//  Created by Harry Duan on 2019/4/2.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import XCTest
import Nimble
@testable import ICU996

class IcuPunchTest: XCTestCase {
    
    func testHourSalary() {
        let res: (Int, Int) = IcuPunchManager.shared.calcInterval(to: Date())
        print(res)
        
        let hour: CGFloat = IcuPunchManager.shared.calcInterval(to: Date())
        print(hour)
    }
}
