//
//  ICUSaying.swift
//  ICU996
//
//  Created by HanLiu on 2019/3/29.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class ICUSaying: NSObject {
    //正面的，积极的，鼓励的鸡汤
    enum Positive: String {
        case a = "为了家庭还在拼搏的你，辛苦了啊"
        case b = "虽然你赚的钱多，但是也得保重身体才能花啊"
        case c = "生活不止996，还有诗和远方"
        case d = "新的一天开始了，准备好迎接挑战了吗？"
        case e = "Family, Duty, Honor"
        case f = "Growing Strong"
    }
    //负面的，消极的，毒汤,调侃
    enum Negative: String {
        
        enum Night:String {
            case a = "给队友擦屁股到这么晚么，心疼你哟"
        }
        
        case a = "嘿，你知道吗？听说前天加班到3点的老王头顶大草原"
        case b = "虽然你加班时间长，但是你穷啊"
        case c = "为什么加班？眼里总有bug么？"
        case d = "今天有背锅改bug么"
        case e = "夜太黑，尽管再心累，总有人黑着眼眶敲着键"
        case f = "你觉得世界上最好的语言是什么?"
        case g = "你有对象吗？没有？自己 new 一个呗！"
        case h = "The 996 work schedule is inhumain"
        case i = "今年加薪了么？一猜就没有，因为你只会加班啊"
    }
}
