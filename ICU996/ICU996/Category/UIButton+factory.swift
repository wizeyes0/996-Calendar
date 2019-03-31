//
//  UIButton+factory.swift
//  ICU996
//
//  Created by lvl on 2019/3/31.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

extension UIButton {
    static func defaultGradient() -> UIButton {
        let button = UIButton()
        button.setGradientShadow()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.icuFont(.medium, size: 15)
        return button
    }
}
