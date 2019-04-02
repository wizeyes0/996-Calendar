//
//  MainHourSalaryCell.swift
//  ICU996
//
//  Created by Harry Twan on 2019/4/2.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class MainHourSalaryViewCell: UICollectionViewCell {
    
    public var viewModel = MainHourSalaryViewCellModel(hourSalaryViewModel: IcuHourSalaryViewModel()) {
        didSet {
            updateViews()
        }
    }
    
    lazy private var hourSalaryView: IcuHourSalaryView = {
        let view = IcuHourSalaryView()
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
        addSubview(hourSalaryView)
    }
    
    public func updateViews() {
        hourSalaryView.viewModel = viewModel.hourSalaryViewModel
    }
    
    private func initialLayouts() {
        hourSalaryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class MainHourSalaryViewCellModel: NSObject {
    
    private(set) var hourSalaryViewModel: IcuHourSalaryViewModel

    init(hourSalaryViewModel: IcuHourSalaryViewModel) {
        self.hourSalaryViewModel = hourSalaryViewModel
        super.init()
    }
}
