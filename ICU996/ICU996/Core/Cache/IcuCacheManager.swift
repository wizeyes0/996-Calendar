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
    var userName: String? {
        get {
            return Defaults[.username]
        }
        set {
            Defaults[.username] = newValue
        }
    }
}

extension DefaultsKeys {
    static let username = DefaultsKey<String?>("icu.user.info.name")
}
