//
//  UIDevice+.swift
//  ICU996
//
//  Created by lvl on 2019/3/30.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var infoDictionary: Dictionary<String, Any> {
        return Bundle.main.infoDictionary!
    }
    
    var appVersion: String {
        return infoDictionary["CFBundleShortVersionString"] as! String
    }
    
    var appBuild:String {
        return infoDictionary["CFBundleVersion"] as! String
    }
    
        
}
