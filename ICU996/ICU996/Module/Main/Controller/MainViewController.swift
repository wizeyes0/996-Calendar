//
//  ViewController.swift
//  ICU996
//
//  Created by Harry Duan on 2019/3/28.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    lazy var headerView: IcuHeaderView = {
        let view = IcuHeaderView()
        return view
    }()
    
    lazy var tabView: IcuTabView = {
        let view = IcuTabView()
        return view
    }()
    
    lazy var calendarView: IcuCalendarView = {
        let view = IcuCalendarView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        initialLayouts()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let hasSetSalary = UserDefaults.standard.bool(forKey: "HasSetSalary")
        if !hasSetSalary {
            let startVc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ICUStartViewController")
            present(startVc, animated: true, completion: nil)
        }
    }
    private func initialViews() {
        view.addSubview(headerView)
        view.addSubview(tabView)
        view.addSubview(calendarView)
    }
    
    private func initialLayouts() {
        headerView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(self.view.snp.top).offset(44)
            }
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
        
        tabView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(44)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}


