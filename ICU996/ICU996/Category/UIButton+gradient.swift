//
//  UIButton+gradient.swift
//  ICU996
//
//  Created by lvl on 2019/3/31.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

extension UIButton {
    func setGradientShadow() {
        self.setGradientColor(colors: UIColor(rgb: 0xE95A7D), UIColor(rgb: 0xFDAD9F), locations: [0, 1])
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 20
        let shadowColor = UIColor(red: 121, green: 121, blue: 121)
        self.layer.applySketchShadow(color: shadowColor,
                                       alpha: 0.5,
                                       x: 0,
                                       y: 4,
                                       blur: 20,
                                       spread: 0)
        
    }
}
