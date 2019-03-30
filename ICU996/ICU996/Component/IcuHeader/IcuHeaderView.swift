//
//  IcuHeaderView.swift
//  ICU996
//
//  Created by Harry Twan on 2019/3/29.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import SnapKit

class IcuHeaderView: UIView {
    
    private var bakView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, 今天你996了吗？"
        label.font = UIFont.icuFont(.semibold, size: 28)
        label.textColor = UIColor.showColor()
        return label
    }()
    
    lazy private var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "工作再忙也别忘记按时下班哦!"
        label.font = UIFont.icuFont(size: 17)
        label.textColor = UIColor.showColor()
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
        bakView.addSubview(welcomeLabel)
        bakView.addSubview(promptLabel)
    }
    
    private func initialLayouts() {
        bakView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(44)
            make.height.equalTo(40)
        }
        
        promptLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom)
            make.leading.equalTo(welcomeLabel)
            make.height.equalTo(24)
        }
    }
    
    public func setWelcomLabelText(_ name:String) {
        welcomeLabel.text = "Hi, " + name
    }
}
