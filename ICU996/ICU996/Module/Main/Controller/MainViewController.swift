//
//  ViewController.swift
//  ICU996
//
//  Created by Harry Duan on 2019/3/28.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import SnapKit
import KVOController

class MainViewController: UIViewController {
    
    public var viewModel: MainViewModel = MainViewModel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.view.frame.width,
                                 height: self.view.frame.height - 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.register(MainCalendarViewCell.self, forCellWithReuseIdentifier: "MainCalendarViewCell")
        collectionView.register(MainHourSalaryViewCell.self, forCellWithReuseIdentifier: "MainHourSalaryViewCell")
        return collectionView
    }()

    lazy var headerView: IcuHeaderView = {
        let view = IcuHeaderView()
        return view
    }()
    
    lazy var tabView: IcuTabView = {
        let view = IcuTabView()
        return view
    }()

    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navMenu"), for: .normal)
        button.addTarget(self, action: #selector(menuButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        initialLayouts()
        initialDatas()
    }
    
    private func initialViews() {
        
        tabView.changedCallBack = { [weak self] type in
            guard let self = self else { return }
            if type == .calendar {
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                 at: .left,
                                                 animated: true)
            }
            else if type == .hourSalary {
                self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0),
                                                 at: .left,
                                                 animated: true)
            }
        }
        
        headerView.addSubview(menuButton)
        view.addSubview(headerView)
        view.addSubview(tabView)
        view.addSubview(collectionView)
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
        menuButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(36)
        }
        tabView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func initialDatas() {}
    
    @objc func menuButtonClicked() {
        let feedbackVc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingViewController")
        let nav = UINavigationController(rootViewController: feedbackVc)
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tabView.changeToHourSalary()
        } else {
            tabView.changeToCalendar()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let vm = viewModel.cellModels[indexPath.row] as? MainCalendarViewCellModel {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCalendarViewCell", for: indexPath)
                as? MainCalendarViewCell {
                cell.viewModel = vm
                return cell
            }
        }
        else if let vm = viewModel.cellModels[indexPath.row] as? MainHourSalaryViewCellModel {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainHourSalaryViewCell", for: indexPath)
                as? MainHourSalaryViewCell {
                cell.viewModel = vm
                return cell
            }
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
}

class MainViewModel: NSObject {
    private(set) var cellModels: [AnyObject] = []

    override init() {
        super.init()
        initialDatas()
    }
    
    private func initialDatas() {
        cellModels.append(MainCalendarViewCellModel(calendarModel: IcuCalendarViewModel()))
        cellModels.append(MainHourSalaryViewCellModel(hourSalaryViewModel: IcuHourSalaryViewModel()))
    }
}

