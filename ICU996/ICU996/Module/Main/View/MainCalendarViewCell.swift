//
//  CalendarViewCell.swift
//  ICU996
//
//  Created by Harry Duan on 2019/3/31.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class MainCalendarViewCell: UICollectionViewCell {
    
    public var viewModel = MainCalendarViewCellModel(calendarModel: IcuCalendarViewModel()) {
        didSet {
            updateViews()
        }
    }
    
    lazy var calendarView: IcuCalendarView = {
        let view = IcuCalendarView()
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
        addSubview(calendarView)
    }
    
    public func updateViews() {
        calendarView.viewModel = self.viewModel.calendarModel
    }
    
    private func initialLayouts() {
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class MainCalendarViewCellModel: NSObject {
    
    private(set) var calendarModel: IcuCalendarViewModel
    
    init(calendarModel: IcuCalendarViewModel) {
        self.calendarModel = calendarModel
        super.init()
    }
}
