//
//  IcuCalcPopView.swift
//  ICU996
//
//  Created by Harry Duan on 2019/4/8.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import SwiftMessages
import CocoaLumberjack
import pop
import Lottie

class IcuCalcPopView: UIView {
    static public func show() {
        let view = IcuCalcPopView()
        var config = SwiftMessages.Config()
        config.presentationStyle = .center
        config.duration = .forever
        config.dimMode = .blur(style: .dark,
                               alpha: 0.3,
                               interactive: true)
        config.presentationContext = .window(windowLevel: .statusBar)
        SwiftMessages.show(config: config, view: view)
        view.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
    }
    
    private var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "计算详情"
        label.font = UIFont.icuFont(.medium, size: 15)
        label.alpha = 0
        return label
    }()
    
    lazy private var formulaLabel: UILabel = {
        let label = UILabel()
        label.text = "10000￥ ÷ 24天 = 1121￥/天"
        label.font = UIFont.icuFont(.regular, size: 15)
        label.textColor = UIColor.showColor()
        label.alpha = 0
        return label
    }()
    
    lazy private var formulaLabel2: UILabel = {
        let label = UILabel()
        label.text = "1121￥ ÷ 11 小时 = 28￥/小时"
        label.font = UIFont.icuFont(.regular, size: 15)
        label.textColor = UIColor.showColor()
        label.alpha = 0
        return label
    }()
    
    lazy private var animationView: AnimationView = {
        let view = AnimationView(name: "collecting-money")
        view.loopMode = .loop
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialViews()
        initialLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialViews() {
        animationView.play()
        
        addSubview(backView)
        backView.addSubview(animationView)
        backView.addSubview(titleLabel)
        backView.addSubview(formulaLabel)
        backView.addSubview(formulaLabel2)
        showResult()
    }
    
    private func initialLayouts() {
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.centerX.equalToSuperview()
        }
        
        formulaLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        formulaLabel2.snp.makeConstraints { make in
            make.top.equalTo(formulaLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func sure() {
        DDLogDebug("隐藏")
        SwiftMessages.hide()
    }
    
    private func showResult() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.titleLabel.alpha = 1
            if let anim = POPSpringAnimation(propertyNamed: kPOPViewScaleXY) {
                anim.fromValue = NSValue(cgPoint: CGPoint(x: 0.2, y: 0.2))
                anim.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
                anim.springBounciness = 12
                self.solveFormulaLabel()
                self.titleLabel.pop_add(anim, forKey: "title-pop")
            }
            if let anim = POPSpringAnimation(propertyNamed: kPOPViewAlpha) {
                anim.toValue = 1
                self.formulaLabel.pop_add(anim, forKey: "f1-pop")
                self.formulaLabel2.pop_add(anim, forKey: "f2-pop")
            }
        }
    }
    
    private func solveFormulaLabel() {
        let monSalary: Int = IcuCacheManager.get.usersalary ?? 0
        let monDays: Int = IcuPunchManager.shared.realDaysCount
        guard let punchTime: Date = IcuCacheManager.get.punchTime else {
            return
        }
        let dayWorkTimes: CGFloat = IcuPunchManager.shared.calcInterval(to: punchTime)
        print(monSalary, monDays)
        print(dayWorkTimes, CGFloat(monSalary) / CGFloat(monDays) / dayWorkTimes)
        formulaLabel.text = "\(monSalary)￥ ÷ \(monDays)天 = \(String(format: "%.2f", CGFloat(monSalary) / CGFloat(monDays)))￥/天"
        formulaLabel2.text = "\(String(format: "%.2f", CGFloat(monSalary) / CGFloat(monDays)))￥ ÷ \(String(format: "%.2f", CGFloat(dayWorkTimes)))小时 = \(String(format: "%.2f", CGFloat(monSalary) / CGFloat(monDays) / dayWorkTimes))￥/小时"
    }
}
