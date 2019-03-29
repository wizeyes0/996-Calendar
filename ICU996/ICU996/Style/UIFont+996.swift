//
//  UIFont+996.swift
//  ICU996
//
//  Created by Harry Duan on 2019/3/28.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

// MARK: - 用来归档整体的 Font Style
extension UIFont {
    
    enum FontStyle: String {
        case regular = "Regular"
        case medium = "Medium"
        case semibold = "Semibold"
        case bold = "Bold"
    }
    
    static func icuFont(_ fontStyle: FontStyle = .regular, size: CGFloat = 13.0) -> UIFont {
        return UIFont(name: "PingFangSC-\(fontStyle.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
