//
//  IcuPunchUpView.swift
//  ICU996
//
//  Created by Harry Twan on 2019/4/1.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import CocoaLumberjack

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
        button.titleLabel?.font = UIFont.icuFont(.medium, size: 15)
        button.setTitle("想看看实际时薪吗？", for: .normal)
        button.addTarget(self, action: #selector(offWorkButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var realHourSalaryDescLabel: UILabel = {
        let label = UILabel()
        label.text = "今日实际时薪："
        label.font = UIFont.icuFont(.medium, size: 13)
//        label.textColor = UIColor()
        return label
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
        downTimeLabel.text = viewModel.overTimeText
        offWorkButton.setTitle(viewModel.buttonShowText, for: .normal)
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
            make.height.equalTo(70)
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


// MARK: - Button Action
extension IcuHourSalaryView {
    @objc private func offWorkButtonAction() {
        if IcuCacheManager.get.hasSetSalary {
            DDLogDebug("TODO：打卡逻辑")
        }
        else {
            IcuPopView.show()
        }
    }
}

class IcuHourSalaryViewModel: NSObject {
    
    private(set) var timeText: String = ""
    private(set) var overTimeText: String = ""
    private(set) var buttonShowText: String = ""

    override init() {
        super.init()
        initialDatas()
    }
    
    private func initialDatas() {
        updateDatas()
    }
    
    public func updateDatas() {
        // 处理已经工作时长
        let timeRes: (Int, Int) = IcuPunchManager.shared.calcInterval(to: Date())
        let timeText = formatShowText(timeRes)
        self.timeText = timeText
        
        let currentHour = IcuDateHelper.shared.getHourAndMinute().0
        // 处理超出部分
        if currentHour >= 18 {
            let overtimeRes: (Int, Int) = IcuPunchManager.shared.calcOvertimeInterval(Date())
            overTimeText = formatShowText(overtimeRes)
        }
        else {
            overTimeText = "正常工作时间"
        }
        
        // 时薪模块
        if IcuCacheManager.get.hasSetSalary {
            DDLogDebug("展示打开，计算时薪")
            buttonShowText = "下班结算"
        } else {
            buttonShowText = "想看看实际时薪吗？"
        }
    }
    
    private func formatShowText(_ result: (Int, Int)) -> String {
        var timeText: String = ""
        if result.0 > 0 {
            timeText += "\(result.0)小时"
        }
        if result.1 > 0 {
            timeText += "\(result.1)分钟"
        }
        return timeText
    }
}
