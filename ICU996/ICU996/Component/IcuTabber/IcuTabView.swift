//
//  IcuTabView.swift
//  ICU996
//
//  Created by Harry Twan on 2019/3/29.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import pop

class IcuTabView: UIView {
    
    enum SubType: Int {
        case calendar = 1
        case hourSalary = 2
    }

    private var bakView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private(set) var currentTab: SubType = .calendar
    
    public var changedCallBack: (SubType) -> Void = { _ in }

    lazy private var calendarButton: UIButton = {
        let button = UIButton()
        button.setTitle("日历", for: .normal)
        button.setTitleColor(UIColor.showColor(), for: .normal)
        button.titleLabel?.font = UIFont.icuFont(.semibold, size: 24)
        button.addTarget(self, action: #selector(changeToCalendar), for: .touchUpInside)
        return button
    }()
    
    lazy private var hourSalaryButton: UIButton = {
        let button = UIButton()
        button.setTitle("时薪", for: .normal)
        button.setTitleColor(UIColor.showColor(), for: .normal)
        button.titleLabel?.font = UIFont.icuFont(.medium, size: 16)
        button.addTarget(self, action: #selector(changeToHourSalary), for: .touchUpInside)
        return button
    }()
    
    lazy private var lightLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xe95a7d)
        view.layer.cornerRadius = 5
        view.setGradientColor(colors: UIColor(rgb: 0xE95A7D), UIColor(rgb: 0xFDAD9F), locations: [0, 1])
        view.frame = CGRect(x: 22, y: 24, width: 50, height: 10)
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
        addSubview(bakView)
        bakView.addSubview(lightLineView)
        bakView.addSubview(calendarButton)
        bakView.addSubview(hourSalaryButton)
    }
    
    private func initialLayouts() {
        bakView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        calendarButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }
        
        hourSalaryButton.snp.makeConstraints { make in
            make.left.equalTo(calendarButton.snp.right).offset(24)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - action
extension IcuTabView {
    @objc public func changeToCalendar() {
        if currentTab == .calendar { return }
        switchAnimation(to: .calendar)
        currentTab = .calendar
        changedCallBack(currentTab)
    }
    
    @objc public func changeToHourSalary() {
        if currentTab == .hourSalary { return }
        switchAnimation(to: .hourSalary)
        currentTab = .hourSalary
        changedCallBack(currentTab)
    }
    
    private func switchAnimation(to type: SubType) {
        var solveButton: UIButton? = nil
        switch type {
        case .hourSalary:
            calendarButton.titleLabel?.font = UIFont.icuFont(.medium, size: 16)
            hourSalaryButton.titleLabel?.font = UIFont.icuFont(.semibold, size: 24)
            solveButton = hourSalaryButton
        case .calendar:
            hourSalaryButton.titleLabel?.font = UIFont.icuFont(.medium, size: 16)
            calendarButton.titleLabel?.font = UIFont.icuFont(.semibold, size: 24)
            solveButton = calendarButton
        }
        layoutIfNeeded()
        guard let sol = solveButton else {
            return
        }
        let ori = lightLineView.frame
        
        if let anim = POPSpringAnimation.init(propertyNamed: kPOPViewFrame) {
            anim.toValue = CGRect(x: sol.frame.minX + 4,
                                  y: ori.minY,
                                  width: ori.width,
                                  height: ori.height)
            lightLineView.pop_add(anim, forKey: "move")
        }
    }
}
