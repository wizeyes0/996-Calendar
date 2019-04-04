//
//  IcuCalendarView.swift
//  ICU996
//
//  Created by Harry Twan on 2019/3/29.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import DeviceKit
import LTMorphingLabel
import pop

class IcuCalendarView: UIView {
    
    public var viewModel: IcuCalendarViewModel {
        didSet {
            updateViews()
        }
    }

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
        label.font = UIFont.icuFont(.regular, size: 13)
        label.textAlignment = .center
        label.textColor = UIColor.quoteColor()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickQuote))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        label.addGestureRecognizer(tapRecognizer)
        return label
    }()
    
    lazy var offWorkButton: UIButton = {
        let button = UIButton.defaultGradient()
        button.setTitle("还不下班吗？", for: .normal)
        return button
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
        self.viewModel = IcuCalendarViewModel()
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
        bakView.addSubview(fromQuoteImageView)
        bakView.addSubview(toQuoteImageView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(heartbeatRefresh), name: .HeartbeatRefresh, object: nil)
    }
    
    @objc private func heartbeatRefresh() {
        viewModel.updateDatas()
        updateViews()
    }
    
    private func updateViews() {
        dateLabel.text = viewModel.dateText
        weekdayLabel.text = viewModel.weekdayText
        answerLabel.text = viewModel.doText
        downAnswerLabel.text = viewModel.reasonText
    }
    
    private func initialLayouts() {
        let device = Device()
        
        var _4inches: [Device] = [.iPhone5, .iPhone5s, .iPhoneSE, .iPhone4]
        for i in _4inches {
            _4inches.append(.simulator(i))
        }
        
        bakView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            if device.isOneOf(_4inches) {
                make.top.equalToSuperview().offset(3)
            } else {
                make.top.equalToSuperview().offset(15)
            }
            make.left.equalToSuperview().offset(20)
        }
        
        weekdayLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(dateLabel)
        }
        
        upAnswerLabel.snp.makeConstraints { make in
            if device.isOneOf(_4inches) {
                make.top.equalToSuperview().offset(50)
            } else {
                make.top.equalToSuperview().offset(118)
            }
            make.centerX.equalToSuperview()
        }
        
        fromQuoteImageView.snp.makeConstraints { make in
            make.right.equalTo(upAnswerLabel.snp.left).offset(-6)
            make.bottom.equalTo(upAnswerLabel.snp.centerY)
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
        
        toQuoteImageView.snp.makeConstraints { make in
            make.left.equalTo(downAnswerLabel.snp.right).offset(6)
            make.bottom.equalTo(downAnswerLabel.snp.centerY)
        }
        
        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(downAnswerLabel.snp.bottom).offset(31)
            make.centerX.equalTo(downAnswerLabel)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    @objc private func clickQuote() {
        guard let firstAnim = POPSpringAnimation(propertyNamed: kPOPViewAlpha) else {
            return
        }
        guard let secondAnim = POPSpringAnimation(propertyNamed: kPOPViewAlpha) else {
            return
        }
        firstAnim.fromValue = 1
        firstAnim.toValue = 0
        secondAnim.fromValue = 0
        secondAnim.toValue = 1
        firstAnim.completionBlock = { _, _ in
            self.quoteLabel.text = ICUSaying.nightSaying()
            self.quoteLabel.pop_add(secondAnim, forKey: "alpha2")
        }
        quoteLabel.pop_add(firstAnim, forKey: "alpha1")
    }
}
