//
//  IcuPunchUpView.swift
//  ICU996
//
//  Created by Harry Twan on 2019/4/1.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class IcuHourSalaryView: UIView {
    
    public var viewModel: IcuHourSalaryViewModel = IcuHourSalaryViewModel() {
        didSet {
            updateViews()
        }
    }
    
    private var bakView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var upTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "今天已工作："
        label.font = UIFont.icuFont(.medium, size: 13)
        label.textColor = UIColor.showColor()
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "10小时30分"
        label.font = UIFont.icuFont(.medium, size: 50)
        label.textColor = UIColor.highlightColor()
        return label
    }()
    
    
    lazy var downTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "已经超过额定工时2小时30分。"
        label.font = UIFont.icuFont(.medium, size: 13)
        label.textColor = UIColor.showColor()
        return label
    }()
    
    lazy var offWorkButton: UIButton = {
        let button = UIButton.defaultGradient()
        button.setTitle("想看看实际时薪吗？", for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
//        self.viewModel = IcuCalendarViewModel()
        super.init(frame: frame)
        initialViews()
        initialLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialViews() {
        addSubview(bakView)
        addSubview(upTimeLabel)
        addSubview(timeLabel)
        addSubview(downTimeLabel)
        addSubview(offWorkButton)
    }
    
    private func updateViews() {
        timeLabel.text = viewModel.timeText
    }
    
    private func initialLayouts() {
        bakView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        upTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(upTimeLabel).offset(12)
            make.centerX.equalToSuperview()
        }
        
        downTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        offWorkButton.snp.makeConstraints { make in
            make.top.equalTo(downTimeLabel.snp.bottom).offset(54)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
    }
}

class IcuHourSalaryViewModel: NSObject {
    
    private(set) var timeText: String = ""
    private(set) var overTimeText: String = ""
    
    override init() {
        super.init()
        initialDatas()
    }
    
    private func initialDatas() {
        updateDatas()
    }
    
    public func updateDatas() {
        let timeRes: (Int, Int) = IcuPunchManager.shared.calcInterval(to: Date())
        let hour = timeRes.0
        let minute = timeRes.1
        var timeText: String = ""
        if hour > 0 {
            timeText += "\(hour)小时"
        }
        if minute > 0 {
            timeText += "\(minute)分钟"
        }
        self.timeText = timeText
    }
}
