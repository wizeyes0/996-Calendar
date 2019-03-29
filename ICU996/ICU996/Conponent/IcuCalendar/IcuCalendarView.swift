//
//  IcuCalendarView.swift
//  ICU996
//
//  Created by Harry Twan on 2019/3/29.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class IcuCalendarView: UIView {

    private var bakView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "4月1日"
        label.font = UIFont.icuFont(.medium, size: 21)
        label.textColor = UIColor.showColor()
        return label
    }()
    
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.text = "周一"
        label.font = UIFont.icuFont(.medium, size: 13)
        label.textColor = UIColor.quoteColor()
        label.textAlignment = .right
        return label
    }()
    
    lazy var upAnswerLabel: UILabel = {
        let label = UILabel()
        label.text = "现在应该上班吗"
        label.font = UIFont.icuFont(.medium, size: 13)
        label.textColor = UIColor.showColor()
        return label
    }()
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.text = "不上"
        label.font = UIFont.icuFont(.medium, size: 110)
        label.textColor = UIColor.highlightColor()
        return label
    }()
    
    
    lazy var downAnswerLabel: UILabel = {
        let label = UILabel()
        label.text = "已经超过下午六点"
        label.font = UIFont.icuFont(.medium, size: 13)
        label.textColor = UIColor.showColor()
        return label
    }()
    
    lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.text = "劳动法第三十六条：国家实行劳动者每日工作时间不超过八小时、平均每周工作时间不超过四十四小时的工时制度。"
        label.font = UIFont.icuFont(.regular, size: 11)
        label.textColor = UIColor.quoteColor()
        label.numberOfLines = 0
        return label
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
        bakView.addSubview(dateLabel)
        bakView.addSubview(weekdayLabel)
        bakView.addSubview(upAnswerLabel)
        bakView.addSubview(answerLabel)
        bakView.addSubview(downAnswerLabel)
        bakView.addSubview(quoteLabel)
    }
    
    private func initialLayouts() {
        bakView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(20)
        }
        
        weekdayLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(26)
        }
        
        upAnswerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(118)
            make.centerX.equalToSuperview()
        }
        
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(upAnswerLabel.snp.bottom).offset(12)
            make.height.equalTo(154)
            make.centerX.equalTo(upAnswerLabel)
        }
        
        downAnswerLabel.snp.makeConstraints { make in
            make.top.equalTo(answerLabel.snp.bottom).offset(12)
            make.centerX.equalTo(answerLabel)
        }
        
        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(downAnswerLabel.snp.bottom).offset(31)
            make.centerX.equalTo(downAnswerLabel)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
}
