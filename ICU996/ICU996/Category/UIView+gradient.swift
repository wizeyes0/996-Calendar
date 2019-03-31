//
//  UIView+gradient.swift
//  ICU996
//
//  Created by Harry Duan on 2019/3/31.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import AZCategory

extension UIView {
    public func setGradientColor(colors: UIColor..., locations: [CGFloat]) {
        self.az_setGradientBackground(with: colors,
                                      locations: locations as [NSNumber],
                                      start: CGPoint(x: 0, y: 0),
                                      end: CGPoint(x: 1, y: 0))
    }
}
