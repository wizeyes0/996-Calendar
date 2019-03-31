//
//  IcuCacheManager.swift
//  ICU996
//
//  Created by Harry Twan on 2019/3/29.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class IcuCacheManager: NSObject {
    
    static let get = IcuCacheManager()
    
    /// 取值的时候直接 IcuCacheManager.get.userName
    /// 写值的时候直接 IcuCacheManager.get.userName = "gua"
    
    
    /// 是否填写过昵称
    var userName: String? {
        get {
            return Defaults[.username]
        }
        set {
            Defaults[.username] = newValue
        }
    }
    
    /// 是否填写过薪资
    var hasSetSalary: Bool {
        get {
            return Defaults[.hasSetSalary]
        }
        set {
            Defaults[.hasSetSalary] = newValue
        }
    }
}

extension DefaultsKeys {
    // 用户预填信息
    static let username = DefaultsKey<String?>("icu.user.info.name")
    static let hasSetSalary = DefaultsKey<Bool>("icu.user.info.has.set.salary", defaultValue: false)
}
