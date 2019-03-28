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
    
    lazy private var testLabel: UILabel = {
        let label = UILabel()
        label.text = "ICU. Hello world"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        initialLayouts()
    }
    
    private func initialViews() {
        view.addSubview(testLabel)
    }
    
    private func initialLayouts() {
        testLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

