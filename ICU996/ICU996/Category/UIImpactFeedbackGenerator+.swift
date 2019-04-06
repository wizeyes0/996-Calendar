//
//  UIImpactFeedbackGenerator+.swift
//  ICU996
//
//  Created by lvl on 2019/4/6.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

extension UIImpactFeedbackGenerator {
    static func impactOccurredWithStyle(style:FeedbackStyle) {
        UIImpactFeedbackGenerator.init(style:style).impactOccurred()
    }
    static func impactOccurredWithStyleLight() {
        UIImpactFeedbackGenerator.impactOccurredWithStyle(style: .light)
    }
    static func impactOccurredWithStyleMedium() {
        UIImpactFeedbackGenerator.impactOccurredWithStyle(style: .medium)
    }
    static func impactOccurredWithStyleHeavy() {
        UIImpactFeedbackGenerator.impactOccurredWithStyle(style: .heavy)
    }
}

