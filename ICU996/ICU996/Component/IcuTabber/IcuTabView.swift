//
//  IcuTabView.swift
//  ICU996
//
//  Created by Harry Twan on 2019/3/29.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class IcuTabView: UIView {
    
    private var bakView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy private var calendarButton: UIButton = {
        let button = UIButton()
        button.setTitle("日历", for: .normal)
        button.setTitleColor(UIColor.showColor(), for: .normal)
        button.titleLabel?.font = UIFont.icuFont(.semibold, size: 24)
        return button
    }()
    
    lazy private var hourSalaryButton: UIButton = {
        let button = UIButton()
        button.setTitle("时薪", for: .normal)
        button.setTitleColor(UIColor.showColor(), for: .normal)
        button.titleLabel?.font = UIFont.icuFont(.medium, size: 16)
        return button
    }()
    
    lazy private var lightLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xe95a7d)
        view.alpha = 0.6
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
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
        bakView.addSubview(calendarButton)
        bakView.addSubview(hourSalaryButton)
        bakView.addSubview(lightLineView)
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
