//
//  IcuPunchUpView.swift
//  ICU996
//
//  Created by Harry Twan on 2019/4/1.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import CocoaLumberjack
import LTMorphingLabel

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
        label.text = "今天已工作"
        label.font = UIFont.icuFont(.medium, size: 13)
        label.textColor = UIColor.showColor()
        return label
    }()
    
    lazy var timeLabel: LTMorphingLabel = {
        let label = LTMorphingLabel()
        label.text = "10小时30分"
        label.font = UIFont.icuFont(.medium, size: 50)
        label.textColor = UIColor.highlightColor()
        label.morphingEffect = .scale
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
        label.textAlignment = .right
        label.font = UIFont.icuFont(.medium, size: 13)
        label.textColor = UIColor.showColor()
        return label
    }()
    
    lazy var realHourSalaryLabel: UILabel = {
        let label = UILabel()
        label.text = "￥ 80.00"
        label.textAlignment = .left
        label.font = UIFont.icuFont(.medium, size: 28)
        label.textColor = UIColor.highlightColor()
        return label
    }()
    
    lazy var fromQuoteImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "calendar-quote-from"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var toQuoteImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "calendar-quote-to"))
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        addSubview(upTimeLabel)
        addSubview(timeLabel)
        addSubview(downTimeLabel)
        addSubview(offWorkButton)
        addSubview(realHourSalaryLabel)
        addSubview(realHourSalaryDescLabel)
        addSubview(fromQuoteImageView)
        addSubview(toQuoteImageView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(heartbeatRefresh), name: .HeartbeatRefresh, object: nil)
    }
    
    
    private func updateViews() {
        timeLabel.text = viewModel.timeText
        downTimeLabel.text = viewModel.overTimeText
        offWorkButton.setTitle(viewModel.buttonShowText, for: .normal)
        realHourSalaryLabel.text = viewModel.realHourSalaryText
        
        realHourSalaryDescLabel.isHidden = !viewModel.realHourIsShow
        realHourSalaryLabel.isHidden = !viewModel.realHourIsShow
        
        if IcuCacheManager.get.hasSetSalary {
            switch viewModel.timeType {
            case .beforework, .work:
                offWorkButton.isEnabled = false
                offWorkButton.alpha = 0.5
            case .offwork:
                offWorkButton.isEnabled = true
                offWorkButton.alpha = 1
            }
        }
        else {
            offWorkButton.isEnabled = true
            offWorkButton.alpha = 1
        }
    }
    
    private func initialLayouts() {
        bakView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        upTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        fromQuoteImageView.snp.makeConstraints { make in
            make.right.equalTo(upTimeLabel.snp.left).offset(-6)
            make.bottom.equalTo(upTimeLabel.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(upTimeLabel.snp.bottom).offset(12)
            make.height.equalTo(70)
            make.centerX.equalToSuperview()
        }
        
        downTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        toQuoteImageView.snp.makeConstraints { make in
            make.left.equalTo(downTimeLabel.snp.right).offset(6)
            make.bottom.equalTo(downTimeLabel.snp.centerY)
        }
        
        offWorkButton.snp.makeConstraints { make in
            make.top.equalTo(downTimeLabel.snp.bottom).offset(54)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
        realHourSalaryLabel.snp.makeConstraints { make in
            make.top.equalTo(offWorkButton.snp.bottom).offset(32)
            make.left.equalTo(self.snp.centerX)
        }
        
        realHourSalaryDescLabel.snp.makeConstraints { make in
            make.bottom.equalTo(realHourSalaryLabel)
            make.right.equalTo(realHourSalaryLabel.snp.left)
        }
    }
    
    @objc private func heartbeatRefresh() {
//        DDLogDebug("HourSalary 心跳更新")
        viewModel.updateDatas()
        updateViews()
    }
}


// MARK: - Button Action
extension IcuHourSalaryView {
    @objc private func offWorkButtonAction() {
        if IcuCacheManager.get.hasSetSalary {
            if IcuCacheManager.get.todayIsPunched {
                
            } else {
                IcuPunchManager.shared.offWorkPunch({
                    DDLogDebug("打开成功")
                }) { status in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.heartbeatRefresh()
                    }
                }
            }
        }
        else {
            IcuSetSalaryPopView.show()
        }
    }
}

