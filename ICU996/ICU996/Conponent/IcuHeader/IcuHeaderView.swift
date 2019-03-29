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
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, GUA!"
        label.font = UIFont.icuFont(.semibold, size: 13)
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
        
    }
    
    private func initialLayouts() {
        
    }
}
