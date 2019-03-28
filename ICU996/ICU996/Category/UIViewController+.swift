//
//  UIViewController+.swift
//  ICU996
//
//  Created by Harry Duan on 2019/3/28.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// 获取当前最上层 VC
    var currentViewController: UIViewController? {
        get {
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                return topController
            }
            return nil
        }
    }
}