class IcuHourSalaryViewModel: NSObject {
    
    enum TimeType {
        case beforework
        case work
        case offwork
    }
    
    private(set) var timeType: TimeType = .beforework

    private(set) var timeText: String = ""
    private(set) var overTimeText: String = ""
    private(set) var buttonShowText: String = ""
    private(set) var realHourSalaryText: String = ""
    
    private(set) var realHourIsShow: Bool = true
    private(set) var subtractIsShow: Bool = false

    override init() {
        super.init()
        initialDatas()
    }
    
    private func initialDatas() {
        updateDatas()
    }
    
    public func updateDatas() {
        // 处理已经工作时长
        var timeRes: (Int, Int) = IcuPunchManager.shared.calcInterval(to: Date())
        let timeText = formatShowText(timeRes)
        self.timeText = timeText
        
        let currentHour = IcuDateHelper.shared.getHourAndMinute().0
        // 处理超出部分
        if currentHour >= 18 {
            let overtimeRes: (Int, Int) = IcuPunchManager.shared.calcOvertimeInterval(Date())
            overTimeText = "已经超过额定工时\(formatShowText(overtimeRes))"
        }
        else {
            overTimeText = "正常工作时间"
        }
        
        // 时薪模块
        if IcuCacheManager.get.hasSetSalary {
            buttonShowText = "下班结算"
        } else {
            buttonShowText = "想看看实际时薪吗？"
        }
        // 未设置金额 结束逻辑
        if !IcuCacheManager.get.hasSetSalary {
            realHourIsShow = false
            return
        }
        
        // 真实时薪数据更新
        /// 未上班情况
        if currentHour < 9 {
            buttonShowText = "还未上班哦"
            self.timeText = "0分钟"
            realHourIsShow = false
            timeType = .beforework
        }
        /// 上班过程中
        else if currentHour >= 9 && currentHour < 18 {
            buttonShowText = "上班中..."
            realHourIsShow = false
            timeType = .work
//
//            let hour: CGFloat = IcuPunchManager.shared.calcInterval(to: Date())
//            let hourSalary: CGFloat = IcuPunchManager.shared.calcHourSalary(hour)
//            realHourSalaryText = "￥" + String(format: "%.2f", hourSalary)
//            realHourIsShow = true
//            timeType = .offwork
        }
        /// 下班结算
        else {
            if IcuCacheManager.get.todayIsPunched {
                buttonShowText = "结算完成"
                guard let date = IcuCacheManager.get.punchTime else {
                    return
                }
                let hour: CGFloat = IcuPunchManager.shared.calcInterval(to: date)
                let hourSalary: CGFloat = IcuPunchManager.shared.calcHourSalary(hour)
                realHourSalaryText = "￥" + String(format: "%.2f", hourSalary)
                realHourIsShow = true

                // 重新处理工作时长
                timeRes = IcuPunchManager.shared.calcInterval(to: date)
                let timeText = formatShowText(timeRes)
                self.timeText = timeText
                timeType = .offwork
                
                // 处理超时文案
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "已于 HH:mm 完成打开"
                overTimeText = dateFormatter.string(from: date)
                return
            }
            // 未打卡
            else {
                buttonShowText = "下班结算"
                let hour: CGFloat = IcuPunchManager.shared.calcInterval(to: Date())
                let hourSalary: CGFloat = IcuPunchManager.shared.calcHourSalary(hour)
                realHourSalaryText = "￥" + String(format: "%.2f", hourSalary)
                realHourIsShow = true
                timeType = .offwork
            }
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
