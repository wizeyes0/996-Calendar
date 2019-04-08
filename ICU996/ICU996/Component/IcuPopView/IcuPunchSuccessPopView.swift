//
//  IcuPunchSuccessPopView.swift
//  ICU996
//
//  Created by Harry Duan on 2019/4/4.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import SwiftMessages
import CocoaLumberjack
import pop
import Lottie

class IcuPunchSuccessPopView: UIView {
    
    static public func show() {
        let view = IcuPunchSuccessPopView()
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
        label.text = "打卡成功"
        label.font = UIFont.icuFont(.medium, size: 15)
        label.alpha = 0
        return label
    }()
    
    lazy private var animationView: AnimationView = {
        let view = AnimationView(name: "star-success")
        view.loopMode = .loop
        return view
    }()
    
    lazy private var confirmBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.alpha = 0
        btn.setTitle("确定", for: .normal)
        btn.setGradientShadow()
        btn.addTarget(self, action: #selector(sure), for: .touchUpInside)
        return btn
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
        backView.addSubview(confirmBtn)
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
        
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    @objc private func sure() {
        DDLogDebug("隐藏")
        SwiftMessages.hide()
    }
    
    private func showResult() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.titleLabel.alpha = 1
            self.confirmBtn.alpha = 1
            if let anim = POPSpringAnimation(propertyNamed: kPOPViewScaleXY) {
                anim.fromValue = NSValue(cgPoint: CGPoint(x: 0.2, y: 0.2))
                anim.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
                anim.springBounciness = 12
                self.titleLabel.pop_add(anim, forKey: "title-pop")
                self.confirmBtn.pop_add(anim, forKey: "button-pop")
            }
        }
    }
}
